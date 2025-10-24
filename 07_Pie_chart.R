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
