#' A ImputeTransformScale 
#'
#' This function is fro install and load packages
#' @param x list of packages to load
#' @keywords install, load cran and bioconductor packages 
#' @export
#' @examples
#' installScriptLibs(x)

installScriptLibs <- function(x) {
  for (i in 1:length(x)) {
    if ((x[i] %in% .packages(all.available = TRUE)) == TRUE) {
      eval(parse(text = paste("require(", x[i], ")", sep = "")))
    } else if (x[i] %in% BiocManager::available(x[i])) {
      eval(parse(text = paste(
        "BiocManager::install('", x[i], "')", sep = ""
      )))
    } else {
      eval(parse(text = paste(
        "install.packages('", x[i], "')", sep = ""
      )))
      eval(parse(text = paste(
        "install.packages('", x[i], "')", sep = ""
      )))
    }
  }
}

#' print banner
#'
#' This function is to print header
#' @param txt text to print
#' @param txt symbols for brackets eg. "="
#' @keywords banner
#' @export
#' @examples
#' installScriptLibs(x)

banner <-function(txt, Char ="-") {
  nchar <- 64
  ## head tail
  headTail <- strrep(Char, nchar)
  hash <- paste0("##")
  charEnd <- strrep(Char,2)
  headTailSent <- paste0(hash, headTail)
  ## text
  textChar <- nchar(txt)
  if (textChar > nchar) {
    txt <- substring(txt, first = 1, last = 60)
  }
  space <- " "
  centering <- (nchar - 2) - textChar
  spacesBeforeAfter <- strrep(space, centering/2)
  
  textSent <- paste0(hash,
                     spacesBeforeAfter,
                     txt,
                     spacesBeforeAfter, 
                     charEnd)
  
  return(cat(paste0(headTailSent ,
                    "\n",textSent ,
                    "\n",headTailSent,
                    "\n")))
  
}

#' plot confusion matrix
#'
#' This function is for plotting confusion matriz
#' @param cm confusion matrix
#' @keywords install, load cran and bioconductor packages 
#' @export
#' @examples
#' plotCM(cm)

require(alluvial)

plotCM <- function(cm){
  cmdf <- as.data.frame(cm[["table"]])
  cmdf[["color"]] <- ifelse(cmdf[[1]] == cmdf[[2]], "#377EB8", "#E41A1C")
  
  alluvial::alluvial(cmdf[,1:2]
                     , freq = cmdf$Freq
                     , col = cmdf[["color"]]
                     , alpha = 0.5
                     , hide  = cmdf$Freq == 0
  )
}