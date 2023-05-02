# Create two function that takes a variable name in the joined_nutrients RDS file, cleans the data and prepares it for interpolation with the gstat package. idw_prep_quarters returns a list of data frames one for each quarter (4) and idw_prep_year_quarter returns a list of data frames one for each year and quuarter (36)

idw_prep_quarters <- function(nutrient, df) {
# Takes as inputs the name of a nutrient in the nutrients datafame(the result of the joined nutrients script) and what you chose to call the joined nutrients object when you read it in.   
  
  
  # Check that the variable entered is in the nutrients data frame.----
  if (nutrient %in% colnames(df)) {
  message(paste("prepping", nutrient))
  } else {
    message(paste("Please choose a nutrient in", df))
  }
  
  # clean data ----
  temp_df <- df |> 
    dplyr::select(quarter, year, geometry, nutrient) |>
    # remove NA values, allows us to calculate a quarterly mean. 
    drop_na(nutrient) |> 
    # convert geometry column to latitude and longitude, the formula and intepolation functions look for x and y specifically and they need to in separate columns.
    mutate(lon = unlist(map(geometry,1)),
           lat = unlist(map(geometry,2))) |> 
    # rename lon and lat to x and y so they are compatible with gstat formula and inteprolation function.
    rename(x = lon,
           y = lat)
  
  # create dataframes by quarter ----
  quarters <- c(1:4)
  quarter_df_list <- list()
  
  for (quarter in quarters) {
    temp_df_2 <- temp_df |> 
      filter(quarter == {{quarter}}) |> 
      group_by(x, y, quarter) |> 
      # this is from chatGPT so that it would evaluate the nutrient that nutrient represents and not the word nutrient. 
      summarize(!!sym(nutrient) := mean(!!sym(nutrient)))
    
    # add each quarter data frame to a list
    quarter_df_list[[quarter]] <- temp_df_2

  }
  assign(paste0(nutrient, "_quarter_df_list"), 
         quarter_df_list,
         envir = parent.frame(2))
  return(quarter_df_list)
}


##############################################
########END FUNCTION idw_prep_quarters()######
##############################################

idw_prep_year_quarters <- function(nutrient, 
                                   df,
                                   start_year = 2014, 
                                   end_year = 2022) {
  # Takes as inputs the name of a nutrient in the nutrients datafame(the result of the joined nutrients script) and what you chose to call the joined nutrients object when you read it in.   
  
  
  # Check that the variable entered is in the nutrients data frame.----
  if (nutrient %in% colnames(df)) {
    message(paste("prepping", nutrient))
  } else {
    message(paste("Please choose a nutrient in", df))
  }
  
  # clean data ----
  temp_df <- df |> 
    dplyr::select(quarter, year, geometry, nutrient) |>
    # remove NA values, allows us to calculate a quarterly mean. 
    drop_na(nutrient) |> 
    # convert geometry column to latitude and longitude, the formula and intepolation functions look for x and y specifically and they need to in separate columns.
    mutate(lon = unlist(map(geometry,1)),
           lat = unlist(map(geometry,2))) |> 
    # rename lon and lat to x and y so they are compatible with gstat formula and inteprolation function.
    rename(x = lon,
           y = lat)
  
  # create dataframes by year and quarter ----
  quarters <- c(1:4)
  years <- c(start_year:end_year)
  year_quarter_df_list <- list()
  index <- 1
  for (year in years) {
    for(quarter in quarters) {

    temp_df_2 <- temp_df |>
      filter(quarter == {{quarter}} & year == {{year}}) |>
      group_by(x, y, year, quarter) |>
      
      # this is from chatGPT so that it would evaluate the nutrient that nutrient represents and not the word nutrient.
      summarize(!!sym(nutrient) := mean(!!sym(nutrient)))

    # # add each quarter data frame to a list
    year_quarter_df_list[[index]] <- temp_df_2
    index <- index + 1

  }}
  assign(paste0(nutrient, "_year_quarter_df_list"), 
         year_quarter_df_list,
         envir = parent.frame(2))
  return(year_quarter_df_list)
}

