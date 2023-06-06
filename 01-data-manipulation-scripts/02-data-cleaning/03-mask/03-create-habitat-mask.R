library(sf)
library(tmap)
library(terra)
library(tidyverse)

data_dir <- "/capstone/kelpgeomod/google_drive_download"

# Make an empty raster of 0.00003 degree resolution
x <- rast() # make an empty raster
x

crs(x) <- "EPSG:4326" # confirm WGS84
crs(x)
ext(x) <- c(-120.65, -118.80, 33.85, 34.59) # set extent
ext(x)
res(x) <- c(0.00003, 0.00003) # set resolution, for the substrate data some are shape files, some is 2m and some is 5m, this is slightly more than 3m (3.33m) and hopefully splits the difference. 
res(x)

nrow(x) # identify how many rows we have
ncol(x) # identify how many columns we have
ncell(x) # identify how many total cells we have
values(x) <- 1 # fill in values 1-10873 by row

mask <- x

# Read in land bounds
boundaries <- st_read(file.path(data_dir, "01-raw-data/02-ca-county-land-boundaries-raw/California_County_Boundaries/cnty19_1.shp")) 


# Ensure CRS is WGS 84
boundaries <- st_transform(x = boundaries, crs = 4326)

# Convert bounderies to a spatVect object so it is compatible with terra.
boundaries <- vect(boundaries)

# Rasterize using terra:rasterize with the empty raster as the tempate.
boundaries <- rasterize(x = boundaries, 
                        y = mask)

# Switch classification so that land is NaN and water is 1
reclassification_matrix <- matrix(c(NaN, 1, 1, NaN), ncol = 2, byrow = TRUE)

land_bounds <- classify(boundaries, rcl = reclassification_matrix)

plot(land_bounds)

# Converts everything that is NaN in the landbounds to NaN in the mask so that land is NaN
mask <- mask * land_bounds


# Change this file path to your own to re-write data
terra::writeRaster(mask, "/capstone/kelpgeomod/google_drive_download/02-intermediate-data/03-mask-intermediate/habitat-mask.tif", filetype = "GTiff", overwrite = TRUE)
