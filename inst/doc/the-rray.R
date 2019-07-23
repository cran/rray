## ---- include = FALSE----------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup---------------------------------------------------------------
library(rray)
library(vctrs)

## ------------------------------------------------------------------------
x_mat <- matrix(1:6, ncol = 2)
x_mat

x_mat[1:2,]

x_mat[1L,]

x_mat[,1:2]

x_mat[,1L]

## ------------------------------------------------------------------------
x_mat[1, , drop = FALSE]

## ------------------------------------------------------------------------
x_3D <- array(1:12, c(2, 3, 2))
x_4D <- array(1:12, c(2, 3, 2, 1))

x_3D[1, , , drop = FALSE]

x_4D[1, , , , drop = FALSE]

## ---- error = TRUE-------------------------------------------------------
x_3D_rray <- as_rray(x_3D)

# First row, but still 3D
x_3D_rray[1]

# Trailing commas are ignored, so this is the same as above
x_3D_rray[1,]

# In base R this is an error
x_3D[1,]

## ------------------------------------------------------------------------
x_3D_rray[, 1L]

x_3D_rray[, 1:2]

## ---- error = TRUE-------------------------------------------------------
x_3D[1, 1]

rray_subset(x_3D, 1, 1)

# Same as with the rray
rray_subset(x_3D_rray, 1, 1)

## ------------------------------------------------------------------------
# Positions 1 and 2
x_3D[1:2]

# Positions 2 and 3
# Correspond to elements at indices: 
# (2, 1, 1) and (1, 2, 1)
x_3D[2:3]

rray_dim(x_3D[1:2])
rray_dim(x_3D[1:2,,])
rray_dim(x_3D[,1:2,])
rray_dim(x_3D[,,1:2])

## ------------------------------------------------------------------------
x_3D_rray[2]

# Same as this
x_3D_rray[2,]

## ------------------------------------------------------------------------
# First 3 positions
x_3D_rray[[1:3]]

rray_yank(x_3D_rray, 1:3)

## ------------------------------------------------------------------------
dummy <- x_3D_rray

# Set the first row to NA
dummy[1] <- NA

# Set NA values to 0
dummy[[is.na(dummy)]] <- 0

dummy

## ------------------------------------------------------------------------
rray_subset(x_3D_rray, 1)

rray_extract(x_3D_rray, 1)

## ------------------------------------------------------------------------
x_row_nms <- matrix(1:2, dimnames = list(c("r1", "r2")))
x_col_nms <- matrix(1:2, dimnames = list(NULL, c("c1")))

x_row_nms

x_col_nms

# names from x_row_nms are used
x_row_nms + x_col_nms

# names from x_col_nms are used
x_col_nms + x_row_nms

## ------------------------------------------------------------------------
x_row_nms_rray <- as_rray(x_row_nms)
x_col_nms_rray <- as_rray(x_col_nms)

x_row_nms_rray + x_col_nms_rray

x_col_nms_rray + x_row_nms_rray

## ------------------------------------------------------------------------
x_col_and_row_nms_rray <- rray_set_row_names(x_col_nms_rray, c("row1", "row2"))
x_col_and_row_nms_rray

x_row_nms_rray + x_col_and_row_nms_rray

x_col_and_row_nms_rray + x_row_nms_rray

## ------------------------------------------------------------------------
rray_dim_names_common(x_row_nms, x_col_nms)

