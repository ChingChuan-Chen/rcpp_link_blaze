useBlaze26 <- FALSE
if (useBlaze26) {
  Sys.setenv("PKG_LIBS" = "-Iblaze26 $(LAPACK_LIBS) $(BLAS_LIBS) $(FLIBS)")
} else {
  Sys.setenv("PKG_LIBS" = "-Iblaze3 $(LAPACK_LIBS) $(BLAS_LIBS) $(FLIBS)")
}
Rcpp::sourceCpp("test_blaze.cpp")

test_blaze1(1:5)
test_blaze1(rnorm(5))

test_blaze2(matrix(1:9, 3, 3))
test_blaze2(matrix(rnorm(9), 3, 3))

X <- matrix(rnorm(9), 3, 3)
y <- rnorm(3)
all.equal(test_blaze3(X, y), as.vector(X %*% y)) # TRUE

library(microbenchmark)
M <- 6e3L
N <- 3e4L
X <- matrix(rnorm(M * N), M, N)
y <- rnorm(N)
microbenchmark(
  blaze = test_blaze3(X, y),
  R = as.vector(X %*% y),
  times = 50L
)
# Unit: milliseconds
#   expr       min        lq      mean   median        uq      max neval
#  blaze  71.85781  73.24371  75.09043  73.9036  75.86864  84.0395    50
#      R 229.66355 232.81744 237.53576 235.3185 239.67701 255.2478    50

