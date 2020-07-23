library(tidyr)
library(readr)
library(dplyr)
library(stringr)
library(magrittr)
library(glptools)

library(leaflet)

job_loss_tract  <- read_csv("COVID_job_loss/job_loss_by_tract.csv")
job_loss_county <- read_csv("COVID_job_loss/sum_job_loss_county.csv")

job_loss_tract %<>%
  filter(county_fips == "21111") %>%
  transmute(
    tract = GEOID,
    loss_rate = li_worker_unemp_rate * 100)

write_csv(job_loss_tract, "output_data/job_loss_rate.csv")

job_loss_county %<>%
  transmute(
    FIPS = county_fips,
    loss_rate = low_income_worker_job_loss_rate * 100,
    total = X000) %>%
  pull_peers(add_info = F) %>%
  stl_merge(loss_rate, weight_var = "total")
  
write_csv(job_loss_county, "output_data/job_loss_county.csv")
