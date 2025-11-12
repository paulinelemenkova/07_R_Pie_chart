# Libraries
library(ggplot2)
library(ggrepel)
library(tidyverse)
library(viridis)
library(viridisLite)
library(RColorBrewer)

df <- read_csv("LC_MODIS_2023.csv")
head(df)

# Basic piechart
ggplot(df, aes(x="", y=Value, fill=Item)) +
    geom_bar(stat="identity", width=1, linewidth=0.2, color="black", alpha=0.8) +
    labs(title = "Share of land cover types in Italy (km3) (2023)") +
    coord_polar("y", start=0) +
#    theme_void() + # remove background, grid, numeric labels
    geom_text(aes(label = Value), position = position_stack(vjust = 0.5)) +
#    scale_fill_viridis_d(option = "turbo")
    scale_fill_brewer(palette = "Set1")


#-------- EXAMPLE ------------->
df <- data.frame(value = c(15, 25, 32, 28),
                 group = paste0("G", 1:4))
# install.packages("ggplot2")
# install.packages("ggrepel")
# install.packages("tidyverse")
library(ggplot2)
library(ggrepel)
library(tidyverse)

# Get the positions
df2 <- df %>%
  mutate(csum = rev(cumsum(rev(value))),
         pos = value/2 + lead(csum, 1),
         pos = if_else(is.na(pos), value/2, pos))

ggplot(df, aes(x = "" , y = value, fill = fct_inorder(group))) +
  geom_col(width = 1, color = 1) +
  coord_polar(theta = "y") +
  scale_fill_brewer(palette = "Pastel1") +
  geom_label_repel(data = df2,
                   aes(y = pos, label = paste0(value, "%")),
                   size = 4.5, nudge_x = 1, show.legend = FALSE) +
  guides(fill = guide_legend(title = "Group")) +
  theme_void()
#-------- EXAMPLE -------------<
 

#--------- MY --------------->
df <- read_csv("LC_MODIS_2023.csv")
head(df)

df2 <- df %>%
  mutate(csum = rev(cumsum(rev(Value))),
         pos = Value/2 + lead(csum, 1),
         pos = if_else(is.na(pos), Value/2, pos))

ggplot(df, aes(x = "" , y = Value, fill = fct_inorder(Item))) +
  geom_col(width = 1, color = 1) +
  coord_polar(theta = "y") +
  scale_fill_brewer(palette = "Pastel1") +
  geom_label_repel(data = df2,
                   aes(y = pos, label = paste0(Value, " (T ha)")),
                   size = 5.5, nudge_x = 1, show.legend = FALSE) +
  guides(fill = guide_legend(title = "Land cover types\n(major categories\nfor Italy in 2023\nMODIS)")) +
  theme_void()
#--------- MY ---------------<
