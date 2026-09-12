# ============================================================================
# Pie chart of FAOSTAT crop-production shares in R (ggplot2)
#
# This script produced a figure in the peer-reviewed article:
#   Lemenkova, P. (2026). Statistical Analysis in R for Environmental
#   Monitoring using FAO Dataset. Journal of Anatolian Geography, 5(1), 1-14.
#   DOI:    https://doi.org/10.65652/jag.1777704
#   Zenodo: https://doi.org/10.5281/zenodo.19757771
#   HAL:    https://hal.science/hal-05602390v1
#   SSRN:   https://papers.ssrn.com/sol3/papers.cfm?abstract_id=6645898
#
# Author: Polina Lemenkova  |  ORCID: 0000-0002-5759-1089
# ============================================================================

# Libraries
library(tidyverse)
library(ggplot2)
library(dplyr)
library(forcats)
library(readr)
library(viridis)
library(viridisLite)
library(RColorBrewer)
library(ggrepel)
library(tidyverse)

df <- read_csv("FAOSTAT_2000.csv")
head(df)

# Basic piechart
ggplot(df, aes(x="", y=Value, fill=Item)) +
    geom_bar(stat="identity", width=1, linewidth=0.2, color="black") +
    labs(title = "Production of processed crops in India (T) (2000)") +
    coord_polar("y", start=0) +
    theme_void() + # remove background, grid, numeric labels
   geom_text(aes(label = refValue), position = position_stack(vjust = 0.5)) +
    scale_fill_viridis_d(option = "turbo")
