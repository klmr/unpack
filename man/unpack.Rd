\name{unpack}
\alias{c}
\title{Unpack values}
\description{
    The syntax \code{c[...] = values} unpacks the vector or list \code{values}
    into as many separate variables, specified as \code{...}, as there are
    items.
}
\usage{
c[...] = values
}
\arguments{
    \item{...}{the variable names to assign to}
    \item{values}{the vector or list to unpack}
}
\details{
    The number of names in \code{...} must match \code{length(values)}. If there
    are too few or too many names, an error is raised.

    An exception is made when the last name in \code{...} is an index-less
    subset expression, i.e. \code{name[]}. In that case, the first \var{N}-1
    elements from \code{values} are assigned to the first \var{N}-1 variable
    names, and the remaining elements are assigned to \code{name}.
}
