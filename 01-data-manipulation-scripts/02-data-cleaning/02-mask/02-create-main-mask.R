#---- Load libraries
library(sf)
library(tmap)
library(terra)
library(tidyverse)
library(cmocean)

#---- Set up the data directory (wherever your download of our Google Shared Drive lives)
data_dir <- "/capstone/kelpgeomod/google_drive_download"


#---- Make an empty raster of 0.008 degree resolution in WGS84 with our AOI
x <- rast() # make an empty raster
x

crs(x) <- "EPSG:4326" # confirm/set WGS84
crs(x)
ext(x) <- c(-120.65, -118.80, 33.85, 34.59) # set extent
ext(x)
res(x) <- c(0.008, 0.008) # set resolution
res(x)

# Explore the size of the raster
nrow(x) # identify how many rows we have
ncol(x) # identify how many columns we have
ncell(x) # identify how many total cells we have

values(x) <- 1 # fill in values of 1

mask <- x # rename to mask



#---- Remove land boundaries from the mask
# Read in land shapefile 
boundaries <- st_read(file.path(data_dir, "01-raw-data/02-ca-county-land-boundaries-raw/California_County_Boundaries/cnty19_1.shp"))

boundaries <- st_transform(x = boundaries, crs = 4326) # Transform crs to exact crs we want
boundaries <- vect(boundaries) # Make a terra vector object
boundaries <- terra::rasterize(x = boundaries, 
                        y = mask) # Rasterize to a terra raster object with ext of mask

# Create a reclassification matrix so land = 0
reclassification_matrix <- matrix(c(NaN, 1, 1, NaN), 
                                  ncol = 2, 
                                  byrow = TRUE) 
# Apply classification matrix
land_bounds <- classify(boundaries, rcl = reclassification_matrix)
plot(land_bounds) # plot to check
mask <- land_bounds # make this the new mask



#---- Plot nicer for viz
colors1 <- cmocean("diff")(5) # Bring in a palette
tmap_mode("plot") # set to plot mode
tm_shape(mask) +
  tm_raster(palette = colors1,
            legend.show = FALSE)


#---- Write to data files
terra::writeRaster(mask, "mask/mask_rast.tif", filetype = "GTiff", overwrite = TRUE)

