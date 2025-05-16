library(here)
library(readr)
library(dplyr)

basename <- "UCI HAR Dataset"
filename <- fs::path(basename, ext = "zip")
url <- paste(
  "https://d396qusza40orc.cloudfront.net/getdata",
  URLencode(paste("/projectfiles",
                  filename, sep = "/"),
            reserved = TRUE),
  sep = "/"
)

main <- function() {
  dataset_path <- download_dataset()
  features <- read_features()
  activites <- read_activities()
  har <- read_all_datasets(features, activites)
  means <- summarize(har, across(everything(), mean), .groups = "drop")
  write_means_dataset(means)
}

download_dataset <- function() {
  if(!dir.exists("data")) {
    dir.create("data")
  }
  
  path <- fs::path("data", filename)
  if(!file.exists(path)) {
    download.file(url, fs::path("data", filename))
  }
  
  unzip(path, exdir = "data")
  fs::path("data", basename)
}

read_features <- function() {
  read_table(fs::path(dataset_path, "features.txt"),
             col_names = c("index", "feature"),
             col_types = "ic") %>%
    .$feature %>%
    make.unique(sep = "_")
}

read_activities <- function() {
  read_table(fs::path(dataset_path, "activity_labels.txt"),
                         col_names = c("index", "activity"),
                         col_types = "ic")
}

#' Read training or test data from UCI HAR Dataset.
#' 
#' @param set `"train"` or `"test`
#' @returns Data as a tibble
read_dataset <- function(set, features, activities) {
  x <- read_table(here(dataset_path, set, paste0("X_", set, ".txt")),
                  col_names = features,
                  col_types = cols(.default = col_double()))
  y <- read_table(here(dataset_path, set, paste0("y_", set, ".txt")),
                  col_names = "index",
                  col_types = "i")

  # Give descriptive names to the activities in the data set
  y <- inner_join(y, activites, by = join_by(index)) %>% select(activity)

  subjects <- read_table(here(dataset_path, set, paste0("subject_", set, ".txt")),
                         col_names = "subject",
                         col_types = "i")

  bind_cols(x, y, subjects)
}

read_all_datasets <- function(features, activites) {
  bind_rows(read_dataset("train", features, activites),
            read_dataset("test", features, activites)) %>%
    select(contains("mean()"), contains("std()"), "activity", "subject") %>%
    group_by(activity, subject)
}

write_means_dataset <- function(means) {
  if(!dir.exists("out")) {
    dir.create("out")
  }
  write.table(ungroup(means),
              file = here("out", paste(basename, "Means.txt", sep = " ")),
              row.names = FALSE)
}

main()
