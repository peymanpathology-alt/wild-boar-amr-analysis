# ============================================================
# FIGURE 4 - Network of Plasmid-ARG Interactions
# R code for network construction and visualization
# ============================================================

# Load required libraries
library(igraph)

# Read the edge list and node attributes
edges <- read.csv("Edge_List.csv.txt")
nodes <- read.csv("Node_Table.csv.txt")

# Create graph object
g <- graph_from_data_frame(d = edges, vertices = nodes, directed = FALSE)

# Set node colors based on type
V(g)$color <- ifelse(V(g)$Type == "Plasmid", "#00A651",
                      ifelse(V(g)$Type == "ARG", "#e6194b", "#4a7fb5"))

# Set node shapes based on type
V(g)$shape <- ifelse(V(g)$Type == "Plasmid", "circle",
                      ifelse(V(g)$Type == "ARG", "square", "triangle"))

# Set edge width based on weight
E(g)$width <- E(g)$Weight * 4

# Save as high-resolution TIFF
tiff("Figure4_Network.tiff", width = 10, height = 8, units = 'in', res = 600, compression = 'lzw')
par(mar = c(1, 1, 3, 1))
plot(g,
     vertex.size = 12,
     vertex.label.cex = 0.6,
     vertex.label.color = "black",
     edge.curved = 0.2,
     layout = layout_with_fr,
     main = "Figure 4. Plasmid-ARG Interaction Network")
dev.off()

cat("✅ Figure 4 saved: Figure4_Network.tiff (600 dpi)\n")