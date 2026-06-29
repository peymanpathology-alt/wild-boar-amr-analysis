# ============================================================
# SUPPLEMENTARY TABLE S2 - Resistome Composition and ARG Abundance
# ============================================================

library(flextable)
library(officer)
library(magrittr)

# Read data from Supplementary Material
resistome_data <- read.csv("TableS2_Resistome_Data.csv")

# Create flextable
ft <- flextable(resistome_data) %>%
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
  set_caption(caption = "Supplementary Table S2. Resistome composition and antimicrobial resistance gene abundance in 87 wild boar samples")

# Save as Word document
doc <- read_docx() %>%
  body_add_par("Supplementary Table S2", style = "heading 1") %>%
  body_add_par("Resistome composition and antimicrobial resistance gene abundance", style = "Normal") %>%
  body_add_par("") %>%
  body_add_flextable(ft)

print(doc, target = "TableS2_Word.docx")

cat("✅ Supplementary Table S2 saved successfully!\n")