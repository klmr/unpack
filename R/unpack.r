`[<-.unpack` = function (x, ..., value) {
    assign('*unpack_names*', match.call(expand.dots = FALSE)$..., envir = parent.frame())
    assign('*unpack_value*', value, envir = parent.frame())

    eval.parent(quote(on.exit({
        rm(c)
        makeActiveBinding(
            'c',
            function (rhs) {
                assign_all = function (names, values, envir) {
                    valid = vapply(names, is.name, logical(1L))
                    if (! all(valid)) {
                        first_invalid = names[! valid][[1L]]
                        stop(sQuote(deparse(first_invalid)), ' is not a valid variable name.')
                    }

                    names = vapply(names, deparse, character(1L))
                    list2env(setNames(as.list(values), names), envir = envir)
                }

                caller = parent.frame()
                names = caller$`*unpack_names*`
                value = caller$`*unpack_value*`
                rm(c, `*unpack_names*`, `*unpack_value*`, envir = caller)

                if (length(names) > length(value)) {
                    stop('Too many names to receive ', length(value), ' values')
                }

                if (length(names) < length(value)) {
                    last = names[[length(names)]]

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
            environment()
        )
    })))

    invisible(x)
}

print.unpack = function (x, ...) {
    cat('\u2039syntax: unpack\u203a\n')
    invisible(x)
}

c = structure(list(), class = 'unpack')
