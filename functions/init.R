# Loads all packages & sources all scripts
# also sets globals
# 
# Author: PeterE2
###############################################################################
 here::here()

# Load required packages
require(reshape2)
require(glmnet)
require(ROCR)
require(ggplot2)
require(car)
require(scales)
require(digest)
# require(pamr) # disabled until further testing is complete
# Source all necessary scripts

source("./packageElasticNet/batch.process.R")
source("./packageElasticNet/StartLogging.R")
source("./packageElasticNet/WarnStop.R")
source("./packageElasticNet/captureOutput.R")
source("./packageElasticNet/ScriptVersion.R")
source("./packageElasticNet/data.io.R")
source("./packageElasticNet/classes.R")
source("./packageElasticNet/generate.biomarker.R")
source("./packageElasticNet/nominate.biomarker.R")
source("./packageElasticNet/cross.validate.R")


source("./packageElasticNet/valid.task.check.R")

source("./packageElasticNet/dap.legacy/joinData.R")
source("./packageElasticNet/dap.legacy/splitData.R")


source("./packageElasticNet/features/feature.manager.R")

source("./packageElasticNet/general.preprocessing/imputation.R")
source("./packageElasticNet/general.preprocessing/scaling.R")
source("./packageElasticNet/general.preprocessing/preprocessing.R")

source("./packageElasticNet/problems/stat.problem.R")
source("./packageElasticNet/problems/binary.R")
source("./packageElasticNet/problems/continuous.R")
source("./packageElasticNet/problems/multiclass.R")
source("./packageElasticNet/problems/univariate.R")
source("./packageElasticNet/problems/multiclass.concurrent.R")

source("./packageElasticNet/handlers/handler.R")
source("./packageElasticNet/handlers/cv.handler.R")
source("./packageElasticNet/handlers/nomination.handler.R")

source("./packageElasticNet/models/stat.model.R")
source("./packageElasticNet/models/elastic.net.R")
source("./packageElasticNet/models/univariate/elastic.net.R")
source("./packageElasticNet/models/multiclass/elastic.net.R")
source("./packageElasticNet/models/univariate/continuous/multiple.linear.models.R")
source("./packageElasticNet/models/univariate/continuous/multiple.linear.models.corrected.R")

source("./packageElasticNet/models/multiclass.concurrent/multiclass.concurrent.model.R")
source("./packageElasticNet/models/multiclass.concurrent/multiclass.concurrent.elastic.net.R")
#source("./models/multiclass/pam.R") # disabled until further testing is complete

source("./packageElasticNet/search/common.R")
source("./packageElasticNet/search/no.selection.R")
source("./packageElasticNet/search/forward.R")
source("./packageElasticNet/search/univariate.search.R")
#source("./search/multistep.R")
source("./packageElasticNet/search/exhaustive.forward.R")

source("./packageElasticNet/tables/binary.R")
source("./packageElasticNet/tables/continuous.R")
source("./packageElasticNet/tables/multiclass.R")

source("./packageElasticNet/plots/general.helpers.R")
source("./packageElasticNet/plots/Q2plot.R")
source("./packageElasticNet/plots/multiclass.plot.R")
source("./packageElasticNet/plots/ROC.R")

source("./packageElasticNet/checktool/checktool.R")
# Set globals

manual.stop <<- FALSE # check for manual stop of script
standard.seed <<- 35453 # SHOULD NEVER BE CHANGED!!!
set.seed(standard.seed)
log.level <<- 0 # the higher the log level the more information will be in the scripts, don't set smaller than 0
# Get default algorithms
default.algorithms <<- read.delim("./packageElasticNet/defaults/algorithms.txt", stringsAsFactors = FALSE)
options(digits=7)

