# ============================================================
# SUPPLEMENTARY TABLE S1 - Metadata and Sampling Details
# ============================================================

library(flextable)
library(officer)
library(magrittr)

# Read data from Supplementary Material
metadata <- read.csv("TableS1_Metadata.csv")

# Create flextable
ft <- flextable(metadata) %>%
  font(fontname = "Times New Roman", part = "all") %>%
  fontsize(size = 8, part = "all") %>%
  bold(part = "header") %>%
  bg(part = "header", bg = "#E8E8E8") %>%
  align(align = "center", part = "all") %>%
  align(j = 1, align = "left", part = "all") %>%
  border_remove() %>%
  hline_top(part = "header", border = fp_border(color = "black", width = 1.5)) %>%
  hline_bottom(part = "header", border = fp_border(color = "black", width = 1)) %>%
  hline_bottom(part = "body", border = fp_border(color = "black", width = 1)) %>%
  set_caption(caption = "Supplementary Table S1. Metadata and sampling details for 87 wild boar individuals")

# Save as Word document
doc <- read_docx() %>%
  body_add_par("Supplementary Table S1", style = "heading 1") %>%
  body_add_par("Metadata and sampling details for 87 wild boar individuals", style = "Normal") %>%
  body_add_par("") %>%
  body_add_flextable(ft)

print(doc, target = "TableS1_Word.docx")

cat("✅ Supplementary Table S1 saved successfully!\n")