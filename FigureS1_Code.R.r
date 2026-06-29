# ============================================================
# SUPPLEMENTARY FIGURE S1 - Metagenomic Data Quality Assessment
# Panels A, B, and C
# ============================================================

library(ggplot2)
library(factoextra)
library(vegan)
library(dplyr)
library(tidyr)

# Read data
qc_data <- read.csv("FigureS1_FastQC_Metrics.csv")
rarefaction_data <- read.csv("FigureS1_Rarefaction_Data.csv")

# ============================================================
# PANEL A: PCA of FastQC Metrics
# ============================================================

# Prepare data for PCA
pca_data <- qc_data[, c("Mean_Quality_Score", "GC_Content_Percent", 
                        "Duplication_Level_Percent", "QC_Pass_Percent")]
rownames(pca_data) <- qc_data$Sample_ID

# Perform PCA
pca_result <- prcomp(pca_data, scale = TRUE)

# Create PCA plot
pca_df <- data.frame(
  Sample_ID = rownames(pca_result$x),
  PC1 = pca_result$x[,1],
  PC2 = pca_result$x[,2],
  Pressure_Zone = qc_data$Pressure_Zone
)

p1 <- ggplot(pca_df, aes(x = PC1, y = PC2, color = Pressure_Zone)) +
  geom_point(size = 3, alpha = 0.8) +
  stat_ellipse(aes(fill = Pressure_Zone), geom = "polygon", alpha = 0.1) +
  scale_color_manual(values = c("Low" = "#2d8a4e", "Moderate" = "#f4c542", "High" = "#d9453a")) +
  scale_fill_manual(values = c("Low" = "#2d8a4e", "Moderate" = "#f4c542", "High" = "#d9453a")) +
  labs(
    title = "A",
    x = paste0("PC1 (", round(summary(pca_result)$importance[2,1]*100, 1), "%)"),
    y = paste0("PC2 (", round(summary(pca_result)$importance[2,2]*100, 1), "%)")
  ) +
  theme_minimal() +
  theme(
    axis.title = element_text(size = 12, face = "bold"),
    axis.text = element_text(size = 10),
    plot.title = element_text(size = 14, face = "bold", hjust = 0),
    legend.position = "bottom"
  )

ggsave("FigureS1A_PCA.tiff", p1, width = 6, height = 5, dpi = 600, compression = "lzw")

# ============================================================
# PANEL B: Boxplots of Read Counts
# ============================================================

p2 <- ggplot(qc_data, aes(x = Pressure_Zone, y = Total_Reads_Millions, fill = Pressure_Zone)) +
  geom_boxplot(alpha = 0.7, outlier.shape = NA) +
  geom_jitter(width = 0.2, size = 2, alpha = 0.5) +
  scale_fill_manual(values = c("Low" = "#2d8a4e", "Moderate" = "#f4c542", "High" = "#d9453a")) +
  labs(
    title = "B",
    x = "Anthropogenic Pressure Zone",
    y = "Total Reads (Millions)"
  ) +
  theme_minimal() +
  theme(
    axis.title = element_text(size = 12, face = "bold"),
    axis.text = element_text(size = 10),
    plot.title = element_text(size = 14, face = "bold", hjust = 0),
    legend.position = "none"
  )

ggsave("FigureS1B_ReadCounts.tiff", p2, width = 6, height = 5, dpi = 600, compression = "lzw")

# ============================================================
# PANEL C: Rarefaction Curves
# ============================================================

p3 <- ggplot(rarefaction_data, aes(x = Sequencing_Depth, y = ARG_Richness, 
                                   group = Sample_ID, color = Pressure_Zone)) +
  geom_line(alpha = 0.6, size = 0.8) +
  scale_color_manual(values = c("Low" = "#2d8a4e", "Moderate" = "#f4c542", "High" = "#d9453a")) +
  labs(
    title = "C",
    x = "Sequencing Depth (Reads)",
    y = "ARG Richness"
  ) +
  theme_minimal() +
  theme(
    axis.title = element_text(size = 12, face = "bold"),
    axis.text = element_text(size = 10),
    plot.title = element_text(size = 14, face = "bold", hjust = 0),
    legend.position = "bottom"
  )

ggsave("FigureS1C_Rarefaction.tiff", p3, width = 6, height = 5, dpi = 600, compression = "lzw")

cat("✅ Figure S1 Panels A-C saved successfully!\n")