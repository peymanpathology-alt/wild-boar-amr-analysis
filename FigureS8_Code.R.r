# ============================================================
# SUPPLEMENTARY FIGURE S8 - Sensitivity Analyses
# Panels A, B, C, and D
# ============================================================

library(ggplot2)
library(dplyr)

sensitivity_data <- read.csv("FigureS8_Sensitivity_Analysis.csv")

# ============================================================
# PANEL A: Excluding Outliers
# ============================================================

pA <- ggplot(sensitivity_data %>% filter(Analysis_Type == "Exclude_Outliers"),
             aes(x = Variable, y = Estimate, fill = Variable)) +
  geom_bar(stat = "identity", alpha = 0.7) +
  geom_errorbar(aes(ymin = Estimate - SE, ymax = Estimate + SE), width = 0.2) +
  scale_fill_manual(values = c("VH_CD_Ratio" = "#32CD32", "Infiltration_Score" = "#FF8C00")) +
  labs(
    title = "A: Excluding Outliers",
    x = "",
    y = "Effect Estimate"
  ) +
  theme_minimal() +
  theme(
    axis.title = element_text(size = 12, face = "bold"),
    axis.text = element_text(size = 10),
    plot.title = element_text(size = 14, face = "bold", hjust = 0),
    legend.position = "none"
  )

ggsave("FigureS8A_Outliers.tiff", pA, width = 6, height = 5, dpi = 600, compression = "lzw")

# ============================================================
# PANEL B: Stratification by Habitat
# ============================================================

pB <- ggplot(sensitivity_data %>% filter(Analysis_Type == "Stratified_Forest" | Analysis_Type == "Stratified_Farmland"),
             aes(x = Analysis_Type, y = Estimate, fill = Variable)) +
  geom_bar(stat = "identity", position = "dodge", alpha = 0.7) +
  geom_errorbar(aes(ymin = Estimate - SE, ymax = Estimate + SE), 
                position = position_dodge(0.9), width = 0.2) +
  scale_fill_manual(values = c("VH_CD_Ratio" = "#32CD32", "Infiltration_Score" = "#FF8C00")) +
  labs(
    title = "B: Stratification by Habitat",
    x = "",
    y = "Effect Estimate"
  ) +
  theme_minimal() +
  theme(
    axis.title = element_text(size = 12, face = "bold"),
    axis.text = element_text(size = 10),
    plot.title = element_text(size = 14, face = "bold", hjust = 0),
    legend.position = "bottom"
  )

ggsave("FigureS8B_Stratification.tiff", pB, width = 6, height = 5, dpi = 600, compression = "lzw")

# ============================================================
# PANEL C: Stage-Specific Analysis
# ============================================================

pC <- ggplot(sensitivity_data %>% filter(Analysis_Type == "Stage_Proximal" | Analysis_Type == "Stage_Distal"),
             aes(x = Analysis_Type, y = Estimate, fill = Analysis_Type)) +
  geom_bar(stat = "identity", alpha = 0.7) +
  geom_errorbar(aes(ymin = Estimate - SE, ymax = Estimate + SE), width = 0.2) +
  scale_fill_manual(values = c("Stage_Proximal" = "#4a7fb5", "Stage_Distal" = "#e6194b")) +
  labs(
    title = "C: Stage-Specific Analysis",
    x = "",
    y = "Effect Estimate"
  ) +
  theme_minimal() +
  theme(
    axis.title = element_text(size = 12, face = "bold"),
    axis.text = element_text(size = 10),
    plot.title = element_text(size = 14, face = "bold", hjust = 0),
    legend.position = "none"
  )

ggsave("FigureS8C_Stage.tiff", pC, width = 6, height = 5, dpi = 600, compression = "lzw")

# ============================================================
# PANEL D: Age and BCS Adjustment
# ============================================================

pD <- ggplot(sensitivity_data %>% filter(Analysis_Type == "Age_Adjusted" | Analysis_Type == "BCS_Adjusted"),
             aes(x = Analysis_Type, y = Estimate, fill = Analysis_Type)) +
  geom_bar(stat = "identity", alpha = 0.7) +
  geom_errorbar(aes(ymin = Estimate - SE, ymax = Estimate + SE), width = 0.2) +
  scale_fill_manual(values = c("Age_Adjusted" = "#00A651", "BCS_Adjusted" = "#f4c542")) +
  labs(
    title = "D: Age and BCS Adjustment",
    x = "",
    y = "Effect Estimate"
  ) +
  theme_minimal() +
  theme(
    axis.title = element_text(size = 12, face = "bold"),
    axis.text = element_text(size = 10),
    plot.title = element_text(size = 14, face = "bold", hjust = 0),
    legend.position = "none"
  )

ggsave("FigureS8D_Adjustment.tiff", pD, width = 6, height = 5, dpi = 600, compression = "lzw")

cat("✅ Figure S8 Panels A-D saved successfully!\n")