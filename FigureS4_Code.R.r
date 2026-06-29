# ============================================================
# SUPPLEMENTARY FIGURE S4 - Mobile Genetic Element Mapping
# Panels A, B, and C
# ============================================================

library(pheatmap)
library(igraph)
library(RColorBrewer)
library(dplyr)
library(tidyr)

# ============================================================
# PANEL A: Plasmid Replicon Heatmap
# ============================================================

plasmid_data <- read.csv("FigureS4_Plasmid_Replicons.csv")
rownames(plasmid_data) <- plasmid_data$Sample_ID
plasmid_matrix <- plasmid_data[, c("IncF_Incidence", "IncI_Incidence", "IncX_Incidence")]
colnames(plasmid_matrix) <- c("IncF", "IncI", "IncX")

annotation_row <- data.frame(
  Zone = plasmid_data$Pressure_Zone
)
rownames(annotation_row) <- rownames(plasmid_matrix)

zone_colors <- c("Low" = "#2d8a4e", "Moderate" = "#f4c542", "High" = "#d9453a")

pheatmap(
  t(plasmid_matrix),
  main = "A: Plasmid Replicon Types",
  annotation_col = annotation_row,
  annotation_colors = list(Zone = zone_colors),
  cluster_rows = FALSE,
  cluster_cols = TRUE,
  show_rownames = TRUE,
  show_colnames = FALSE,
  color = c("white", "#4a7fb5"),
  border_color = "gray80",
  filename = "FigureS4A_Plasmids.tiff",
  width = 8,
  height = 4,
  dpi = 600
)

# ============================================================
# PANEL B: ARG-MGE Co-Localization Matrix
# ============================================================

coloc_data <- read.csv("FigureS4_ARG_MGE_CoLocalization.csv")

# Create matrix
coloc_matrix <- coloc_data %>%
  pivot_wider(
    id_cols = ARG,
    names_from = MGE_Type,
    values_from = CoLocalization_Frequency_Percent
  ) %>%
  column_to_rownames("ARG")

pheatmap(
  colocalization_matrix,
  main = "B: ARG-MGE Co-Localization",
  cluster_rows = TRUE,
  cluster_cols = FALSE,
  show_rownames = TRUE,
  show_colnames = TRUE,
  color = colorRampPalette(brewer.pal(9, "YlOrRd"))(100),
  scale = "none",
  border_color = "gray80",
  filename = "FigureS4B_CoLocalization.tiff",
  width = 8,
  height = 6,
  dpi = 600
)

# ============================================================
# PANEL C: Network Visualization
# ============================================================

# Create network data
nodes <- data.frame(
  ID = c("ST131", "ST69", "ST405", "IncF", "IncI", "IncX", "bla_CTX-M-15", "bla_TEM-1", "mcr-1"),
  Type = c("ST", "ST", "ST", "Plasmid", "Plasmid", "Plasmid", "ARG", "ARG", "ARG")
)

edges <- data.frame(
  from = c("ST131", "ST131", "ST69", "ST405", "IncF", "IncF", "IncI", "IncX"),
  to = c("IncF", "IncI", "IncX", "IncF", "bla_CTX-M-15", "bla_TEM-1", "mcr-1", "mcr-1"),
  weight = c(0.98, 0.62, 0.73, 0.84, 0.85, 0.82, 0.90, 0.88)
)

g <- graph_from_data_frame(edges, vertices = nodes, directed = FALSE)

# Set colors
V(g)$color <- ifelse(V(g)$Type == "ST", "#4a7fb5",
                      ifelse(V(g)$Type == "Plasmid", "#00A651", "#e6194b"))
V(g)$size <- ifelse(V(g)$Type == "ST", 20,
                     ifelse(V(g)$Type == "Plasmid", 15, 12))

# Save network
tiff("FigureS4C_Network.tiff", width = 8, height = 6, units = 'in', res = 600, compression = 'lzw')
plot(g,
     vertex.label.cex = 0.7,
     vertex.label.color = "black",
     edge.width = E(g)$weight * 5,
     edge.curved = 0.2,
     layout = layout_with_fr,
     main = "C: Plasmid-Mediated ARG Sharing Network")
dev.off()

cat("✅ Figure S4 Panels A-C saved successfully!\n")