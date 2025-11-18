## Description: pull basket weights from raw GAP survey tablet files
## Created by: Rebecca Haehn-Tam (rebecca.haehn@noaa.gov)
## Edited by:
## Created on: Nov 2025
## Updated on: 
## NOTES: Raw files are located in GAP G drive 
 

library(tidyverse)

# select METIS_LOAD_CSAMP_HAUL#.txt file
if (requireNamespace("rstudioapi", quietly = TRUE)) {
  species_haul <- rstudioapi::selectFile(caption = "Select _CASAMP_HAUL file", 
                                 existing = TRUE)
 
} 

# import haul species file
haul_species <- read.delim(species_haul, sep = ",", header = FALSE)

# select METIS_LOAD_CVAL_HAUL#.txt file
if (requireNamespace("rstudioapi", quietly = TRUE)) {
  basket_haul <- rstudioapi::selectFile(caption = "Select _CVAL_HAUL file", 
                                         #filter = "Text Files (*.txt);;All Files (*.*)", 
                                         existing = TRUE)
  
} 

#import basket weights
basket_weights <- read.delim(basket_haul, sep = ",", header = FALSE)

#join basket weights to species information in haul file
species_basket_weights <- basket_weights %>%
  dplyr::left_join(haul_species, by = c("V7" = "V6")) %>%
  dplyr::select(join_on = V7, species = V12.y, species_code = V11.y, imput_order = V6, weight = V9.x, unit = V10.x, count = V11.x, sample_type = V13.x, timestamp = V14.x)

