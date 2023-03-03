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

readRenviron(".env")

connection_string <- Sys.getenv("MONGODB_URI")

## Loading in all biomark run information
all_biomark_runs_con <- mongo(
  db = "all_biomark_data",
  collection = "biomark_runs",
  url = connection_string
)

all_biomark_runs <- all_biomark_runs_con$find() %>% 
  as_tibble()

## Loading in all biomark data

# This pulls all the data. 
# For now, will just load everything
# Will need to look into how to do this smoothly once we get more data in here
all_biomark_data_con <- mongo(
  db = "all_biomark_data",
  collection = "run_data",
  url = connection_string
)

all_biomark_data <- all_biomark_data_con$find() %>% 
  as_tibble()

# blast_results <- all_blast_results_collection$find() %>% 
#   as_tibble() %>% 
#   mutate(across(
#     pident:bitscore,
#     ~ as.numeric(.)
#   )) 
