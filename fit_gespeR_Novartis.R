require(Matrix)
require(gespeR)
require(dplyr)

setwd("./")


## Read target relations
X <- TargetRelations(targets="IFX_QIAGEN.rds")


## Read phenotypes
phenos <- readRDS("BoP_TGFbsignaling_A549_high_TGFb1_tr.rds") %>%
	filter(CODE_NVS %in% X@siRNAs) %>%
	select(ID = CODE_NVS, Score = PHENOTYPE)
phenos <- phenos[match(X@siRNAs, phenos$ID),]
phenos <- Phenotypes(phenotypes = Matrix(phenos$Score, dimnames = list(phenos$ID, "TGFbsignaling_A549_high_TGFb1")), type = "SSP")
phenos <- phenos[!is.na(phenos@values[,1]),]


## Shrink X to non-NA phenotypes and convert non-0's to 1's
X <- X[match(phenos@ids, X@siRNAs),]
X@values[which(X@values > 0)] <- 1


## Fit gesepR model
cv.gesp <- gespeR(phenotypes = phenos, target.relations = X, mode = "cv", alpha = 0.5, ncores = 16)
saveRDS(cv.gesp, file = "gespeR_TGFbsignaling_A549_high_TGFb1_tr.rds")
