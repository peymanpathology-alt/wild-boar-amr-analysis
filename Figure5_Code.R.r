# ============================================================
# FIGURE 5 - Panels A, B, and C
# High-quality output at 800 dpi
# ============================================================

library(ggplot2)
library(dplyr)

# Read data
data <- read.csv("Figure5_Source_Data.csv")

# ============================================================
# PANEL A: Gut Health vs Resistance
# ============================================================

p1 <- ggplot(data, aes(x = VH_CD_Ratio, y = Total_ARG_Abundance)) +
  geom_point(color = "#FF1493", size = 3, alpha = 0.7) +
  geom_smooth(method = "lm", color = "black", fill = "#FF1493", alpha = 0.2) +
  annotate("text", x = 1.5, y = 6, label = "r = -0.62\np < 0.001", size = 5, fontface = "bold") +
  labs(title = "Panel A: Gut Health vs Resistance", 
       x = "Villus Height : Crypt Depth", 
       y = "Total ARG (log RPKM)") +
  theme_minimal() +
  theme(
    axis.title = element_text(size = 14, face = "bold"),
    axis.text = element_text(size = 12),
    plot.title = element_text(size = 16, face = "bold", hjust = 0),
    panel.grid.major = element_line(color = "gray90", linewidth = 0.3),
    panel.grid.minor = element_blank()
  )

ggsave("Figure5_PanelA.tiff", p1, width = 6, height = 5, dpi = 800, compression = "lzw")
cat("✅ Panel A saved: Figure5_PanelA.tiff (800 dpi)\n")

# ============================================================
# PANEL B: Inflammation vs ARGs
# ============================================================

p2 <- ggplot(data, aes(x = as.factor(Infiltration_Score), y = Total_ARG_Abundance, fill = Habitat)) +
  geom_boxplot(alpha = 0.7, outlier.shape = NA) +
  geom_jitter(position = position_jitter(0.2), size = 2, alpha = 0.5) +
  scale_fill_manual(values = c("Forest" = "#32CD32", "Peri-urban" = "#FF8C00", "High-pressure" = "#FF1493")) +
  labs(title = "Panel B: Inflammation vs ARGs", 
       x = "Infiltration Score (0-3)", 
       y = "Total ARG (log RPKM)") +
  theme_minimal() +
  theme(
    axis.title = element_text(size = 14, face = "bold"),
    axis.text = element_text(size = 12),
    plot.title = element_text(size = 16, face = "bold", hjust = 0),
    legend.position = "bottom",
    legend.title = element_text(size = 12, face = "bold"),
    legend.text = element_text(size = 11),
    panel.grid.major = element_line(color = "gray90", linewidth = 0.3),
    panel.grid.minor = element_blank()
  )

ggsave("Figure5_PanelB.tiff", p2, width = 6, height = 5, dpi = 800, compression = "lzw")
cat("✅ Panel B saved: Figure5_PanelB.tiff (800 dpi)\n")

# ============================================================
# PANEL C: PCoA Plot
# ============================================================

p3 <- ggplot(data, aes(x = PCoA1, y = PCoA2, color = Habitat)) +
  geom_point(size = 4, alpha = 0.8) +
  stat_ellipse(aes(fill = Habitat), geom = "polygon", alpha = 0.1) +
  scale_color_manual(values = c("Forest" = "#32CD32", "Peri-urban" = "#FF8C00", "High-pressure" = "#FF1493")) +
  scale_fill_manual(values = c("Forest" = "#32CD32", "Peri-urban" = "#FF8C00", "High-pressure" = "#FF1493")) +
  annotate("text", x = -1.5, y = 1, label = "PERMANOVA\np < 0.01", fontface = "italic") +
  labs(title = "Panel C: PCoA of Microbiome Composition") +
  theme_minimal() +
  theme(
    axis.title = element_text(size = 14, face = "bold"),
    axis.text = element_text(size = 12),
    plot.title = element_text(size = 16, face = "bold", hjust = 0),
    legend.position = "right",
    legend.title = element_text(size = 12, face = "bold"),
    legend.text = element_text(size = 11),
    panel.grid.major = element_line(color = "gray90", linewidth = 0.3),
    panel.grid.minor = element_blank()
  )

ggsave("Figure5_PanelC.tiff", p3, width = 7, height = 5, dpi = 800, compression = "lzw")
cat("✅ Panel C saved: Figure5_PanelC.tiff (800 dpi)\n")

# ============================================================
# SUMMARY
# ============================================================

cat("\n========================================\n")
cat("FIGURE 5 - PANELS A, B, AND C COMPLETE (800 DPI)\n")
cat("========================================\n")
cat("\nFiles saved in:\n")
cat(getwd(), "\n\n")
cat("Created files:\n")
cat(" - Figure5_PanelA.tiff (800 dpi)\n")
cat(" - Figure5_PanelB.tiff (800 dpi)\n")
cat(" - Figure5_PanelC.tiff (800 dpi)\n\n")
cat("========================================\n")