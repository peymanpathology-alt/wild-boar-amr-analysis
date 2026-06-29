# ============================================================
# SUPPLEMENTARY FIGURE S2 - CODEX Segmentation Accuracy
# Panels A, B, C, and D
# ============================================================

library(ggplot2)
library(dplyr)
library(tidyr)

# Read data
seg_data <- read.csv("FigureS2_Segmentation_Accuracy.csv")

# ============================================================
# PANEL A: Representative Images (Image processing in Python/ImageJ)
# Note: Panel A images are generated separately
# ============================================================

# ============================================================
# PANEL B: Accuracy Metrics Boxplots
# ============================================================

# Prepare data for boxplots
metrics_data <- seg_data %>%
  select(Sample_ID, Dice_Coefficient, Intersection_Over_Union, Cohen_Kappa) %>%
  pivot_longer(cols = -Sample_ID, names_to = "Metric", values_to = "Value")

pB <- ggplot(metrics_data, aes(x = Metric, y = Value, fill = Metric)) +
  geom_boxplot(alpha = 0.7, outlier.shape = NA) +
  geom_jitter(width = 0.2, size = 1, alpha = 0.3) +
  scale_fill_manual(values = c("Dice_Coefficient" = "#4a7fb5", 
                               "Intersection_Over_Union" = "#f4c542", 
                               "Cohen_Kappa" = "#d9453a")) +
  labs(
    title = "B",
    x = "Accuracy Metric",
    y = "Value"
  ) +
  theme_minimal() +
  theme(
    axis.title = element_text(size = 12, face = "bold"),
    axis.text = element_text(size = 10),
    plot.title = element_text(size = 14, face = "bold", hjust = 0),
    legend.position = "none"
  )

ggsave("FigureS2B_Metrics.tiff", pB, width = 6, height = 5, dpi = 600, compression = "lzw")

# ============================================================
# PANEL C: Manual Correction Rates
# ============================================================

# Aggregate correction rates by sample
correction_summary <- seg_data %>%
  group_by(Sample_ID) %>%
  summarise(Mean_Correction = mean(Manual_Correction_Rate_Percent))

pC <- ggplot(correction_summary, aes(x = Mean_Correction)) +
  geom_histogram(bins = 20, fill = "#4a7fb5", color = "black", alpha = 0.7) +
  geom_vline(xintercept = 5, linetype = "dashed", color = "#d9453a", size = 1) +
  labs(
    title = "C",
    x = "Manual Correction Rate (%)",
    y = "Frequency"
  ) +
  annotate("text", x = 6, y = 8, label = "Threshold = 5%", color = "#d9453a", fontface = "bold") +
  theme_minimal() +
  theme(
    axis.title = element_text(size = 12, face = "bold"),
    axis.text = element_text(size = 10),
    plot.title = element_text(size = 14, face = "bold", hjust = 0)
  )

ggsave("FigureS2C_Corrections.tiff", pC, width = 6, height = 5, dpi = 600, compression = "lzw")

# ============================================================
# PANEL D: Automated vs Manual Classification Accuracy
# ============================================================

pD <- ggplot(seg_data, aes(x = Cell_Type, y = Automated_Accuracy_Percent, fill = Cell_Type)) +
  geom_boxplot(alpha = 0.7, outlier.shape = NA) +
  geom_jitter(width = 0.2, size = 1, alpha = 0.3) +
  geom_hline(yintercept = 92, linetype = "dashed", color = "#d9453a", size = 1) +
  scale_fill_manual(values = c("CD3" = "#e6194b", "CD79a" = "#4a7fb5", "MPO" = "#00A651")) +
  labs(
    title = "D",
    x = "Cell Type",
    y = "Automated Classification Accuracy (%)"
  ) +
  annotate("text", x = 1.5, y = 93, label = "Threshold = 92%", color = "#d9453a", fontface = "bold") +
  theme_minimal() +
  theme(
    axis.title = element_text(size = 12, face = "bold"),
    axis.text = element_text(size = 10),
    plot.title = element_text(size = 14, face = "bold", hjust = 0),
    legend.position = "none"
  )

ggsave("FigureS2D_Accuracy.tiff", pD, width = 6, height = 5, dpi = 600, compression = "lzw")

cat("✅ Figure S2 Panels B-D saved successfully!\n")