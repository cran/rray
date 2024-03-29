% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/rray.R
\name{new_rray}
\alias{new_rray}
\title{Create a new rray}
\usage{
new_rray(.data = numeric(0), size = 0L, shape = integer(0),
  dim_names = NULL, ..., subclass = character(0))
}
\arguments{
\item{.data}{A numeric vector with no attributes representing
the data.}

\item{size}{An integer. The number of \emph{observations} in the object.
This is equivalent to the number of rows.}

\item{shape}{An integer vector. The shape corresponds to all of the
dimensions in the object except for the first one (the \code{size}).}

\item{dim_names}{A list. For no names, \code{NULL}, in which case a list of
empty characters will be constructed. Otherwise the list must
be the same length as the total number of dimensions
(i.e \code{length(c(size, shape))}). Each element of the list much be either
a character vector the same size as the corresponding dimension, or
\code{character(0)} for no names for that dimension.}

\item{...}{Name-value pairs defining attributes.}

\item{subclass}{The name of the subclass.}
}
\value{
A new rray.
}
\description{
Low level constructor for rray objects
}
\examples{

rray_ex <- new_rray(
  .data = 1:10,
  size = 5L,
  shape = 2L,
  dim_names = list(character(), c("a", "b"))
)

rray_ex

}
