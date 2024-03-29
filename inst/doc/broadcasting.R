## ----setup, include = FALSE----------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ------------------------------------------------------------------------
library(rray)

## ---- error = TRUE-------------------------------------------------------
x <- matrix(1:6, nrow = 3)
x

x + 1

x + matrix(1)

## ------------------------------------------------------------------------
x

x + 1

y <- rray(1, c(1, 1))
y

x + y

## ------------------------------------------------------------------------
y_broadcast <- rray_broadcast(y, c(3, 2))

y_broadcast

x + y_broadcast

## ------------------------------------------------------------------------
x

y

## ------------------------------------------------------------------------
dim <- rray_dim_common(x, y)
dim

x_broadcast <- rray_broadcast(x, dim)
x_broadcast

y_broadcast <- rray_broadcast(y, dim)
y_broadcast

x_broadcast + y_broadcast

## ------------------------------------------------------------------------
# Both are base R objects, but are added with broadcasting!
rray_add(x, as_matrix(y))

## ------------------------------------------------------------------------
z <- rray(c(1L, 2L, 3L))
z

x + z

## ------------------------------------------------------------------------
z

rray_broadcast(z, c(3, 1))

rray_broadcast(z, c(3, 2))

## ------------------------------------------------------------------------
dim <- rray_dim_common(x, z)
dim

x_broadcast <- rray_broadcast(x, dim)
z_broadcast <- rray_broadcast(z, dim)

x_broadcast + z_broadcast

## ------------------------------------------------------------------------
a <- rray(1:3, c(1, 3))
a

b <- rray(1:8, c(4, 1, 2))
b

## ------------------------------------------------------------------------
a + b

## ------------------------------------------------------------------------
a

rray_broadcast(a, c(1, 3, 1))

rray_broadcast(a, c(4, 3, 1))

rray_broadcast(a, c(4, 3, 2))

## ------------------------------------------------------------------------
b

rray_broadcast(b, c(4, 3, 2))

## ------------------------------------------------------------------------
dim <- rray_dim_common(a, b)

a_broadcast <- rray_broadcast(a, dim)
b_broadcast <- rray_broadcast(b, dim)

a_broadcast + b_broadcast

## ------------------------------------------------------------------------
x

x * 2

## ------------------------------------------------------------------------
vec_1 <- c(1, 2, 3)

x

x + vec_1

# Equivalent to:
x + rep(vec_1, 2)

## ------------------------------------------------------------------------
vec_2 <- c(1, 2)

x + vec_2

## ------------------------------------------------------------------------
recycled <- matrix(NA, 3, 2)

recycled[1, 1] <- vec_2[1]
recycled[2, 1] <- vec_2[2]
recycled[3, 1] <- vec_2[1]
recycled[1, 2] <- vec_2[2]
recycled[2, 2] <- vec_2[1]
recycled[3, 2] <- vec_2[2]

recycled

x + recycled

## ---- error = TRUE-------------------------------------------------------
x_rray <- as_rray(x)

x_rray + vec_2

## ------------------------------------------------------------------------
# (3) -> (3, 1)
as.matrix(1:3)

