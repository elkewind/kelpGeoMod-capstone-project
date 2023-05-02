# Create A Shapefile of our area of expanded area interest -123.32, 30.59, -115.70, 36.08
#Load in libraries
library(tidyverse)
library(sf)


# Create a data frame from the coordinates

coordinates <- tribble(
  ~lat, ~lon,
  30.59, -123.32, 
  30.59, -115.70, 
  36.08, -123.32, 
  36.08, -115.70
) |> 
  st_as_sf(coords = c("lon", "lat"), 
           crs = "EPSG: 4326") |> 
  st_bbox() |>  
  st_as_sfc()


# change your file path to wherever you want to save the shape file.
st_write(coordinates,
         "/Users/jfrench/Documents/MEDS/Capstone/DATA/Expaned_AOI_SBchannel.shp", 
         driver = "ESRI Shapefile")



