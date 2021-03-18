#' module_eigengene_plot (from WGCNA output).
#'
#' This function implements module eigengene plots from wgcna output.
#'
#' @param groups Define sample groups.
#' @param MEs Module eigengenes.
#' @param color Module color.
#' @return Produces module eigengene plots.
#' @examples
#' groups <- as.factor(c(rep("Ctrl",4), rep("TolLPS",4), rep("TolS100A8",4), rep("ActLPS",4)))
#' module_eigengene_plot(groups, MEs, color="red")
#' @export

require(ggplot2)
require(ggpubr)
require(scales)

ggplot_theme <- theme_classic() +
  theme(
    axis.line = element_line(size = 0.75),
    axis.text = element_text(
      size = 11,
      face = "bold",
      colour = "black"
    ),
    axis.title = element_text(size = 12, face = "bold")
)

module_eigengene_plot <- function(groups, MEs, color){
  ## ME _colors
  MEs_color <- MEs[,which(colnames(MEs) == paste0("ME", color)), drop=FALSE]
  ## data subset
  traitsinfo <- cbind(MEs_color, groups=groups[,1][match(rownames(MEs_color), rownames(groups))])
  ## plot
  p <- ggplot(traitsinfo, aes(x = groups, y = traitsinfo[,1], fill = groups)) +
    geom_boxplot(color = 'black', alpha = 0.5) +
    geom_point(
      size = 3,
      shape = 21,
      color = "black",
      stat = "identity",
      position = position_jitterdodge(1)
    ) +
    ggplot_theme +
    scale_fill_manual(values = brewer.pal(length(unique(traitsinfo$groups)), "Set1")) +
    stat_compare_means(label = "p.signif", method = "wilcox.test",
                       ref.group = sort(unique(traitsinfo$groups))[1], size = 8) +
    xlab("") +
    ylab("Module eigengene value") +
    ggtitle(paste(color, "module")) +
    theme(legend.position = "none", panel.background = element_rect(fill = scales::alpha(color, 0.1),
                                                                    colour = scales::alpha(color, 0.1)))
}

# devtools::document()