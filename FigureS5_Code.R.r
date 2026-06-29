# ============================================================
# SUPPLEMENTARY FIGURE S5 - Histopathology Correlations
# ============================================================

library(ggplot2)
library(dplyr)

# Read data (from Figure 5 source data)
data <- read.csv("Figure5_Source_Data.csv")

# ============================================================
# Panel A: Villus Height vs ARG Abundance
# ============================================================

pA <- ggplot(data, aes(x = VH_CD_Ratio, y = Total_ARG_Abundance, color = Habitat)) +
  geom_point(size = 3, alpha = 0.7) +
  geom_smooth(method = "lm", se = TRUE, aes(fill = Habitat), alpha = 0.1) +
  scale_color_manual(values = c("Forest" = "#32CD32", "Peri-urban" = "#FF8C00", "High-pressure" = "#FF1493")) +
  scale_fill_manual(values = c("Forest" = "#32CD32", "Peri-urban" = "#FF8C00", "High-pressure" = "#FF1493")) +
  annotate("text", x = 1.5, y = 6, label = "r = -0.62\np < 0.001", size = 5, fontface = "bold") +
  labs(
    title = "A",
    x = "Villus Height : Crypt Depth Ratio",
    y = "Total ARG Abundance (log RPKM)"
  ) +
  theme_minimal() +
  theme(
    axis.title = element_text(size = 12, face = "bold"),
    axis.text = element_text(size = 10),
    plot.title = element_text(size = 14, face = "bold", hjust = 0),
    legend.position = "bottom"
  )

ggsave("FigureS5A_VH_CD.tiff", pA, width = 6, height = 5, dpi = 600, compression = "lzw")

# ============================================================
# Panel B: Infiltration Score vs ARG Abundance
# ============================================================

pB <- ggplot(data, aes(x = as.factor(Infiltration_Score), y = Total_ARG_Abundance, fill = Habitat)) +
  geom_boxplot(alpha = 0.7, outlier.shape = NA) +
  geom_jitter(position = position_jitter(0.2), size = 2, alpha = 0.5) +
  scale_fill_manual(values = c("Forest" = "#32CD32", "Peri-urban" = "#FF8C00", "High-pressure" = "#FF1493")) +
  labs(
    title = "B",
    x = "Infiltration Score (0-3)",
    y = "Total ARG Abundance (log RPKM)"
  ) +
  theme_minimal() +
  theme(
    axis.title = element_text(size = 12, face = "bold"),
    axis.text = element_text(size = 10),
    plot.title = element_text(size = 14, face = "bold", hjust = 0),
    legend.position = "bottom"
  )

ggsave("FigureS5B_Infiltration.tiff", pB, width = 6, height = 5, dpi = 600, compression = "lzw")

cat("✅ Figure S5 Panels A-B saved successfully!\n")