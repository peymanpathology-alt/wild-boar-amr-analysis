# ============================================================
# SUPPLEMENTARY FIGURE S3 - Resistome Heatmaps by ARG Class
# ============================================================

library(pheatmap)
library(RColorBrewer)
library(dplyr)

# Read ARG abundance data (from Supplementary Table S2)
# Data should include ARG abundance for each sample
arg_data <- read.csv("FigureS3_ARG_Abundance.csv")
rownames(arg_data) <- arg_data$Sample_ID
arg_data$Sample_ID <- NULL
arg_data$Pressure_Zone <- NULL

# Create annotation for rows
annotation_row <- data.frame(
  Zone = rep(c("Low", "Moderate", "High"), times = c(28, 31, 28))
)
rownames(annotation_row) <- rownames(arg_data)

zone_colors <- c("Low" = "#2d8a4e", "Moderate" = "#f4c542", "High" = "#d9453a")

# Log2 transform for better visualization
arg_matrix <- as.matrix(log2(arg_data + 1))

# Create heatmap
pheatmap(
  arg_matrix,
  main = "Supplementary Figure S3: Resistome Heatmaps by ARG Class",
  annotation_row = annotation_row,
  annotation_colors = list(Zone = zone_colors),
  cluster_rows = TRUE,
  cluster_cols = TRUE,
  show_rownames = FALSE,
  show_colnames = TRUE,
  fontsize_col = 8,
  color = colorRampPalette(brewer.pal(9, "YlOrRd"))(100),
  scale = "row",
  border_color = NA,
  annotation_legend = TRUE,
  filename = "FigureS3_Heatmap.tiff",
  width = 12,
  height = 8,
  dpi = 600
)

cat("✅ Figure S3 saved: FigureS3_Heatmap.tiff (600 dpi)\n")