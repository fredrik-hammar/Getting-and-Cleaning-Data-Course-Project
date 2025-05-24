# Getting and Cleaning Data Course Project

This is my submission of the end of course project for the Johns Hopkins
University [Getting and Cleaning Data Course](https://www.coursera.org/learn/data-cleaning/)
at Coursera.

## File Manifest

| File                                           | Details                                                                     |
| ---------------------------------------------- | --------------------------------------------------------------------------- |
| [`README.md`](README.md)                       | This README file                                                            |
| [`INSTRUCTIONS.md`](INSTRUCTIONS.md)           | Original assignment instructions                                            |
| [`CodeBook.md`](CodeBook.md)                   | Code book for variables and summaries of `out/UCI HAR Dataset Averages.txt` |
| [`run_analysis.R`](run_analysis.R)             | R script file that performs analysis described in `INSTRUCTIONS.md`         |
| `data`                                         | Input data directory populated by `run_analysis.R`                          |
| `data/UCI HAR Dataset.zip`                     | Downloaded UCI HAR Dataset                                                  |
| `data/UCI HAR Dataset`                         | Extracted UCI HAR Dataset                                                   |
| `data/UCI HAR Dataset/README.txt`              | UCI HAR Dataset README file                                                 |
| `data/UCI HAR Dataset/activity_labels.txt`     | Activity labels                                                             |
| `data/UCI HAR Dataset/features.txt`            | Features, or variables, of `X_train` and `X_test`                           |
| `data/UCI HAR Dataset/features_info.txt`       | Details about the features                                                  |
| `data/UCI HAR Dataset/train`                   | The training data set directory                                             |
| `data/UCI HAR Dataset/train/X_train.txt`       | HAR training measurements                                                   |
| `data/UCI HAR Dataset/train/y_train.txt`       | Activity number of each measurement in `X_train.txt`                        |
| `data/UCI HAR Dataset/train/subject_train.txt` | Subjects for each measurement in `X_test.txt`                               |
| `data/UCI HAR Dataset/test`                    | The test data set directory                                                 |
| `data/UCI HAR Dataset/test/X_test.txt`         | HAR test measurements                                                       |
| `data/UCI HAR Dataset/test/y_test.txt`         | Activity number of each measurement in `X_test.txt`                         |
| `data/UCI HAR Dataset/test/subject_test.txt`   | Subjects for each measurement in `X_test.txt`                               |
| `out`                                          | Output data directory populated by `run_analysis.R`                         |
| `out/UCI HAR Dataset Averages.txt`             | Tidy dataset of averages of `mean()` and `std()` by activity and subject    |
