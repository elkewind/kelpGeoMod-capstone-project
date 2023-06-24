# DEVELOPING A DATA PIPELINE FOR KELP FOREST MODELING

#### kelpGeoMod, A Capstone Project submitted in partial satisfaction of the requirements for the degree of Master of Environmental Data Science for the Bren School of Environmental Science & Management 

[![](04-README-images/kelp-image-underwater.jpg)](https://bren.ucsb.edu/projects/developing-data-pipeline-kelp-forest-modeling)

Giant kelp (Macrocystis pyrifera) is an ecosystem engineer that creates complex vertical habitat by growing to approximately 50 m in dense forests. Healthy kelp forests are some of the most diverse ecosystems in the world that also protect coastlines from storms, provide nutrients to beaches, and giant kelp is a promising biofuel precursor that does not take up arable land or use freshwater to grow. Researchers are working to better understand nutrient utilization and cycling in this critical ecosystem and need comprehensive data on nutrient concentrations to further their research. Additionally, kelp aquaculture companies are working to show that giant kelp can be grown as a profitable biofuel precursor in the Santa Barbara Channel. In order to do this they need to grow kelp efficiently in areas that have suitable habitat. This project creates a synthesized data set that can be used and expanded on by researchers to make their data acquisition process more efficient. It also produces estimates of habitat suitability for giant kelp in the Santa Barbara Channel that kelp aquaculture organizations can use to supplement prior analyses and guide where to place future farms.

To review the entire project please read the [technical documentation](04-README-images/technical-doc.pdf)

## **CONTACT INFORMATION**

#### Principal Investigator Contact Information

-   Erika Egg - [egg\@bren.ucsb.edu](mailto:egg@bren.ucsb.edu)

-   Jessica French - [jfrench\@bren.ucsb.edu](mailto:jfrench@bren.ucsb.edu)

-   Javier Patrón - [jpatron\@bren.ucsb.edu](mailto:jpatron@bren.ucsb.edu)

-   Elke Windschitl - [elke\@bren.ucsb.edu](mailto:elke@bren.ucsb.edu)

#### Associate or Co-investigator Contact Information

-   Natalie Dornan (UCSB IGPMS) - [nataliedornan\@bren.ucsb.edu](mailto:nataliedornan@bren.ucsb.edu)

#### Alternate Contact Information (Sam)

-   Samantha Stevenson (UCSB Bren School) - [stevenson\@bren.ucsb.edu](mailto:stevenson@bren.ucsb.edu)

## **GENERAL INFORMATION**

#### Date of data collection or obtaining

-   Obtained: January and February 2023

-   Date Range: 1st January 2014 - 31st December 2022

#### Geographic location of data collection:

-   Coordinates used to delimit the Santa Barbara Channel 33.85°- 34.59°N, 118.8°- 120.65°W

    ![](04-README-images/aoi.png)

## **SHARING/ACCESS INFORMATION**

#### Licenses/restrictions placed on the data:

All the final product and data sets were published under the Creative Commons Zero (CC0) intellectual property laws to enable public use. This was done to promote transparency, facilitate data sharing, and enable external users, such as researchers, stakeholders, and kelp farmers, to access and use our project's data. Accordingly, our processed data will be publicly accessible through our [repository](https://github.com/kelpGeoMod/kelpGeoMod-capstone-project). It is pertinent to acknowledge that every data set utilized in this project was accompanied by specific usage restrictions, requiring an individualized review and analysis for each source.

#### Data Sources:

Observed Data:

-   [Kelp](https://sbclter.msi.ucsb.edu/data/catalog/package/?package=knb-lter-sbc.74)

Environmental Factors:

-   [SST](https://podaac.jpl.nasa.gov/dataset/MUR-JPL-L4-GLOB-v4.1?ids=Keywords&values=Oceans:Ocean%20Temperature&provider=POCLOUD)

-   [Depth](https://www.ncei.noaa.gov/products/etopo-global-relief-model)

-   [LTER Bottle](https://sbclter.msi.ucsb.edu/data/catalog/package/?package=knb-lter-sbc.10)

-   [LTER Waves](https://sbclter.msi.ucsb.edu/data/catalog/package/?package=knb-lter-sbc.144)

-   [CalCOFI](https://calcofi.org/data/oceanographic-data/bottle-database/)

-   [USGS 2018](https://www.sciencebase.gov/catalog/item/62a7ac5ad34ec53d2770c81f)

-   [USGS 2019](https://www.sciencebase.gov/catalog/item/62aa40bad34ec53d277115ce)

-   [Plumes and Blooms](http://www.oceancolor.ucsb.edu/plumes_and_blooms/)

![](04-README-images/kelp-image-above.jpg)

For the kelpGeoMod kelp data, we utilized the LTER remote sensing dataset derived from Landsat sensors described in the data sources above. This image represents an aerial shot of a Macrocystis pyrifera forest in California.

## **DATA PIPELINE & FILE OVERVIEW**

#### Data Pipeline:

In order to make this project reproducible and easy for the clients to continue in the future, all of the code used to create each data product and the model results is provided in this open source [GitHub Repository](https://github.com/kelpGeoMod/kelpGeoMod-capstone-project). To aid others in navigating the project a comprehensive [User Guide](04-README-images/user-guide.pdf) in combination of this GitHub repository, and the project schematic [Project Schematic](04-README-images/schematic.pdf) form the data pipeline which will make it possible for future users to use and build upon the project.

#### File Path/ Working directory:

Currently, all the file paths are directed to where the kelpGeoMod Google Drive was stored. It's important to mention that for reproducibility purposes, setting the working directory using **`data_dir`** at the beginning of each R Markdown file, sets where the data is being pulled from. Absolute file path are used when writing data to not accidentally overwrite original data. Its highly recommended to set the new working directory to where you want the files to be written.

#### Instrument- or software-specific information needed to interpret the data:

-   RStudio Version: 2023.03.0+386 "Cherry Blossom" Release (3c53477afb13ab959aeb5b34df1f10c237b256c3, 2023-03-09) for macOS

-   Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7)

-   AppleWebKit/537.36 (KHTML, like Gecko)

-   RStudio/2023.03.0+386

-   Chrome/108.0.5359.179

-   Electron/22.0.3

-   Safari/537.36

-   QGIS Version: 3.28.3-Firenze

#### R-packages used:

In this table, we have displayed all the packages that are loaded into our R Markdown environments. It is important to note that packages and their versions change over time as developers release updates and improvements to the R community. Here is a brief description of each package:

| **Package**  | **Description**                                                              |
|-----------------------|-------------------------------------------------|
| cmocean      | Color palettes based on oceanographic and atmospheric data                   |
| dismo        | Species distribution modeling and ecological niche modeling                  |
| doParallel   | Parallel computing with foreach and iterators frameworks                     |
| dplyr        | Grammar of data manipulation with consistent set of verbs for transformation |
| ENMeval      | Model selection and evaluation for ecological niche models                   |
| ggplot2      | Flexible and powerful system for creating visualizations                     |
| gstat        | Geostatistical modeling, prediction, and simulation                          |
| gridExtra    | Arranging multiple grid-based plots on a page                                |
| httr         | Tools for working with HTTP and web APIs                                     |
| janitor      | Utilities for data cleaning and tabulation                                   |
| leaflet      | Interactive maps using the Leaflet JavaScript library                        |
| lubridate    | Easier handling of dates and times in R                                      |
| mapview      | Interactive viewing of spatial objects and raster maps                       |
| ncdf4        | High-level interface to netCDF data files                                    |
| naniar       | Functions for exploring and imputing missing data                            |
| paletteer    | Collection of color palettes for data visualization                          |
| raster       | Tools for working with raster data                                           |
| RColorBrewer | Color palettes from Cynthia Brewer's ColorBrewer                             |
| rgeos        | R interface to the GEOS library for geometric operations                     |
| sf           | Simple features for manipulating and analyzing spatial data                  |
| sjPlot       | Beautiful and customizable visualizations for statistical results            |
| sp           | Classes and methods for spatial data handling                                |
| spThin       | Spatial point thinning preserving spatial patterns                           |
| stars        | Classes and methods for working with raster and vector data                  |
| stringr      | Set of string manipulation functions                                         |
| tictoc       | Simple timer for benchmarking code execution time                            |
| tidyverse    | Collection of R packages for data manipulation and visualization             |
| tmap         | Thematic maps                                                                |
| wallace      | Run the wallace shiny app for MaxEnt modeling                                |

## **SYNTHESIZED DATA SETS INFORMATION:**

#### `full-synthesized.csv`

We consolidated all the collected and cleaned data into this single file. In this case, we used the depth values as our primary key and performed a left join with the raster bricks data frame, generating a total of 486,576 rows made from the 13,516 pixels per each quarter and then multiplied by the 9 years of data extension.

**1. Number of variables:** 11

**2. Number of cases/rows:** 486,576

**3. Variable List:**

| **Variable Name** | **Units/ Range**             | **Type** | **Description**                               |
|------------------|------------------|------------------|--------------------|
| year              | Range [2014-2022]            | Numeric   | Data year                                     |
| quarter           | Range [1-4]                  | Numeric   | Quarter number per year. Range 1-4            |
| lat               | decimal degrees              | Numeric   | Latitude in degrees                           |
| lon               | decimal degrees              | Numeric   | Longitudes in degrees                         |
| depth             | meters                       | Numeric  | Ocean depth in meters                         |
| sst               | celsius                      | Numeric  | Sea Surface temperature in Celsius            |
| kelp area         | meters squared               | Numeric  | Kelp area                                     |
| kelp biomass      | kilograms                    | Numeric  | Kelp biomass                                  |
| phosphate         | mcmol/L (micromol per liter) | Numeric  | Concentration of phosphate in water           |
| nitrate_nitrite   | mcmol/L (micromol per liter) | Numeric  | Concentration of nitrate and nitrite in water |
| ammonium          | mcmol/L (micromol per liter) | Numeric  | Concentration of ammonium in water            |

#### `observed-nutrients-sythesized.csv`

This data set displays the remote sensing data collection for each observed nutrient data point. In this case, we used the in-situ joined nutrient data set as the primary key and extracted values from the raster bricks. We had 3,059 data points in total, with all the 15 variables included.

**1. Number of variables:** 15

**2. Number of cases/rows:** 3,059

**3. Variable List:**

| **Variable Name** | **Units/ Range**             | **Type**  | **Description**                               |
|------------------|------------------|------------------|--------------------|
| year              | Range [2014-2023]            | Numeric    | Data year                                     |
| quarter           | Range [1-4]                  | Numeric    | Quarter number per year. Range 1-4            |
| lat               | decimal degrees              | Numeric    | Latitude in degrees                           |
| lon               | decimal degrees              | Numeric    | Longitudes in degrees                         |
| temp              | celsius                      | Numeric   | Sea Surface temperature in Celsius            |
| nitrate           | mcmol/L (micromol per liter) | Numeric   | Concentration of nitrate and nitrite in water |
| nitrite           | mcmol/L (micromol per liter) | Numeric   | Concentration of nitrate and nitrite in water |
| nitrate_nitrite   | mcmol/L (micromol per liter) | Numeric   | Concentration of nitrate and nitrite in water |
| phosphate         | mcmol/L (micromol per liter) | Numeric   | Concentration of phosphate in water           |
| ammonium          | mcmol/L (micromol per liter) | Numeric   | Concentration of ammonium in water            |
| sst               | celsius                      | Numeric   | Sea Surface temperature in Celsius            |
| nutrient_source   | distinct data sets           | Character | Specific nutrient data sets                   |
| depth             | meters                       | Numeric   | Ocean depth in meters                         |
| kelp area         | meters squared               | Numeric   | Kelp area                                     |
| kelp biomass      | kilograms                    | Numeric   | Kelp biomass                                  |

### Recommended Citation for the Project:

Egg, E., French, J., Patrón, J., & Windschitl, E. (2023). Developing a data pipeline for kelp forest modeling. <https://github.com/kelpGeoMod/kelpGeoMod-capstone-project>.

People involved with sample collection, processing, analysis, and/or submission: Please refer to the original data sources for individual sample collection information. For data retrieval and synthesis, the following individuals were involved: Erika Egg (UCSB), Jessica French (UCSB), Javier Patrón (UCSB), and Elke Windschitl (UCSB).

### Acknowledgements
We acknowledge the Bren School of Environmental Science & Management's Master's of Environmental Data Science program at the University of California Santa Barbara for funding this synthesis project. We would also like to express our gratitude to our clients, Courtney Schatzman from Ocean Rainforest and Natalie Dornan from UCSB interdepartmental Graduate Program in Marine Science (IGPMS), as well as Sidney Gerst and Kirby Bartlett for providing user information, Jeff Massen for user testing and being the main contact as a kelp farmer, and Daphne Virlar-Knight from NCEAS for helping us explore different options for MaxEnt modeling. We are also grateful to Tamma Carleton, Shubhi Sharma and Kevin Winner for their expertise and guidance in statistics and species distribution modeling. Lastly, we are grateful to Dr. Li Kui and Carrie Bretz for their assistance in accessing and processing data from the SBC LTER and Seafloor Mapping Lab at California State University, Monterey Bay.

[![](04-README-images/logo-bren.svg)](https://bren.ucsb.edu/masters-programs/master-environmental-data-science)
