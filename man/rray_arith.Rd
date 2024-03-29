% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/arith.R
\name{rray_arith}
\alias{rray_arith}
\alias{\%b+\%}
\alias{rray_add}
\alias{\%b-\%}
\alias{rray_subtract}
\alias{\%b*\%}
\alias{rray_multiply}
\alias{\%b/\%}
\alias{rray_divide}
\alias{\%b^\%}
\alias{rray_pow}
\alias{rray_identity}
\alias{rray_opposite}
\title{Arithmetic operations}
\usage{
x \%b+\% y

rray_add(x, y)

x \%b-\% y

rray_subtract(x, y)

x \%b*\% y

rray_multiply(x, y)

x \%b/\% y

rray_divide(x, y)

x \%b^\% y

rray_pow(x, y)

rray_identity(x)

rray_opposite(x)
}
\arguments{
\item{x, y}{A pair of vectors.}
}
\value{
The value of the arithmetic operation, with dimensions identical to the
common dimensions of the input.
}
\description{
These functions provide the implementations for their underlying infix
operators (i.e. \code{rray_add()} powers \code{+}). All operators apply broadcasting
to their input.
}
\details{
In case you want to apply arithmetic operations with broadcasting to
purely base R objects using infix operators, custom infix functions have
been exported, such as \code{\%b+\%}, which will perform addition with
broadcasting no matter what type the input is.
}
\examples{
library(magrittr)

x <- rray(1:8, c(2, 2, 2)) \%>\%
  rray_set_row_names(c("r1", "r2")) \%>\%
  rray_set_col_names(c("c1", "c2"))

y <- matrix(1:2, nrow = 1)

# All arithmetic functions are applied with broadcasting
rray_add(x, y)

# And the power `+` when any underlying input
# is an rray
x + y

# If you happen to only have base R matrices/arrays
# you can use `rray_add()` or `\%b+\%` to get the
# broadcasting behavior
rray_add(y, matrix(1:2))

y \%b+\% matrix(1:2)

}
