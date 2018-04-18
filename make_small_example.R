## This script produces two files called X_for_glinternet_small_example.rds and Y_for_glinternet_small_example.rds which are the first n (see below) data points from the original fake data

require(Matrix)

# Set the size of the small example:
n = 100

X = readRDS("X_for_glinternet.rds")
Y = readRDS("Y_for_glinternet.rds")
X <- X[1:n,]
Y <- Y[1:n]
saveRDS(X, file = "X_for_glinternet_small_example.rds")
saveRDS(Y, file = "Y_for_glinternet_small_example.rds")
