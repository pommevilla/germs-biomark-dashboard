library(flexdashboard)
library(tidyverse)
library(ggtext)
library(glue)
library(shiny)
library(shinyWidgets)
library(gt)
library(DT)
library(plotly)
library(mongolite)
library(vegan)

########### ggplot theme

theme_set(
  theme_light()
)


########### Setup

# Read in MongoDB credentials/credential string
readRenviron(".env")
connection_string <- Sys.getenv("MONGODB_URI")

## Loading in all biomark run information
all_biomark_runs_con <- mongo(
  db = "all_biomark_data",
  collection = "biomark_runs",
  url = connection_string
)

# The mutate...paste statements collapse the list in MongoDB to a string with whitespace
# so that the renderDT calls can probably wrap them
all_biomark_runs <- all_biomark_runs_con$find() %>% 
  as_tibble() %>% 
  group_by(filename) %>% 
  mutate(nice_genes_measured = paste(genes_measured %>% unlist(), collapse = ", ")) %>% 
  mutate(nice_factors = paste(factors %>% unlist(), collapse = ", ")) %>% 
  ungroup()

## Loading in all biomark data

# This pulls all the data. 
# For now, will just load everything
# Will need to look into how to do this smoothly once we get more data in here
all_biomark_data_con <- mongo(
  db = "all_biomark_data",
  collection = "run_data",
  url = connection_string
)

# tester <- all_biomark_data_con$find('{"filename": "priming_amoA_rawCt.csv"}') %>% 
#   as_tibble()
