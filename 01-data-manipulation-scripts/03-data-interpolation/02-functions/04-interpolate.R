# Uses no_geom list to create formulas using gstat, applies those formulas using interpolate from terr package and user supplied mask. Save results as a list of interpolated rasters. 

# no_geom_list: created by idw_implement_no_geom. Is a list of data frames with x and y columns, the quarter, and the nutrient measurement. 

#nutrient: the name of the nutrient you are doing the interpolation for. 

# mask: a blank raster of the area you are interpolating. 

# idp: The inverse distance parameter (see gstat: https://bookdown.org/igisc/EnvDataSci/spatial-interpolation.html) default is 4 

idw_interpolate <- function(no_geom_list,
                            nutrient,
                            mask, 
                            idp = 1,
                            max_distance = 0.08) {
  
  # create empty list
  formula_list <- list()
  # loop to define formula
  for (i in seq_along(no_geom_list)) {
    # define gstat formula
    formula <- gstat(formula = as.formula(paste0(nutrient, "~ 1")),
                     locations = ~x+y, 
                     data = no_geom_list[[i]], 
                     nmax = Inf, 
                     maxdist = max_distance,
                     set = list(idp = idp))
    
    formula_list[[i]] <- formula
    #######################################################
    ########### END LOOP 1 ################################
  }
  
  # create empty list
  interpolate_list <- list()
  
  # loop to interpolate
  for (i in seq_along(formula_list)) {
    interpolation <- interpolate(mask, formula_list[[i]], debug.level = 0) |> 
    mask(mask)
    names(interpolation) <- c(paste0(nutrient, "_Q", i), "var1.var")
    
    interpolate_list[[i]] <- interpolation
  }
  
  return(interpolate_list)
  
}

