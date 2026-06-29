# ============================================================
# TABLE 2. Histopathological and Immunohistochemical Scoring
# by Anthropogenic Pressure
# ============================================================

# Load required packages
library(flextable)
library(officer)
library(magrittr)
library(dplyr)

# Create dataset
table2_data <- data.frame(
  Parameter = c(
    "Villus Height (µm, mean ± SD)",
    "Crypt Depth (µm)",
    "VH:CD Ratio",
    "Lamina propria lymphoplasmacytic infiltration (score 0--3)",
    "CD3⁺ T-cell density (cells/mm²)",
    "CD79α⁺ B-cell density (cells/mm²)",
    "MPO⁺ neutrophil density (cells/mm²)"
  ),
  `Low Pressure` = c(
    "440 ± 32",
    "138 ± 12",
    "3.2 ± 0.4",
    "0.8 ± 0.5",
    "142 ± 21",
    "98 ± 15",
    "35 ± 10"
  ),
  `Moderate Pressure` = c(
    "392 ± 28",
    "140 ± 15",
    "2.8 ± 0.5",
    "1.4 ± 0.6",
    "189 ± 25",
    "137 ± 18",
    "57 ± 12"
  ),
  `High Pressure` = c(
    "320 ± 30",
    "153 ± 14",
    "2.1 ± 0.3",
    "2.1 ± 0.4",
    "237 ± 31",
    "184 ± 20",
    "83 ± 15"
  ),
  `p-value` = c(
    "<0.001",
    "<0.01",
    "<0.001",
    "<0.001",
    "<0.001",
    "<0.001",
    "<0.001"
  ),
  check.names = FALSE
)

# Create flextable with professional formatting
ft <- flextable(table2_data) %>%
  font(fontname = "Times New Roman", part = "all") %>%
  fontsize(size = 10, part = "all") %>%
  bold(part = "header") %>%
  bg(part = "header", bg = "#E8E8E8") %>%
  color(part = "header", color = "#000000") %>%
  width(j = 1, width = 3.5) %>%
  width(j = 2:5, width = 1.6) %>%
  padding(padding = 3, part = "all") %>%
  align(align = "center", part = "all") %>%
  align(j = 1, align = "left", part = "all") %>%
  border_remove() %>%
  hline_top(part = "header", border = fp_border(color = "black", width = 1.5)) %>%
  hline_bottom(part = "header", border = fp_border(color = "black", width = 1)) %>%
  hline_bottom(part = "body", border = fp_border(color = "black", width = 1)) %>%
  height(height = 0.6, part = "header") %>%
  height(height = 0.8, part = "body") %>%
  set_caption(
    caption = "Table 2. Histopathological and Immunohistochemical Scoring by Anthropogenic Pressure",
    style = "Table Caption"
  ) %>%
  footnote(
    i = NULL,
    j = NULL,
    value = as_paragraph(
      "a Values are mean ± SD. VH:CD = villus height to crypt depth ratio."
    ),
    ref_symbols = "a",
    part = "body"
  )

# Save as Word document
doc <- read_docx() %>%
  body_add_par("Table 2", style = "heading 1") %>%
  body_add_par("Histopathological and Immunohistochemical Scoring by Anthropogenic Pressure", style = "Normal") %>%
  body_add_par("") %>%
  body_add_flextable(ft) %>%
  body_add_par("") %>%
  body_add_par(
    "Note: p-values are from ANOVA with post hoc Tukey test for continuous variables.",
    style = "Normal"
  )

print(doc, target = "Table2_Springer_EJWR_Word.docx")

cat("\n========================================\n")
cat("Table 2 created successfully!\n")
cat("========================================\n")
cat("File saved: Table2_Springer_EJWR_Word.docx\n")
cat("========================================\n")