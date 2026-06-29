# ============================================================
# TABLE 3. Resistome Diversity and Clinically Relevant ARGs
# ============================================================

# Load required packages
library(flextable)
library(officer)
library(magrittr)
library(dplyr)

# Create dataset
table3_data <- data.frame(
  `ARG Category` = c(
    "Total ARGs detected",
    "Shannon Diversity Index",
    "Multidrug efflux pumps",
    "β-lactamases (bla_CTX-M, bla_TEM, bla_SHV)",
    "Colistin resistance (mcr-1)",
    "Carbapenemases"
  ),
  `Low Pressure` = c(
    "174 ± 21",
    "3.2 ± 0.5",
    "32 ± 6",
    "14 ± 5",
    "0",
    "0"
  ),
  `Moderate Pressure` = c(
    "263 ± 28",
    "3.9 ± 0.6",
    "51 ± 8",
    "29 ± 7",
    "2 ± 1",
    "1 ± 1"
  ),
  `High Pressure` = c(
    "356 ± 32",
    "4.6 ± 0.4",
    "75 ± 9",
    "46 ± 8",
    "8 ± 3",
    "5 ± 2"
  ),
  `p-value` = c(
    "<0.001",
    "<0.001",
    "<0.001",
    "<0.001",
    "<0.001",
    "<0.001"
  ),
  check.names = FALSE
)

# Create flextable with professional formatting
ft <- flextable(table3_data) %>%
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
    caption = "Table 3. Resistome Diversity and Clinically Relevant ARGs",
    style = "Table Caption"
  )

# Save as Word document
doc <- read_docx() %>%
  body_add_par("Table 3", style = "heading 1") %>%
  body_add_par("Resistome Diversity and Clinically Relevant ARGs", style = "Normal") %>%
  body_add_par("") %>%
  body_add_flextable(ft)

print(doc, target = "Table3_Springer_EJWR_Word.docx")

cat("\n========================================\n")
cat("Table 3 created successfully!\n")
cat("========================================\n")
cat("File saved: Table3_Springer_EJWR_Word.docx\n")
cat("========================================\n")