# This object acts as a proxy to intercept subset assignment via `[<-`, which we
# overwrite in `[<-.unpack` to perform the vector unpacking.
c = structure(list(), class = 'unpack')

`[<-.unpack` = function (x, ..., value) {
    names = match.call(expand.dots = FALSE)$...
    caller = parent.frame()

    # `c` was already pulled into the caller scope at this point.
    rm(c, envir = caller)

    makeActiveBinding(
        'c',
        function (rhs) {
            rm(c, envir = caller)

            if (length(names) > length(value)) {
                stop('Too many names to receive ', length(value), ' values')
            }

            if (length(names) < length(value)) {
                last = names[[length(names)]]

                # Is last name of the form `name[]`?
                if (
                    length(last) != 3L ||
                    ! identical(last[[1L]], as.name('[')) ||
                    ! is.name(last[[2L]]) ||
                    ! identical(last[[3L]], quote(expr = ))
                ) {
                    stop('Not enough names to receive ', length(value), ' values')
                }

                names = names[-length(names)]
                named_indices = seq_along(names)
                assign_all(names, value[named_indices], caller)
                assign(deparse(last[[2L]]), value[-named_indices], caller)
            } else {
                assign_all(names, value, caller)
            }
        },
        caller
    )

    invisible(x)
}

# Helper function that assigns a number of values to names, after checking that
# the list of expressions provided as names are actually valid R name
# expressions (via `is.name`).
assign_all = function (names, values, envir) {
    valid = vapply(names, is.name, logical(1L))
    if (! all(valid)) {
        first_invalid = names[! valid][[1L]]
        stop(sQuote(deparse(first_invalid)), ' is not a valid variable name.')
    }

    names = vapply(names, deparse, character(1L))
    list2env(stats::setNames(as.list(values), names), envir = envir)
}

print.unpack = function (x, ...) {
    cat('\u2039syntax: unpack\u203a\n')
    invisible(x)
}
