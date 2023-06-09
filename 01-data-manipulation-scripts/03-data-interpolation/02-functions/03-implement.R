# function that takes nutrient_quarter_df_list created by idw_prep_quarters and rasterizes each element.

# inputs #
# nutrient name: should be the same as nutrient_quarter_df_list
    # EXAMPLE: if you use phosphate_quarter_df_list and input then nutrient_name = phosphate.
# nutrient_quarter_df_list
# mask to be applied to create the raster. 

idw_implement_rasterize <- function (nutrient_quarter_df_list, 
                                     nutrient_name, 
                                     mask, 
                                     all = FALSE) {
  
  message(paste("Make sure the nutrient_name and nutrient_quarter_df_list match."))
  
  # create empty list for storage
  rast_list <- list()
  
  # phosphate_quarter_df_list is created by idw_prep_quarter
  for (i in seq_along(nutrient_quarter_df_list)) {
    # convert dataframe to SpatVect
    vect_i <- terra::vect(nutrient_quarter_df_list[[i]])
    # Rasterize using the mask. 
    rast <- terra::rasterize(vect_i, mask, field = nutrient_name)
    # assign informative name to layer
    names(rast) <- c(paste0(nutrient_name, "_Q", i))
    
    # assign to index in phosphate_rast_list
    if (all) {
      rast_list <- c(rast_list, rast)
    } else {
      # assign to index in rast_list
      if (!any(!is.na(values(rast)))) {
        message(paste("The dataframe at index", i, "had no values"))
      } else {
        rast_list <- c(rast_list, rast)
      }
    }
  }
  
  return(rast_list)
}

#######################################################
#### END of idw_rasterize##############################
#######################################################

# function that takes nutrient_quarter_df_list created by idw_prep_quarters converts it to a data frame and removes the geometry column. 

idw_implement_no_geom <- function(nutrient_quarter_df_list, all = FALSE) {
  # create an empty list
  no_geom_list <- list()
  # convert to data frame and remove the geometry column 
  for (i in seq_along(nutrient_quarter_df_list)) {
    df <- as.data.frame(nutrient_quarter_df_list[[i]]) |> 
      dplyr::select(-geometry)
    
    if (all) {
      no_geom_list[[i]] <- df
    } else {
  # assign to index in phosphate_rast_list
      if (!all(is.na(df))) {
        no_geom_list[[i]] <- df
      } else {
        message(paste("The dataframe at index", i, "had no values"))
      }
    }
    
    # Remove NULL elements from the list
    no_geom_list <- no_geom_list[!sapply(no_geom_list, is.null)]
}
  return(no_geom_list)
}


