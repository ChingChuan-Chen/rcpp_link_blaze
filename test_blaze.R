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
# Unit: microseconds
#   expr     min      lq     mean  median      uq      max neval
#  blaze 168.228 169.983 195.6315 173.640 202.750  312.172    30
#      R 554.126 559.099 632.9047 562.757 660.328 1506.730    30

