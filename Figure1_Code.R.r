# ============================================================
# Figure 1. Geospatial Distribution of Sampled Wild Boars
# R code for data processing and kernel density estimation
# ============================================================

# Load required libraries
library(sf)
library(ggplot2)
library(dplyr)
library(MASS)

# Read the sampling data (87 samples)
sampling_data <- read.csv("WildBoar_Sampling_Points.csv")

# Check the data structure
head(sampling_data)
table(sampling_data$Pressure_Zone)

# Convert to sf object for spatial operations
sampling_sf <- st_as_sf(sampling_data,
                        coords = c("Longitude", "Latitude"),
                        crs = 4326) # WGS84 coordinate system

# Export as shapefile for QGIS visualization
st_write(sampling_sf, "WildBoar_Sampling_Points.shp", delete_layer = TRUE)

# ============================================================
# Kernel Density Estimation (KDE) for population clustering
# ============================================================

# Extract coordinates for KDE
coords <- sampling_data[, c("Longitude", "Latitude")]

# Calculate bandwidth using Scott's rule
bandwidth <- c(bandwidth.nrd(coords$Longitude),
               bandwidth.nrd(coords$Latitude))

# Create kernel density estimation
kde <- kde2d(coords$Longitude, coords$Latitude,
             h = bandwidth * 1.2, # Slight smoothing factor
             n = 100,
             lims = c(44, 64, 25, 40)) # Iran boundaries

# Save KDE results as CSV
kde_df <- expand.grid(Longitude = kde$x, Latitude = kde$y)
kde_df$Density <- as.vector(kde$z)
write.csv(kde_df, "Kernel_Density_Results.csv", row.names = FALSE)

# ============================================================
# Summary statistics for the manuscript
# ============================================================

cat("\n========================================\n")
cat("SUMMARY OF SAMPLING DATA\n")
cat("========================================\n")
cat("Total samples:", nrow(sampling_data), "\n")
cat("\nDistribution by pressure zone:\n")
print(table(sampling_data$Pressure_Zone))
cat("\nGeographic range:\n")
cat(" Latitude:", range(sampling_data$Latitude), "\n")
cat(" Longitude:", range(sampling_data$Longitude), "\n")
cat("========================================\n")