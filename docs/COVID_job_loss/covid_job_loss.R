library(tidyr)
library(readr)
library(dplyr)
library(stringr)
library(magrittr)
library(glptools)

library(leaflet)

job_loss <- read_csv("COVID_job_loss/job_loss_by_tract.csv")

job_loss %<>%
  filter(county_fips == "21111") %>%
  transmute(
    tract = GEOID,
    loss_rate = li_worker_unemp_rate * 100)

write_csv(job_loss, "output_data/job_loss_rate.csv")

make_map(job_loss_object, loss_rate)



job_loss_object@data %<>% left_join(job_loss, by = "tract")

save(job_loss_object, file = "output_data/job_loss_object.RData")


