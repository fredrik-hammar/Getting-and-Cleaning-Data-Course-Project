library(readr)
library(here)

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

x_train <- read_table(here(dataset_path, "train", "X_train.txt"),
                      col_names = features,
                      col_types = cols(.default = col_double()))

x_test <- read_table(here(dataset_path, "test", "X_test.txt"),
                      col_names = features,
                      col_types = cols(.default = col_double()))


har <- rbind(x_train, x_test)

mean_cols <- grep('mean()', features, fixed = TRUE)
std_cols <- grep('std()', features, fixed = TRUE)

har <- har[, c(mean_cols, std_cols)]