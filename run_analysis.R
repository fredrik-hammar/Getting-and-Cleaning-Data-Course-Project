library(here)  # Used to get paths relative to this script.
library(readr)
library(dplyr)

url <- paste0(
  "https://d396qusza40orc.cloudfront.net/getdata",
  URLencode("/projectfiles/UCI HAR Dataset.zip"))

# Files used by script.
input_dir            <- here("data")
har_zip_file         <- here("data/UCI HAR Dataset.zip")
har_dir              <- here("data/UCI HAR Dataset")
activity_labels_file <- here("data/UCI HAR Dataset/activity_labels.txt")
feature_labels_file  <- here("data/UCI HAR Dataset/features.txt")
output_dir           <- here("out")
output_means         <- here("out/UCI HAR Dataset Means.txt")

training_set <- list(
  accelerometer = "data/UCI HAR Dataset/train/X_train.txt",
  activity = "data/UCI HAR Dataset/train/y_train.txt",
  subject = "data/UCI HAR Dataset/train/subject_train.txt"
)
test_set <- list(
  accelerometer = "data/UCI HAR Dataset/test/X_test.txt",
  activity = "data/UCI HAR Dataset/test/y_test.txt",
  subject = "data/UCI HAR Dataset/test/subject_test.txt"
)


#' Main function of this script.
#' Called at end of script. 
main <- function() {
  download_dataset()
  features <- read_features()
  activities <- read_activities()
  har <- read_all_datasets(features, activities)
  means <- tidy_means_dataset(har)
  write_means_dataset(means)
}

#' Download UCI HAR Dataset
download_dataset <- function() {
  if(!dir.exists(input_dir)) {
    dir.create(input_dir)
  }
  
  if(!file.exists(har_zip_file)) {
    download.file(url, har_zip_file)
  }

  unzip(har_zip_file, exdir = input_dir)
}

#' Read features data from UCI HAR Dataset.
#' These are made unique so they can be used as column names for dataset.
#' 
#' @param dir Dataset directory
#' @returns Data as a tibble
read_features <- function() {
  read_table(feature_labels_file,
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
read_activities <- function() {
  read_table(activity_labels_file,
             col_names = c("index", "activity"),
             col_types = "ic")
}

#' Read both training and test data from UCI HAR Dataset.
#' @seealso [read_dataset()]
#' @param dir Dataset directory
read_all_datasets <- function(...) {
  bind_rows(read_dataset(training_set, ...),
            read_dataset(test_set, ...))
}

#' Read training or test data from UCI HAR Dataset.
#' 
#' @param dir Dataset directory
#' @param set `"train"` or `"test`
#' @param features Features as read by [read_features()]
#' @param activities Activities as read by [read_activities()]
#' @returns Data as a tibble
read_dataset <- function(set, features, activities) {
  x <- read_table(set$accelerometer,
                  col_names = features,
                  col_types = cols(.default = col_double()))
  y <- read_table(set$activity,
                  col_names = "index",
                  col_types = "i")

  # Give descriptive names to the activities in the data set
  y <- inner_join(y, activities, by = join_by(index)) %>% select(activity)

  subjects <- read_table(set$subject,
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
write_means_dataset <- function(means) {
  if(!dir.exists(output_dir)) {
    dir.create(output_dir)
  }
  write.table(ungroup(means),
              file = output_means,
              row.names = FALSE)
}

main()
