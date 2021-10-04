## code to prepare `Metallica_Data_Clean` dataset goes here

library(magrittr)

metallica <- readr::read_csv("data-raw/csv/Metallica_Data_Clean.csv") %>%
  dplyr::select(Date, Festival, City_Country,
                Tour, Set, Encores, Set_Length,
                Has_Guitar_Solo:Hardwired_To_Self_Destruct_Count) %>%
  dplyr::mutate(Country = purrr::map_chr(
    stringr::str_split(City_Country,pattern = ","), .f=tail,n=1
  ),.keep="unused") %>%
  dplyr::mutate(Festival = replace_na("None"))

metallica %>%
  readr::write_rds("data/metallica.rds")
