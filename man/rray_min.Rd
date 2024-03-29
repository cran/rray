% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/reducers.R
\name{rray_min}
\alias{rray_min}
\title{Calculate the minimum along an axis}
\usage{
rray_min(x, axes = NULL)
}
\arguments{
\item{x}{A vector, matrix, or array to reduce.}

\item{axes}{An integer vector specifying the axes to reduce over. \code{1} reduces
the number of rows to 1, performing the reduction along the way. \code{2} does the
same, but with the columns, and so on for higher dimensions. The default
reduces along all axes.}
}
\value{
The result of the reduction with the same shape as \code{x}, except
along \code{axes}, which have been reduced to size 1.
}
\description{
\code{rray_min()} computes the minimum along a given axis or axes. The
dimensionality of \code{x} is retained in the result.
}
\examples{

x <- rray(1:10, c(5, 2))

rray_min(x)

rray_min(x, 1)

rray_min(x, 2)

}
\seealso{
Other reducers: \code{\link{rray_max}},
  \code{\link{rray_mean}}, \code{\link{rray_prod}},
  \code{\link{rray_sum}}
}
\concept{reducers}
