## ---- include = FALSE----------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup---------------------------------------------------------------
library(rray)
library(magrittr)

## ------------------------------------------------------------------------
x <- matrix(1:6, nrow = 2)
y <- matrix(1:2, nrow = 2)

# Base R matrices, added with broadcasting
rray_add(x, y)

## ------------------------------------------------------------------------
x <- array(1:8, c(2, 2, 2))

rray_sum(x, axes = 1)

apply(x, MARGIN = c(2, 3), FUN = sum)

## ------------------------------------------------------------------------
# (5, 1)
x <- matrix(1:5)

# (3)
y <- 6:8

rray_bind(x, y, .axis = 1)

## ------------------------------------------------------------------------
# (5, 1) where `. = 5` from x
x_broadcast <- rray_broadcast(x, c(5, 1))
x_broadcast

# (3, 1) where `. = 3` from y
y_broadcast <- rray_broadcast(y, c(3, 1))
y_broadcast

rray_bind(x_broadcast, y_broadcast, .axis = 1)

## ------------------------------------------------------------------------
rray_bind(x, x, .axis = 3)

## ------------------------------------------------------------------------
x_broadcast <- rray_broadcast(x, c(5, 1, 1))
x_broadcast

rray_bind(x_broadcast, x_broadcast, .axis = 3)

## ------------------------------------------------------------------------
x <- matrix(1:6, ncol = 2)
x_rray <- as_rray(x)

x[1,]
x_rray[1,]

apply(x, 2, sum)
rray_sum(x, axes = 1)

## ------------------------------------------------------------------------
x_rray / rray_sum(x_rray, axes = 1)

## ------------------------------------------------------------------------
x / apply(x, 2, sum)

# Equivalent to 
col_sums <- apply(x, 2, sum)
partially_recycled <- matrix(rep(col_sums, times = 3), ncol = 2)
partially_recycled

x / partially_recycled

## ------------------------------------------------------------------------
x_sum <- rray_sum(x_rray, axes = 1)

# When `/` is called, the inputs are broadcast to the same shape, like this
dim <- rray_dim_common(x_rray, x_sum)
x_broadcast <- rray_broadcast(x_rray, dim)
x_sum_broadcast <- rray_broadcast(x_sum, dim)

x_broadcast

x_sum_broadcast

x_broadcast / x_sum_broadcast

## ------------------------------------------------------------------------
x_rray %>%
  rray_sum(axes = 1) %>%
  rray_squeeze(axes = 1)

## ---- error=TRUE---------------------------------------------------------
# This is the result you'd get in a NumPy sum. The 1st dimension is dropped
x_sum_dropped <- rray_squeeze(rray_sum(x_rray, axes = 1), axes = 1)
x_sum_dropped

# Now broadcasting doesn't work!
x_rray / x_sum_dropped

# So you have to add back the dimension
# (numpy has slightly cleaner ways to do this, but it's still an extra step)
x_sum_reshaped <- rray_expand(x_sum_dropped, 1)
x_rray / x_sum_reshaped

