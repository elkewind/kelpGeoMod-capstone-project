# Create A Shapefile of our area of interest -120.50, 33.83, -119.45, 34.49 (These are the old coords)
#Load in libraries
library(tidyverse)
library(sf)
library(tmap)

# Create a data frame from the coordinates

coordinates <- tribble(
  ~lat, ~lon,
  34.59, -118.80, 
  33.85, -120.85, 
  34.59, -120.85, 
  33.85, -118.80
) |> 
  st_as_sf(coords = c("lon", "lat"), 
           crs = "EPSG: 4326") |> 
  st_bbox() |>  
  st_as_sfc()


# change your file path to wherever you want to save the shape file.
st_write(coordinates,
         "/Users/jfrench/Documents/MEDS/Capstone/DATA/AOI_interpolation.shp", 
         driver = "ESRI Shapefile", overwrite = TRUE)
