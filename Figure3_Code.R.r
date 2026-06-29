# ============================================================
# FIGURE 3 - PANELS B AND C
# High-quality output at 600 dpi
# ============================================================

# Load libraries
library(ggplot2)
library(dplyr)
library(pheatmap)
library(RColorBrewer)

# ============================================================
# PANEL B: ARG Classes Barplot
# ============================================================

# Create data
arg_data <- data.frame(
  Zone = rep(c("Low", "Moderate", "High"), each = 6),
  ARG_Class = rep(c("Beta-lactamases", "Tetracyclines", "Aminoglycosides",
                    "Macrolides", "Sulfonamides", "Quinolones"), 3),
  Abundance = c(14, 32, 28, 22, 18, 10, 29, 51, 42, 35, 25, 15, 46, 75, 58, 48, 30, 22)
)

# Create barplot
p2 <- ggplot(arg_data, aes(x = Zone, y = Abundance, fill = ARG_Class)) +
  geom_bar(stat = "identity", position = "fill", width = 0.7, color = "black", linewidth = 0.2) +
  scale_y_continuous(labels = scales::percent, expand = c(0, 0)) +
  scale_fill_brewer(palette = "Set3") +
  labs(
    title = "B",
    x = "Anthropogenic Pressure Zone",
    y = "Relative Abundance (%)",
    fill = "ARG Class"
  ) +
  theme_minimal() +
  theme(
    axis.title = element_text(size = 14, face = "bold"),
    axis.text = element_text(size = 12),
    axis.text.x = element_text(angle = 0, vjust = 0.5),
    plot.title = element_text(size = 16, face = "bold", hjust = 0),
    legend.position = "bottom",
    legend.title = element_text(size = 12, face = "bold"),
    legend.text = element_text(size = 11),
    panel.grid.major = element_line(color = "gray90", linewidth = 0.3),
    panel.grid.minor = element_blank(),
    panel.background = element_rect(fill = "white", color = NA),
    plot.background = element_rect(fill = "white", color = NA),
    legend.background = element_rect(fill = "white", color = NA),
    legend.key.size = unit(0.8, "cm")
  )

# Save Panel B
ggsave("Figure3B_ARG_Classes_Barplot.png", p2, width = 7, height = 5, dpi = 600)
ggsave("Figure3B_ARG_Classes_Barplot.tiff", p2, width = 7, height = 5, dpi = 600, compression = "lzw")

cat("✅ Panel B saved: Figure3B_ARG_Classes_Barplot.png/tiff\n")

# ============================================================
# PANEL C: Heatmap
# ============================================================

set.seed(123)

# Read heatmap data from CSV
heatmap_data_raw <- read.csv("Figure3_Heatmap_Data.csv")
row.names(heatmap_data_raw) <- heatmap_data_raw$Sample_ID
heatmap_data_raw$Sample_ID <- NULL
heatmap_data_raw$Zone <- NULL

# Convert to matrix
heatmap_data <- as.matrix(heatmap_data_raw)

# Annotation for rows (pressure zones)
annotation_row <- data.frame(
  Zone = rep(c("Low", "Moderate", "High"), times = c(28, 31, 28))
)
rownames(annotation_row) <- rownames(heatmap_data)

zone_colors <- c("Low" = "#2d8a4e", "Moderate" = "#f4c542", "High" = "#d9453a")

# Save Heatmap as TIFF (for journal)
pheatmap(
  heatmap_data,
  main = "C",
  annotation_row = annotation_row,
  annotation_colors = list(Zone = zone_colors),
  cluster_rows = TRUE,
  cluster_cols = FALSE,
  show_rownames = FALSE,
  show_colnames = TRUE,
  fontsize_col = 12,
  color = colorRampPalette(brewer.pal(9, "YlOrRd"))(100),
  scale = "column",
  border_color = NA,
  annotation_legend = TRUE,
  filename = "Figure3C_Heatmap.tiff",
  width = 8,
  height = 6,
  dpi = 600
)

cat("✅ Panel C saved: Figure3C_Heatmap.tiff\n")

# ============================================================
# CHECK FILES
# ============================================================

cat("\n========================================\n")
cat("FIGURE 3 - PANELS B AND C COMPLETE (600 DPI)\n")
cat("========================================\n")
cat("\nFiles saved in:\n")
cat(getwd(), "\n\n")
cat("Created files:\n")
cat(" - Figure3B_ARG_Classes_Barplot.png (600 dpi)\n")
cat(" - Figure3B_ARG_Classes_Barplot.tiff (600 dpi)\n")
cat(" - Figure3C_Heatmap.tiff (600 dpi)\n\n")
cat("========================================\n")