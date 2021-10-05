## code to prepare `Metallica_Data_Clean` dataset goes here

metallica <- readr::read_csv("data-raw/csv/Metallica_Data_Clean.csv") |>
  # Selecting columns of interest
  dplyr::select(Date, Festival, City_Country,
                Tour, Set, Encores, Set_Length,
                `Kill_'Em_All_Count`:Hardwired_To_Self_Destruct_Count) |>
  # Extracting country from City_Country by splitting string and taking
  # last element using purrr and stringr
  dplyr::mutate(
    Country = purrr::map_chr(
    stringr::str_split(City_Country,pattern = ","), .f=tail,n=1
  ),
  .keep="unused", .before=Set) |>
  # Replacing NA in Festival by "None"
  # Changing date format in Date column
  # Replacing NA in Tour by "None"
  dplyr::mutate(Festival = stringr::str_replace_na(Festival),
                Festival = stringr::str_replace_all(Festival, "NA", "None"),
                Tour = stringr::str_replace_na(Tour),
                Tour = stringr::str_replace_all(Tour, "NA", "None"),
                Date=lubridate::mdy(Date)) |>
  # Replacing Date with Year column
  dplyr::mutate(Year=lubridate::year(Date),
                .before=Festival)

# Saving dataset
metallica |>
  readr::write_rds("data/metallica.rds")
