# ============================================================
# SUPPLEMENTARY FIGURE S6 - Taxonomic Profiling
# Panels A, B, and C
# ============================================================

library(ggplot2)
library(dplyr)
library(tidyr)

# ============================================================
# PANEL A: Genera Abundance
# ============================================================

genus_data <- read.csv("FigureS6_Genera_Abundance.csv")

# Prepare data for plotting
genus_long <- genus_data %>%
  pivot_longer(cols = c(Escherichia_Abundance, Klebsiella_Abundance, Enterobacter_Abundance),
               names_to = "Genus",
               values_to = "Abundance") %>%
  mutate(Genus = gsub("_Abundance", "", Genus))

pA <- ggplot(genus_long, aes(x = Pressure_Zone, y = Abundance, fill = Genus)) +
  geom_bar(stat = "identity", position = "dodge", alpha = 0.8) +
  scale_fill_manual(values = c("Escherichia" = "#e6194b", 
                               "Klebsiella" = "#4a7fb5", 
                               "Enterobacter" = "#00A651")) +
  labs(
    title = "A: Enterobacteriaceae Genera Abundance",
    x = "Anthropogenic Pressure Zone",
    y = "Relative Abundance (%)"
  ) +
  theme_minimal() +
  theme(
    axis.title = element_text(size = 12, face = "bold"),
    axis.text = element_text(size = 10),
    plot.title = element_text(size = 14, face = "bold", hjust = 0),
    legend.position = "bottom"
  )

ggsave("FigureS6A_Genera.tiff", pA, width = 8, height = 5, dpi = 600, compression = "lzw")

# ============================================================
# PANEL B: ST Distribution
# ============================================================

st_data <- read.csv("FigureS6_ST_Distribution.csv")

# Summarize ST prevalence by pressure zone
st_summary <- st_data %>%
  group_by(Pressure_Zone) %>%
  summarise(
    ST131 = mean(ST131_Present) * 100,
    ST69 = mean(ST69_Present) * 100,
    ST405 = mean(ST405_Present) * 100
  ) %>%
  pivot_longer(cols = c(ST131, ST69, ST405),
               names_to = "ST_Type",
               values_to = "Prevalence")

pB <- ggplot(st_summary, aes(x = Pressure_Zone, y = Prevalence, fill = ST_Type)) +
  geom_bar(stat = "identity", position = "dodge", alpha = 0.8) +
  scale_fill_manual(values = c("ST131" = "#d9453a", 
                               "ST69" = "#f4c542", 
                               "ST405" = "#4a7fb5")) +
  labs(
    title = "B: E. coli Sequence Type Distribution",
    x = "Anthropogenic Pressure Zone",
    y = "Prevalence (%)"
  ) +
  theme_minimal() +
  theme(
    axis.title = element_text(size = 12, face = "bold"),
    axis.text = element_text(size = 10),
    plot.title = element_text(size = 14, face = "bold", hjust = 0),
    legend.position = "bottom"
  )

ggsave("FigureS6B_ST_Distribution.tiff", pB, width = 8, height = 5, dpi = 600, compression = "lzw")

# ============================================================
# PANEL C: Plasmid-Borne Virulence and Resistance
# ============================================================

# Calculate incidence of plasmid-borne genes by ST
incidence_data <- st_data %>%
  group_by(Pressure_Zone) %>%
  summarise(
    Virulence_Incidence = mean(Virulence_Genes) * 100
  )

pC <- ggplot(incidence_data, aes(x = Pressure_Zone, y = Virulence_Incidence, fill = Pressure_Zone)) +
  geom_bar(stat = "identity", alpha = 0.8) +
  scale_fill_manual(values = c("Low" = "#2d8a4e", "Moderate" = "#f4c542", "High" = "#d9453a")) +
  labs(
    title = "C: Plasmid-Borne Virulence and Resistance",
    x = "Anthropogenic Pressure Zone",
    y = "Incidence of Virulence/Resistance Genes (%)"
  ) +
  theme_minimal() +
  theme(
    axis.title = element_text(size = 12, face = "bold"),
    axis.text = element_text(size = 10),
    plot.title = element_text(size = 14, face = "bold", hjust = 0),
    legend.position = "none"
  )

ggsave("FigureS6C_Virulence.tiff", pC, width = 6, height = 5, dpi = 600, compression = "lzw")

cat("✅ Figure S6 Panels A-C saved successfully!\n")