library(here)  # Used to get paths relative to this script.
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

#' Main function of this script.
#' Called at end of script. 
main <- function() {
  dir <- download_dataset(into = here("data"))
  features <- read_features(dir)
  activities <- read_activities(dir)
  har <- read_all_datasets(dir, features, activities)
  means <- tidy_means_dataset(har)
  write_means_dataset(means, into = here("out"))
}

#' Download UCI HAR Dataset
download_dataset <- function(into) {
  if(!dir.exists(into)) {
    dir.create(into)
  }
  
  path <- fs::path(into, filename)
  if(!file.exists(path)) {
    download.file(url, fs::path(into, filename))
  }
  
  unzip(path, exdir = into)
  fs::path(into, basename)
}

#' Read features data from UCI HAR Dataset.
#' These are made unique so they can be used as column names for dataset.
#' 
#' @param dir Dataset directory
#' @returns Data as a tibble
read_features <- function(dir) {
  read_table(fs::path(dir, "features.txt"),
             col_names = c("index", "feature"),
             col_types = "ic") %>%
    .$feature %>%
    make.unique(sep = "_")
}

#' Read activity label data from UCI HAR Dataset.
#' These can be used to give human readable labels to activities performed in
#' the training or test datasets.
#' 
#' @param dir Dataset directory
#' @returns Data as a tibble
read_activities <- function(dir) {
  read_table(fs::path(dir, "activity_labels.txt"),
             col_names = c("index", "activity"),
             col_types = "ic")
}

#' Read both training and test data from UCI HAR Dataset.
#' @seealso [read_dataset()]
#' @param dir Dataset directory
read_all_datasets <- function(dir, ...) {
  bind_rows(read_dataset(dir, "train", ...),
            read_dataset(dir, "test", ...))
}

#' Read training or test data from UCI HAR Dataset.
#' 
#' @param dir Dataset directory
#' @param set `"train"` or `"test`
#' @param features Features as read by [read_features()]
#' @param activities Activities as read by [read_activities()]
#' @returns Data as a tibble
read_dataset <- function(dir, set, features, activities) {
  x <- read_table(here(dir, set, paste0("X_", set, ".txt")),
                  col_names = features,
                  col_types = cols(.default = col_double()))
  y <- read_table(here(dir, set, paste0("y_", set, ".txt")),
                  col_names = "index",
                  col_types = "i")

  # Give descriptive names to the activities in the data set
  y <- inner_join(y, activities, by = join_by(index)) %>% select(activity)

  subjects <- read_table(here(dir, set, paste0("subject_", set, ".txt")),
                         col_names = "subject",
                         col_types = "i")

  bind_cols(x, y, subjects)
}

#' Get average of each mean and standard deviation variable from
#' HAR dataset by each activity and subject.
#' 
#' It follows the tidy data rules
#' 
#' - Each variable must have its own column.
#' - Each observation must have its own row.
#' - Each value must have its own cell.
#'
#' The axis of each varible could be considered a variable but it would
#' split each observation into multiple rows.
#'
#' @param har HAR Dataset with all features, activity, and subject
#' @returns Tidy data as a tibble
tidy_means_dataset <- function(har) {
  har %>%
    select(contains("mean()"), contains("std()"), "activity", "subject") %>%
    group_by(activity, subject) %>%
    summarize(across(everything(), mean), .groups = "drop")
}

#' Write dataset to file `UCI HAR Dataset Means.txt`.
#' @param into Target directory
write_means_dataset <- function(means, into) {
  if(!dir.exists(into)) {
    dir.create(into)
  }
  write.table(ungroup(means),
              file = fs::path(into, paste(basename, "Means.txt", sep = " ")),
              row.names = FALSE)
}

main()
