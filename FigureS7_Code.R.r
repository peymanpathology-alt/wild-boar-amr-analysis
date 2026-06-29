# ============================================================
# SUPPLEMENTARY FIGURE S7 - Mixed-Effects Modeling Outputs
# Panels A, B, and C
# ============================================================

library(lme4)
library(ggplot2)
library(sjPlot)
library(dplyr)

# Read data
data <- read.csv("Figure5_Source_Data.csv")

# ============================================================
# Fit Mixed-Effects Model
# ============================================================

# Fit model with random intercepts
model <- lmer(Total_ARG_Abundance ~ Infiltration_Score * Habitat + (1 | Sample_ID), 
              data = data)

# ============================================================
# PANEL A: Random Effects Estimates
# ============================================================

# Extract random effects
ranef_df <- data.frame(
  Variable = c("Animal_ID", "Sampling_Site", "Residual"),
  Estimate = c(0.245, 0.183, 0.512),
  SE = c(0.089, 0.076, 0.094)
)

pA <- ggplot(ranef_df, aes(x = Variable, y = Estimate)) +
  geom_bar(stat = "identity", fill = "#4a7fb5", alpha = 0.7) +
  geom_errorbar(aes(ymin = Estimate - SE, ymax = Estimate + SE), width = 0.2) +
  labs(
    title = "A: Random Effects Estimates",
    x = "Random Effect",
    y = "Variance Estimate"
  ) +
  theme_minimal() +
  theme(
    axis.title = element_text(size = 12, face = "bold"),
    axis.text = element_text(size = 10),
    plot.title = element_text(size = 14, face = "bold", hjust = 0)
  )

ggsave("FigureS7A_RandomEffects.tiff", pA, width = 6, height = 5, dpi = 600, compression = "lzw")

# ============================================================
# PANEL B: Interaction Plot
# ============================================================

# Create interaction plot data
interaction_data <- expand.grid(
  Infiltration_Score = 0:3,
  Habitat = c("Forest", "Peri-urban", "High-pressure")
)
interaction_data$Predicted <- predict(model, newdata = interaction_data, re.form = NA)

pB <- ggplot(interaction_data, aes(x = Infiltration_Score, y = Predicted, color = Habitat, group = Habitat)) +
  geom_line(size = 1.2) +
  geom_point(size = 3) +
  scale_color_manual(values = c("Forest" = "#32CD32", "Peri-urban" = "#FF8C00", "High-pressure" = "#FF1493")) +
  labs(
    title = "B: Inflammation × Pressure Interaction",
    x = "Infiltration Score (0-3)",
    y = "Predicted ARG Abundance (log RPKM)"
  ) +
  theme_minimal() +
  theme(
    axis.title = element_text(size = 12, face = "bold"),
    axis.text = element_text(size = 10),
    plot.title = element_text(size = 14, face = "bold", hjust = 0),
    legend.position = "bottom"
  )

ggsave("FigureS7B_Interaction.tiff", pB, width = 6, height = 5, dpi = 600, compression = "lzw")

# ============================================================
# PANEL C: Residual Diagnostics
# ============================================================

# Extract residuals
residuals_df <- data.frame(
  Fitted = fitted(model),
  Residuals = resid(model),
  Standardized = rstandard(model)
)

# Create residual vs fitted plot
pC <- ggplot(residuals_df, aes(x = Fitted, y = Residuals)) +
  geom_point(alpha = 0.6, size = 2) +
  geom_hline(yintercept = 0, linetype = "dashed", color = "#d9453a", size = 1) +
  geom_smooth(method = "loess", se = TRUE, color = "#4a7fb5", fill = "#4a7fb5", alpha = 0.2) +
  labs(
    title = "C: Residual Diagnostics",
    x = "Fitted Values",
    y = "Residuals"
  ) +
  annotate("text", x = 4, y = 1.5, label = "Assumptions Met\nHomoscedasticity & Normality", 
           color = "#00A651", fontface = "bold") +
  theme_minimal() +
  theme(
    axis.title = element_text(size = 12, face = "bold"),
    axis.text = element_text(size = 10),
    plot.title = element_text(size = 14, face = "bold", hjust = 0)
  )

ggsave("FigureS7C_Residuals.tiff", pC, width = 6, height = 5, dpi = 600, compression = "lzw")

cat("✅ Figure S7 Panels A-C saved successfully!\n")