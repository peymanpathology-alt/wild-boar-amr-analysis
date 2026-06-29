# ============================================================
# TABLE 4. Prevalence of Enterobacteriaceae Lineages
# and Mobile Genetic Elements
# ============================================================

# Load required packages
library(flextable)
library(officer)
library(magrittr)
library(dplyr)

# Read data from CSV
table4_data <- read.csv("Table4_Data.csv")

# Create flextable with professional formatting
ft <- flextable(table4_data) %>%
  font(fontname = "Times New Roman", part = "all") %>%
  fontsize(size = 10, part = "all") %>%
  bold(part = "header") %>%
  bg(part = "header", bg = "#E8E8E8") %>%
  color(part = "header", color = "#000000") %>%
  width(j = 1, width = 3.0) %>%
  width(j = 2:5, width = 1.6) %>%
  width(j = 6, width = 1.6) %>%
  width(j = 7, width = 1.8) %>%
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
    caption = "Table 4. Prevalence of Enterobacteriaceae Lineages and Mobile Genetic Elements across anthropogenic pressure zones.",
    style = "Table Caption"
  ) %>%
  footnote(
    i = NULL,
    j = NULL,
    value = as_paragraph(
      "Significance: *** p < 0.001, ** p < 0.01, * p < 0.05, ns = not significant."
    ),
    ref_symbols = "a",
    part = "body"
  )

# Save as Word document
doc <- read_docx() %>%
  body_add_par("Table 4", style = "heading 1") %>%
  body_add_par("Prevalence of Enterobacteriaceae Lineages and Mobile Genetic Elements", style = "Normal") %>%
  body_add_par("") %>%
  body_add_flextable(ft) %>%
  body_add_par("") %>%
  body_add_par(
    "Note: Data are derived from shotgun metagenomic sequencing of 87 wild boar intestinal samples.",
    style = "Normal"
  )

print(doc, target = "Table4_Springer_EJWR_Word.docx")

cat("\n========================================\n")
cat("Table 4 created successfully!\n")
cat("========================================\n")
cat("File saved: Table4_Springer_EJWR_Word.docx\n")
cat("========================================\n")