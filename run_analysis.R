library(here)
library(readr)
library(dplyr)

basename <- "UCI HAR Dataset"
filename <- paste(basename, "zip", sep = ".")
url <- paste(
  "https://d396qusza40orc.cloudfront.net/getdata",
  URLencode(paste("/projectfiles",
                  filename, sep = "/"),
            reserved = TRUE),
  sep = "/"
)

if(!dir.exists("data")) {
  dir.create("data")
}

path <- fs::path("data", filename)
if(!file.exists(path)) {
  download.file(url, fs::path("data", filename))
}

unzip(path, exdir = "data")

dataset_path <- fs::path("data", basename)
features <- read_table(fs::path(dataset_path, "features.txt"),
                       col_names = c("index", "feature"),
                       col_types = "ic")
features <- make.unique(features$feature, sep = "_")

activites <- read_table(fs::path(dataset_path, "activity_labels.txt"),
                       col_names = c("index", "activity"),
                       col_types = "ic")

read_dataset <- function(set) {
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

har <- bind_rows(read_dataset("train"), read_dataset("test"))
har <- select(har, contains("mean()"), contains("std()"), "activity", "subject")
har <- group_by(har, activity, subject)

means <- summarize(har, across(everything(), mean), .groups = "drop")
if(!dir.exists("out")) {
  dir.create("out")
}
write.table(ungroup(means),
            file = here("out", paste(basename, "Means.txt", sep = " ")),
            row.names = FALSE)
