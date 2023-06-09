# Create A Shapefile of our area of interest -120.65, 33.85, -118.80, 34.59 
#Load in libraries
library(tidyverse)
library(sf)
library(tmap)

# Create a data frame from the coordinates

coordinates <- tribble(
  ~lat, ~lon,
  34.59, -118.80, 
  33.85, -120.65, 
  34.59, -120.65, 
  33.85, -118.80
) |> 
  st_as_sf(coords = c("lon", "lat"), 
           crs = "EPSG: 4326") |> 
  st_bbox() |>  
  st_as_sfc()


# change your file path to wherever you want to save the shape file.
st_write(coordinates,
         "/capstone/kelpgeomod/google_drive_download/02-intermediate-data/02-aoi-sbchannel-shapes-intermediate/aoi-sbchannel.shp", 
         driver = "ESRI Shapefile", append = FALSE)


