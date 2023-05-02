


# Create function that only calculates RMSE
RMSE <- function(observed, predicted) {
  sqrt(mean((predicted - observed)^2, na.rm=TRUE))
}



# Create a function that calculates the RMSE of the interpolated nutrient rasters. 
idw_rmse <- function(no_geom_list, nutrient, k = 10, max_distance = 0.08, idp = 1) {
  
  message("Make sure max_distance and idp are the same as idw_interpolate(), if they are not the rmse values will not be representative.")
  
  ## Calculate Null ----
  # Establish the null value of RMSE
  null_list <- list() # create empty list
  k <- k # set number of folds
  mean_rmse_list <- list()
  
  for (i in seq_along(no_geom_list)) {
    nutrient_df <- no_geom_list[[i]]

    # calculate the null to compare to
    null <- RMSE(mean(nutrient_df[[nutrient]]), nutrient_df[[nutrient]])

    # resolve back to sample standard deviation to acount for differences in sample size
    n <- length(nutrient_df[[nutrient]])
    null_list[[i]] <- null }
    
  ######################################################################################
  ################### END LOOP CALCULATING THE NULL ####################################
    
  
    ## Nested loop to calculate rmse ----
    # loop through list of data frames
    for (i in seq_along(no_geom_list)) {
      rmse <- rep(NA, k) # creates empty list for rmse values
      nutrient_df <- no_geom_list[[i]] # grabs df at each index
      # take k random samples from data frame. 
      set.seed(123)
      kf <- sample(1:k, size = nrow(nutrient_df), replace=TRUE)
    for (j in 1:k) { # loop through validation folds
      set.seed(123)
      test <- nutrient_df[kf == j, ] # test data
      train <- nutrient_df[kf != j, ] # train data
      
      # create formula
      gs <- gstat(formula = as.formula(paste0(nutrient, "~ 1")),
                  locations = ~x+y, 
                  data = train, 
                  nmax = Inf, 
                  maxdist = max_distance,
                  set = list(idp = idp))
      p <- predict(gs, test, debug.level=0) # generate predictions
      rmse[j] <- RMSE(test[[nutrient]], p$var1.pred)
    }
      # Populate dictionary with nutrient_Q# as the key and mean_rmse, nullm and relative performance as the values. 
      mean_rmse_list[[paste0(nutrient, "_Q", i)]] <- list("mean_rmse" = mean(rmse),
                                                          "null" = null_list[[i]], 
                                                          "relative_performance" = 1 - (mean(rmse) / null_list[[i]]))
    }
  
  # Convert list to data frame
  df <- data.frame(matrix(unlist(mean_rmse_list), nrow=length(mean_rmse_list), byrow=T))
  #df <- df[, c("X1", "X2", "X3", "X4")]
  colnames(df) <- c("mean_rmse", "null", "relative_performance") 
  df <- mutate(df, "nutrient_quarter" = "") 
  
  for (i in seq_along(df$mean_rmse)) {
    df$nutrient_quarter[[i]] <- paste0(nutrient, "_Q", i)
  }
    
    return(df)  
}

