#' A ImputeTransformScale 
#'
#' This function median Imputation, transformation and scaling by different
#' @param Data data-frame with column names
#' @param dropList exclude columns, default is NULL
#' @param Impute whether to perform median imputation, default is TRUE
#' @param Transform whether to perform log 10 transformation, default is TRUE
#' @param Scaling whether to perform scaling, default is TRUE
#' @param ScaleType Scaling method, either of "Centering", "Auto", "Range","Pareto", "Vast", "Level".
#' @keywords Imputations, transformation, Scaling
#' @export
#' @examples
#' ImputeTransformScale (Data = Data, exclude = TRUE, dropList = NULL, Impute = TRUE, Transform = TRUE, Scaling = TRUE, 
#' ScaleType = c("Centering", "Auto", "Range","Pareto", "Vast", "Level"))

ImputeTransformScale <- function(Data, 
                                 exclude = TRUE, 
                                 dropList = NULL,
                                 Impute = FALSE,
                                 Transform = FALSE,
                                 Scaling = FALSE,
                                 ScaleType) {
  ## subset data
  DataToScale <- Data[, !colnames(Data) %in% dropList]
  nCol <- ncol(DataToScale)
  ## empty data-frame
  scaleData <- data.frame(matrix(NA, nrow = nrow(Data), ncol = nCol))
  ## column names to empty dataframe
  colnames(scaleData) <- colnames(DataToScale)
  
  for (i in 1:nCol) {
    if (class(DataToScale[[i]]) == "numeric") {
      ## select metabolite
      met <- colnames(DataToScale)[[i]]
      if (Impute == TRUE) {
        ## median of data
        impute <- median(DataToScale[[i]], na.rm = TRUE)
        ## median imputation
        DataToScale[is.na(DataToScale[[i]]), i] <- impute
      }
      if (Transform == TRUE) {
        ## transformed data
        DataToScale[[i]] <- log10(DataToScale[[i]])
      }
      if (Scaling == TRUE) {
        ## mean of data
        mean <- mean(DataToScale[[i]], na.rm = TRUE)
        ## centred data
        centreData <- DataToScale[[i]] - mean
        ## sd data
        sd <- sd(centreData, na.rm = TRUE)
        ## min
        min <- min(DataToScale[[i]])
        ## max
        max <- max(DataToScale[[i]])
        ## centering
        if (ScaleType == "Centering") {
          scaleData[[met]] <- centreData
        }
        ## Auto-scaling
        else if (ScaleType == "Auto") {
          scaleData[[met]] <- centreData / sd
        }
        ## range scaling
        else if (ScaleType == "Range") {
          scaleData[[met]] <- (DataToScale[[i]] - min) / (max - min)
        }
        ## pareto scaling
        else if (ScaleType == "Pareto") {
          scaleData[[met]] <- centreData / sqrt(sd)
        }
        ## vast scaling
        else if (ScaleType == "Vast") {
          scaleData[[met]] <- (centreData / mean) * (mean /sd)
        }
        ## level scaling
        else if (ScaleType == "Level") {
          scaleData[[met]] <- (centreData) / mean
        }
      }
    } else
    DataToScale[[i]] <- DataToScale[[i]]
  }
  name <- dropList
  scaledData <- cbind(scaleData, name=Data[,colnames(Data) %in% dropList])
  colnames(scaledData)[colnames(scaledData) %in% "name"] <- dropList
  return(scaledData)
}