
## install required packages
#install.packages("pcalg")
#install.packages("bnlearn")
#devtools::install_github("bips-hb/tpc")
#devtools::install_github("bips-hb/micd")
## load required packages
library(bnlearn)
library(pcalg)
library(micd)
library(tpc)
library(tidyverse)
## load cohort data and create cross-sectional version of the dataset
orders <- read.csv("train.csv", header=TRUE, sep=',')
dat_cross <- orders[ ,1:11]

#colnames(dat_cross)

pcalg_fit_mix <- pc(suffStat = dat_cross, indepTest = mixCItest, alpha = 0.05,
                    labels = colnames(dat_cross), u2pd="relaxed",
                    skel.method = "stable", maj.rule = TRUE, solve.confl =FALSE)

mygraph <- function(pcgraph){
  g <- as.bn(pcgraph, check.cycles = FALSE)
  graphviz.plot(g, shape = "ellipse")
}
mygraph(pcalg_fit_mix)

bnlearn_fit_mix <- pc.stable(dat_cross, test = "mi-cg", alpha = 0.01)
graphviz.plot(bnlearn_fit_mix, shape = "ellipse")


