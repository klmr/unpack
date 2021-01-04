\name{unpack}
\alias{c}
\alias{unpack}
\alias{[<-.unpack}
\title{Unpack values}
\description{
    The syntax \code{c[...] = value} unpacks the vector or list \code{value}
    into as many separate variables, specified as \code{...}, as there are
    items.
}
\usage{
c[\dots] = value
}
\arguments{
    \item{\dots}{variable names to assign to.}
    \item{value}{vector or list to unpack.}
}
\details{
    The number of names in \code{\dots} must match \code{length(value)}. If
    there are too few or too many names, an error is raised.

    An exception is made when the last name in \code{\dots} is an index-less
    subset expression, i.e. \code{name[]}. In that case, the first \var{N}-1
    elements from \code{value} are assigned to the first \var{N}-1 variable
    names, and the remaining elements are assigned to \code{name}.
}
