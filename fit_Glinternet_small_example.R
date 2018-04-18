require(Matrix)
require(dplyr)
require(glinternet)

X = readRDS("X_for_glinternet_small_example.rds")
Y = readRDS("Y_for_glinternet_small_example.rds")

"Fitting had started at:"
Sys.time()

cv.glinternet <- glinternet.cv(X = X@values %>% as.matrix,
                               Y %>% as.numeric,
                               numLevels = rep(1, X@genes %>% length),
                               family = "gaussian",
                               numCores = 96,
			       nLambda = 25,
                               nFolds = 5,
                               verbose = TRUE)
saveRDS(cv.glinternet, file = "cv_glinternet.rds")
