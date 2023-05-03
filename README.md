# kelpGeoMod-capstone-project
This README.txt file was generated on 2023-05-02 by kelpGeoMod team

DEVELOPING A GEOSPATIAL MODEL FOR KELP FOREST CULTIVATION AND RESTORATION 

## **GENERAL INFORMATION**

#### A. Principal Investigator Contact Information

Name: Erika Egg
Institution: Bren School of Environmental Science & Management 
Email: egg@bren.ucsb.edu 


Name: Jessica French 
Institution: Bren School of Environmental Science & Management 
Email: jfrench@bren.ucsb.edu 


Name: Javier Patrón
Institution: Bren School of Environmental Science & Management  
Email: jpatron@bren.ucsb.edu 


Name: Elke Windschitl
Institution: Bren School of Environmental Science & Management 
Email: elke@bren.ucsb.edu


#### B. Associate or Co-investigator Contact Information
Name: Natalie Dornan
Institution: (UCSB IGPMS)
Email: nataliedornan@bren.ucsb.edu

#### C. Alternate Contact Information (Sam)
Name: Samantha Stevenson
Institution: Bren School of Environmental Science & Management  
Email: stevenson@bren.ucsb.edu 

#### D. Date of data collection or obtaining (single date, range, approximate date)

Obtained: January and February 2023
Date Range: 1st January 2014 - 1st January 2023

#### E. Geographic location of data collection: 

Point 1: -120.39, 34.59
Point 2: -118.48, 34.59
Point 3: -118.48, 33.51
Point 4: -120.39, 33.51



5\. Information about funding sources that supported the collection of the data: Look at original data sources below to find their information on data collection funding. This synthesis project was funded by the Bren School of Environmental Science & Management Master’s of Environmental Data Science at the University of California Santa Barbara.

## **SHARING/ACCESS INFORMATION**

#### 1\. Licenses/restrictions placed on the data: 

The present project is subject to the Creative Commons Attribution license, whereby all datasets utilized are publicly available. However, our proprietary cleaning and normalization techniques fall under this license. Accordingly, our processed data will be publicly accessible through our repository, located at: https://github.com/kelpGeoMod/kelpGeoMod-capstone-project. It is pertinent to acknowledge that every dataset utilized in this project was accompanied by specific usage restrictions, requiring an individualized review and analysis for each source.

#### 2\. Links to publications that cite or use the data: NA

#### 3\. Links to other publicly accessible locations of the data: See links in point 5

#### 4\. Links/relationships to ancillary data sets:
See links in point 5.

#### 5\. Was data derived from another source? 
SST: https://podaac.jpl.nasa.gov/dataset/MUR-JPL-L4-GLOB-v4.1?ids=Keywords&values=Oceans:Ocean%20Temperature&provider=POCLOUD 

##### Depth: 
https://www.ncei.noaa.gov/products/etopo-global-relief-model 

##### Kelp:
https://sbclter.msi.ucsb.edu/data/catalog/package/?package=knb-lter-sbc.74

##### Nutrients:
LTER Bottle:	https://sbclter.msi.ucsb.edu/data/catalog/package/?package=knb-lter-sbc.10

LTER Waves: https://sbclter.msi.ucsb.edu/data/catalog/package/?package=knb-lter-sbc.144 

CalCOFI: https://calcofi.org/data/oceanographic-data/bottle-database/ 

USGS 2018: https://www.sciencebase.gov/catalog/item/62a7ac5ad34ec53d2770c81f
USGS 2019: https://www.sciencebase.gov/catalog/item/62aa40bad34ec53d277115ce

Plumes and Blooms: http://www.oceancolor.ucsb.edu/plumes_and_blooms/

#### 6\. Recommended citation for the project:

Erika Egg, Jessica French, Javier Patrón, & Elke Windschitl. 2023. Developing a Geospatial Model for Kelp Forest Cultivation and Restoration. kelpGeoMod. https://github.com/kelpGeoMod/kelpGeoMod-capstone-project

## **DATA & FILE OVERVIEW**

#### 1\. File List: This link provides a list all files contained in the dataset, with a brief description of their content.

Link: https://docs.google.com/spreadsheets/d/1HR_xrE1kTqQGN9MN0-n7XIuDMotM1v1e56kE6-YUFT4/edit#gid=0


#### 2\. Relationship between files, if important: Each data file in this portion of the project is independent of one another. In general the data pipeline progresses from lower numbered R scripts to higher number R scripts.

#### 3\. Additional related data collected that was not included in the current data package: NA

#### 4\. Are there multiple versions of the dataset? 

Currently there is one version of the raw data in our project. See above links to investigate versions of the original data.

## **METHODOLOGICAL INFORMATION**

#### 1\. Description of methods used for collection/generation of data:

See links above and information below on how data were joined.

#### 2\. Methods for processing the data: 

##### SST: 
Use a for loop to create a raster brick that calculates the mean temperature for each quarter. This for loop does:
Read in each image. 
Convert the temperature values from Kelvin to Celsius. 
Stack the images into a raster stack. 
Calculate the mean temperature value for each pixel.
Create a function that takes the values of the quarters and years of interest. Use the function to create a raster brick with all 36 rasters (4 quarters per 9 years from 2014-2022). 
Create a function that splits and categorizes the quarters so that we can calculate the mean temperature for each category.
##### DEPTH: 
Wrangled into a tidy format
Filtered to time frame of 2014-2022
Mask applied to meet 0.008° x 0.008° spatial resolution, 33.85°- 34.59°N, 118.8°- 120.65°W  extent & position, coordinate reference system WGS 84
##### KELP AREA & BIOMASS:
Get area and biomass information from the raw netCDF using a for loop, limiting to our time period and area of interest
Generate a data frame with both variables’ information
Turn this into a spatial data frame and rasterize area and biomass separately into two rasterStacks
Aggregate these two rasterStacks closer to the correct resolution by summing, and then resample so that the mask can be applied
Mask applied to meet 0.008° x 0.008° spatial resolution, 33.85°- 34.59°N, 118.8°- 120.65°W  extent & position, coordinate reference system WGS 84
##### NUTRIENTS:
Wrangled into a tidy format
Filtered to time frame of 2014-2022
Joined into one data frame
Interpolated using inverse distance weighting with an inverse distance power of 1 and maximum distance parameter of 0.08°  (approx. 10 km)  on phosphate, ammonium, and combined nitrate and nitrite point data.  The scope of interpolation was limited to 5 km off the Santa Barbara Coast to ensure dense enough data coverage.
Mask applied to meet 0.008° x 0.008° spatial resolution, 33.85°- 34.59°N, 118.8°- 120.65°W  extent & position, coordinate reference system WGS 84


#### 3\. Instrument- or software-specific information needed to interpret the data: 

R version 4.2.2
RStudio Version: 2023.03.0+386 "Cherry Blossom" Release (3c53477afb13ab959aeb5b34df1f10c237b256c3, 2023-03-09) for macOS
Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7)
AppleWebKit/537.36 (KHTML, like Gecko)
RStudio/2023.03.0+386 
Chrome/108.0.5359.179 
Electron/22.0.3 
Safari/537.36
QGIS Version: 3.28.3-Firenze

R-packages used: 
 [1] naniar_1.0.0    lubridate_1.8.0 terra_1.6-17   
 [4] stars_0.5-6     abind_1.4-5     tmap_3.3-3     
 [7] janitor_2.1.0   raster_3.6-3    sf_1.0-8       
[10] sp_1.6-0        ncdf4_1.21      forcats_0.5.2  
[13] stringr_1.5.0   dplyr_1.1.0     purrr_1.0.1    
[16] readr_2.1.3     tidyr_1.3.0     tibble_3.2.1   
[19] ggplot2_3.4.1   tidyverse_1.3.2


#### 4\. Standards and calibration information, if appropriate: NA


#### 5\. Environmental/experimental conditions: NA



#### 6\. Describe any quality-assurance procedures performed on the data: 
See original data sources for individual quality-assurance procedures.


#### 7\. People involved with sample collection, processing, analysis and/or submission:
See original data sources for individual sample collection information. For data retrieval and synthesis, the following were involved:
Erika Egg (UCSB)
Jessica French (UCSB)
Javier Patron (UCSB)
Elke Windschitl (UCSB)


## **DATA-SPECIFIC INFORMATION FOR:** 
[synthesized-dataset.csv] 
1\. Number of variables: 10
2\. Number of cases/rows: 54065
3\. Variable List: 


Variable Name	Units/ Range	Type	Description
quarter	Range [1-4]	Numerical data	Quarter number per year. Range 1-4
year	Range [2014-2023]	Numerical data	Data year
lat	decimal degrees	Numerical data	Latitude in degrees
lon	decimal degrees	Numerical data	Longitudes in degrees
depth	meters	Numerical data	Ocean depth in meters
sst	celsius	Numerical data	Sea Surface temperature in Celsius
area	meters squared	Numerical data	Kelp area
biomass	kilograms	Numerical data	Kelp biomass
phosphate	mcmol/L (micromol per liter)	Numerical data	Concentration of phosphate in water
nitrate_nitrite	mcmol/L (micromol per liter)	Numerical data	Concentration of nitrate and nitrite in water
ammonium	mcmol/L (micromol per liter)	Numerical data	Concentration of ammonium in water



4\. Missing data codes: Missing data are noted as NA

5\. Specialized formats or other abbreviations used: NA
