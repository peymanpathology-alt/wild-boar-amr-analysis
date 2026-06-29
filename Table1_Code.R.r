# ============================================================
# TABLE 1. Demographic and Anthropogenic Characteristics
# of Sampled Wild Boars
# ============================================================

# Load required packages
library(flextable)
library(officer)
library(magrittr)
library(dplyr)

# Create dataset
table1_data <- data.frame(
  Variable = c(
    "Age (months, mean ± SD)",
    "Sex (M:F)",
    "Body Condition Score (1--5)",
    "Sampling Habitat"
  ),
  `Low Pressure (n = 28)` = c(
    "23.9 ± 11.5",
    "1.0:1",
    "3.2 ± 0.5",
    "Protected forest"
  ),
  `Moderate Pressure (n = 31)` = c(
    "25.1 ± 13.0",
    "1.2:1",
    "3.1 ± 0.4",
    "Mixed forest--agriculture"
  ),
  `High Pressure (n = 28)` = c(
    "24.7 ± 12.4",
    "1.1:1",
    "3.0 ± 0.5",
    "Peri‑urban farmland"
  ),
  `p-value` = c(
    "0.82",
    "0.91",
    "0.18",
    "---"
  ),
  check.names = FALSE
)

# Create flextable with professional formatting
ft <- flextable(table1_data) %>%
  font(fontname = "Times New Roman", part = "all") %>%
  fontsize(size = 10, part = "all") %>%
  bold(part = "header") %>%
  bg(part = "header", bg = "#E8E8E8") %>%
  color(part = "header", color = "#000000") %>%
  width(j = 1, width = 2.2) %>%
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
    caption = "Table 1. Demographic and Anthropogenic Characteristics of Sampled Wild Boars",
    style = "Table Caption"
  ) %>%
  footnote(
    i = NULL,
    j = NULL,
    value = as_paragraph(
      "a Values are mean ± SD for continuous variables. Habitat types are descriptive categories."
    ),
    ref_symbols = "a",
    part = "body"
  )

# Save as Word document
doc <- read_docx() %>%
  body_add_par("Table 1", style = "heading 1") %>%
  body_add_par("Demographic and Anthropogenic Characteristics of Sampled Wild Boars", style = "Normal") %>%
  body_add_par("") %>%
  body_add_flextable(ft) %>%
  body_add_par("") %>%
  body_add_par(
    "Note: p-values are from ANOVA for continuous variables and Chi-square test for sex ratios.",
    style = "Normal"
  )

print(doc, target = "Table1_Springer_EJWR_Word.docx")

cat("\n========================================\n")
cat("Table 1 created successfully!\n")
cat("========================================\n")
cat("File saved: Table1_Springer_EJWR_Word.docx\n")
cat("========================================\n")