# R ggplot2 Pie Charts — Land-Cover and Crop-Production Proportions

R scripts for building publication-quality pie (polar) charts of categorical
proportions with the ggplot2 grammar of graphics. The charts summarise thematic
shares from two data domains: FAOSTAT agricultural crop production and MODIS
land-cover classification. The scripts demonstrate the stacked-bar-to-polar
construction of pie charts, cumulative-sum angular label positioning,
force-directed label placement, perceptually-uniform and qualitative colour
schemes, and multi-panel figure composition.

## Related publication

The FAOSTAT script (pie_chart_ggplot2_faostat_crops.R) produced a figure in:

Lemenkova, P. Statistical Analysis in R for Environmental Monitoring using FAO
Dataset. Journal of Anatolian Geography 2026, 5(1), 1-14.

- DOI:    https://doi.org/10.65652/jag.1777704
- Zenodo: https://doi.org/10.5281/zenodo.19757771
- HAL:    https://hal.science/hal-05602390v1
- SSRN:   https://papers.ssrn.com/sol3/papers.cfm?abstract_id=6645898
- ISSN:   3023-8978

## Scripts

### pie_chart_ggplot2_faostat_crops.R
A single-panel pie chart of processed-crop production shares (FAOSTAT, tonnes),
used to produce a figure in the article cited above. Method: a one-column
stacked bar (geom_bar with stat = "identity", constant x) is wrapped into a
circle by the polar-coordinate transform coord_polar("y"), which maps the
stacked-count axis onto the angular dimension so that each category occupies an
arc proportional to its value. Chart junk (axes, grid, panel background, numeric
labels) is stripped with theme_void(). Slice labels are placed at the cumulative
mid-height of each segment with position_stack(vjust = 0.5). Fill uses the
discrete viridis "turbo" colour map (scale_fill_viridis_d), a perceptually-
ordered rainbow scheme.

### pie_chart_ggplot2_modis_landcover.R
A two-epoch comparison of MODIS land-cover class shares (2001 vs 2023),
composed as a side-by-side two-panel figure. Additional methods over the basic
chart:

- Angular label positioning by cumulative sums: the mid-angle radius of each
  slice is computed as csum = rev(cumsum(rev(Value))) and
  pos = Value/2 + lead(csum, 1), i.e. the running total from the last category
  inward plus half the current slice. This places each label at the exact
  angular centre of its wedge (a dplyr mutate pipeline).
- Force-directed (repulsive) label placement with ggrepel
  (geom_label_repel, nudge_x), which iteratively displaces overlapping labels
  along a spring/repulsion model so that annotations of thin slices do not
  collide.
- Deterministic category ordering with forcats::fct_inorder, fixing wedge order
  to the data order rather than alphabetical.
- Qualitative ColorBrewer palettes (scale_fill_brewer, "Set1"/"Set3") for
  categorical, colour-blind-aware class distinction.
- Multi-panel composition with gridExtra::grid.arrange / arrangeGrob and a
  grid::textGrob supertitle, arranging the two annual charts (p1, p2) on one
  canvas for direct visual change detection between epochs.
- High-resolution export with ggsave to raster (JPG, 300 dpi) and vector (PDF).

## Methods and algorithms

- Grammar of graphics (ggplot2): additive layer composition of geoms, scales,
  coordinate systems and themes.
- Pie construction: stacked bar under a polar coordinate transform
  (coord_polar), the canonical ggplot2 idiom for pie/donut charts.
- Angular label geometry: cumulative-sum (cumsum) mid-slice positioning.
- Label de-confliction: ggrepel force-directed text/label repulsion.
- Colour mapping: viridis/turbo perceptually-uniform maps and ColorBrewer
  qualitative palettes.
- Data wrangling: readr CSV ingestion (read_csv) and dplyr mutate pipelines
  with lead()/rev() window operations.
- Figure layout: grid / gridExtra graphical-object (grob) arrangement.

## Data sources

- FAOSTAT: FAO Corporate Statistical Database, crop-production quantities
  (FAOSTAT_2000.csv).
- MODIS land cover: MODIS land-cover class areas by category
  (LC_MODIS_2001.csv, LC_MODIS_2023.csv).

The input CSV files are expected in the working directory; each has an Item
(category) and a Value (quantity) column.

## Requirements

- R (>= 4.0)
- Packages: tidyverse (ggplot2, dplyr, readr, forcats), ggrepel, viridis,
  viridisLite, RColorBrewer, grid, gridExtra

Install with:

    install.packages(c("tidyverse", "ggrepel", "viridis", "viridisLite",
                       "RColorBrewer", "gridExtra"))

## Usage

Place the required CSV file(s) in the working directory and run, e.g.:

    Rscript pie_chart_ggplot2_modis_landcover.R

Each script reads its CSV, builds the chart(s), and writes raster/vector output
via ggsave.

## Author and citation

Polina Lemenkova
ORCID: https://orcid.org/0000-0002-5759-1089

If you use the FAOSTAT script, please cite:

Lemenkova, P. Statistical Analysis in R for Environmental Monitoring using FAO
Dataset. Journal of Anatolian Geography 2026, 5(1), 1-14.
https://doi.org/10.65652/jag.1777704

## License

No license file is currently included. For reuse terms, please contact the
author via the ORCID record above.
