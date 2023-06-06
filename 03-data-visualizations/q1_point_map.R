library(tidy)
library(tmap)
library(sf)

colors <- c("#C7E0D7", "#083763", "#79A640")
data <- read_csv("/capstone/kelpgeomod/old_file_structure/analysis_data/synthesized/observed_nutrients_synthesized.csv") |> 
  st_as_sf(coords = c("lon", "lat")) |> 
  filter(nutrient_source != "lter_nitrate") |> 
  group_by(quarter, nutrient_source) |> 
  summarize(mean(nitrate_nitrite)) |> 
  filter(quarter == 1)

tmap_mode(mode = "view")
tm_shape(data) +
  tm_dots(col = "nutrient_source", 
          palette = colors, 
          size = .07) 
