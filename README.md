# Getting and Cleaning Data Course Project

This is my submission of the end of course project for the Johns Hopkins
University [Getting and Cleaning Data Course](https://www.coursera.org/learn/data-cleaning/)
at Coursera.

## File Manifest

| File                                           | Details                                                                  |
| ---------------------------------------------- | ------------------------------------------------------------------------ |
| `README.md`                                    | This README file                                                         |
| `INSTRUCTIONS.md`                              | Original assignment instructions                                         |
| `CodeBook.md`                                  | Code book for variables and summaries of `out/UCI HAR Dataset Means.txt` |
| `run_analysis.R`                               | R script file that performs analysis described in `INSTRUCTIONS.md`      |
| `data`                                         | Input data directory populated by `run_analysis.R`                       |
| `data/UCI HAR Dataset.zip`                     | Downloaded UCI HAR Dataset                                               |
| `data/UCI HAR Dataset`                         | Extracted UCI HAR Dataset                                                |
| `data/UCI HAR Dataset/README.txt`              | UCI HAR Dataset README file                                              |
| `data/UCI HAR Dataset/activity_labels.txt`     | Activity labels                                                          |
| `data/UCI HAR Dataset/features.txt`            | Features, or variables, of `X_train` and `X_test`                        |
| `data/UCI HAR Dataset/features_info.txt`       | Details about the features                                               |
| `data/UCI HAR Dataset/train`                   | The training data set directory                                          |
| `data/UCI HAR Dataset/train/X_train.txt`       | HAR training measurements                                                |
| `data/UCI HAR Dataset/train/y_train.txt`       | Activity number of each measurement in `X_train.txt`                     |
| `data/UCI HAR Dataset/train/subject_train.txt` | Subjects for each measurement in `X_test.txt`                            |
| `data/UCI HAR Dataset/test`                    | The test data set directory                                              |
| `data/UCI HAR Dataset/test/X_test.txt`         | HAR test measurements                                                    |
| `data/UCI HAR Dataset/test/y_test.txt`         | Activity number of each measurement in `X_test.txt`                      |
| `data/UCI HAR Dataset/test/subject_test.txt`   | Subjects for each measurement in `X_test.txt`                            |
| `out`                                          | Output data directory populated by `run_analysis.R`                      |
| `out/UCI HAR Dataset Means.txt`                | Tidy dataset of mean of `mean()` and `std()` by activity and subject     |


## TODO

- [ ] [`README.md`](README.md)
  - [x] Create stub
  - [x] Describe all files and how they are connected
- [ ] [`CodeBook.md`](CodeBook.md)
  - [x] Create stub
  - [ ] Describe following points performed to clean up the data
    - [ ] Variables and units
    - [ ] Data
    - [ ] Transformations
    - [ ] Other work
- [ ] [`run_analysis.R`](run_analysis.R)
  - [x] Download data set
  - [x] Merge the training and the test sets
  - [x] Extract the measurements on the mean and standard deviation for each
        measurement
  - [x] Give descriptive names to the activities in the data set
  - [x] Labels the data set with descriptive variable names
  - [x] Create second, independent tidy data set with the average of each
        variable for each activity and each subject
  - [x] Save as `txt` file created with `write.table()` using `row.name=FALSE`
  - [ ] Refactor and comment
- [ ] Submit
  - [ ] Project title: *Getting and Cleaning Data Course Project*
  - [ ] Link to GitHub repository:
        `https://github.com/fredrik-hammar/Getting-and-Cleaning-Data-Course-Project`
  - [ ] Tidy data `txt` file
