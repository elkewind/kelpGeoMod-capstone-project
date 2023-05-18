library(sf)
library(tidyverse)
library(tmap)

# read in shape file
sb_coast <- st_read("/capstone/kelpgeomod/old_file_structure/raw_data/interpolation_shapes/sbc_coast.shp")

# read in ca counties
ca_counties <- st_read("/capstone/kelpgeomod/old_file_structure/raw_data/land_bounds/California_County_Boundaries/cnty19_1.shp") |> 
  st_transform("EPSG: 4326")


# read in aoi 
aoi <- st_read("/capstone/kelpgeomod/old_file_structure/raw_data/New_AOI_SBchannel_shp/New_AOI_SBchannel.shp") 

# crop ca counties to aoi 
counties_crop <- st_crop(ca_counties, aoi) |> 
  st_union()

tm_shape(counties_crop) +
  tm_polygons(col = "#D6C78C", alpha = 0.5) +
  tm_shape(sb_coast) +
  tm_polygons(col = "aquamarine4", alpha = 0.5) +
  tm_add_legend(type = "fill", 
                labels = c("Interpolated Area"), 
                col = c("aquamarine4"), 
                alpha = 0.5) +
  tm_layout(legend.position = c(0.005, 0.005))
  
