## -----------------------------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## -----------------------------------------------------------------------------
library(rray)

## -----------------------------------------------------------------------------
x <- array(1:8, c(2, 2, 2))

rray_sum(x, axes = 1)

apply(x, MARGIN = c(2, 3), FUN = sum)

## -----------------------------------------------------------------------------
# (5, 1)
x <- matrix(1:5)

# (3)
y <- 6:8

rray_combine(x, y, .axis = 1)

## -----------------------------------------------------------------------------
x <- array(1:6, dim = c(3, 2))
x

y <- array(1:9, dim = c(3, 3))
y

z <- 10L

combined <- rray_combine(x, y, z, .axis = 2)
combined

## -----------------------------------------------------------------------------
rray_split(combined, axis = 2, dimensions = c(2, 3, 1))

## -----------------------------------------------------------------------------
try({
x <- matrix(1:4, nrow = 2)
x

y <- matrix(5:8, nrow = 2)
y

rray_combine(x, y, .axis = 3)
})

## -----------------------------------------------------------------------------
stacked <- rray_stack(x, y, .axis = 3)
stacked

## -----------------------------------------------------------------------------
# Expand to 3D
x_3d <- rray_insert_axes(x, axes = 3)
y_3d <- rray_insert_axes(y, axes = 3)

# Now we can combine
rray_combine(x_3d, y_3d, .axis = 3)

## -----------------------------------------------------------------------------
x

y

rray_stack(x, y, .axis = 2)

## -----------------------------------------------------------------------------
stacked

rray_unstack(stacked, axis = 3)

## -----------------------------------------------------------------------------
x <- matrix(1:6, ncol = 2)

x[1,]
rray_slice_rows(x, 1)

apply(x, 2, sum)
rray_sum(x, axes = 1)

## -----------------------------------------------------------------------------
rray_divide(x, rray_sum(x, axes = 1))

## -----------------------------------------------------------------------------
x / apply(x, 2, sum)

# Equivalent to
col_sums <- apply(x, 2, sum)
partially_recycled <- matrix(rep(col_sums, times = 3), ncol = 2)
partially_recycled

x / partially_recycled

## -----------------------------------------------------------------------------
sweep(x, 2, apply(x, 2, sum), FUN = "/")

## -----------------------------------------------------------------------------
x |>
  rray_sum(axes = 1) |>
  rray_remove_axes(axes = 1)

## -----------------------------------------------------------------------------
try({
# This is the result you'd get in a NumPy sum. The 1st axis is dropped.
x_sum_dropped <- rray_remove_axes(rray_sum(x, axes = 1), axes = 1)
x_sum_dropped

# Now broadcasting doesn't work!
rray_divide(x, x_sum_dropped)

# So you have to add back the axis manually
# (NumPy has slightly cleaner ways to do this, but it's still an extra step)
x_sum_reshaped <- rray_insert_axes(x_sum_dropped, axes = 1)
rray_divide(x, x_sum_reshaped)
})

