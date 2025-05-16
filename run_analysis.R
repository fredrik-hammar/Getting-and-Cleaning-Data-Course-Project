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
  dir <- download_dataset(into = "data")
  features <- read_features(dir)
  activites <- read_activities(dir)
  har <- read_all_datasets(dir, features, activites)
  means <- summarize(har, across(everything(), mean), .groups = "drop")
  write_means_dataset(means, into = "out")
}

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

read_features <- function(dir) {
  read_table(fs::path(dir, "features.txt"),
             col_names = c("index", "feature"),
             col_types = "ic") %>%
    .$feature %>%
    make.unique(sep = "_")
}

read_activities <- function(dir) {
  read_table(fs::path(dir, "activity_labels.txt"),
             col_names = c("index", "activity"),
             col_types = "ic")
}

#' Read training or test data from UCI HAR Dataset.
#' 
#' @param set `"train"` or `"test`
#' @returns Data as a tibble
read_dataset <- function(dir, set, features, activities) {
  x <- read_table(here(dir, set, paste0("X_", set, ".txt")),
                  col_names = features,
                  col_types = cols(.default = col_double()))
  y <- read_table(here(dir, set, paste0("y_", set, ".txt")),
                  col_names = "index",
                  col_types = "i")

  # Give descriptive names to the activities in the data set
  y <- inner_join(y, activites, by = join_by(index)) %>% select(activity)

  subjects <- read_table(here(dir, set, paste0("subject_", set, ".txt")),
                         col_names = "subject",
                         col_types = "i")

  bind_cols(x, y, subjects)
}

read_all_datasets <- function(dir, features, activites) {
  bind_rows(read_dataset(dir, "train", features, activites),
            read_dataset(dir, "test", features, activites)) %>%
    select(contains("mean()"), contains("std()"), "activity", "subject") %>%
    group_by(activity, subject)
}

write_means_dataset <- function(means, into) {
  if(!dir.exists(into)) {
    dir.create(into)
  }
  write.table(ungroup(means),
              file = here(into, paste(basename, "Means.txt", sep = " ")),
              row.names = FALSE)
}

main()
