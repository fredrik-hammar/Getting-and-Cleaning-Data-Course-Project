# Code Book

Averages of collected data from the Human Activity Recognition Using
Smartphones Dataset from Smartlab - Non Linear Complex Systems Laboratory,
referred to as the HAR dataset from now on.

## Collection of raw data

As per the `README.txt` file of the HAR dataset.

> The features selected for this database come from the accelerometer and
> gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain
> signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz.
> Then they were filtered using a median filter and a 3rd order low pass
> Butterworth filter with a corner frequency of 20 Hz to remove noise.
> Similarly, the acceleration signal was then separated into body and gravity
> acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass
> Butterworth filter with a corner frequency of 0.3 Hz.
>
> Subsequently, the body linear acceleration and angular velocity were derived
> in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also
> the magnitude of these three-dimensional signals were calculated using the
> Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag,
> tBodyGyroJerkMag).
>
> Finally a Fast Fourier Transform (FFT) was applied to some of these signals
> producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag,
> fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain
> signals).
>
> These signals were used to estimate variables of the feature vector for each
> pattern: '-XYZ' is used to denote 3-axial signals in the X, Y and Z
> directions.

## Transformation

The output data is produced by the [`run_analysis.R`](run_analysis.R) script,
into the output file `out/UCI HAR Dataset Averages.txt`, by performing the
following steps:

1. Download data set
2. For each training and test dataset:
    1. Match each column with feature name
    2. Match each row with activity number
    3. Match each activity number with activity label
    4. Match each row with subject number.
3. Concatenate the training and the test sets
4. Extract the measurements on the mean and standard deviation for each
   observation by selecting variables with `std()` or `mean()` in their names
5. Get average of each variable for each activity and each subject
6. Write to output file `out/UCI HAR Dataset Averages.txt`.


## UCI HAR Dataset Averages

- File: `out/UCI HAR Dataset Averages.txt`
- Dimensions: 180 × 68


### `activity` variable

Activity performed during the measurement. One of six possible values:

- `WALKING`
- `WALKING_UPSTAIRS`
- `WALKING_DOWNSTAIRS`
- `SITTING`
- `STANDING`
- `LAYING`


### `subject` variable

Subject performing activity, numbered 1-30.


### Feature average variables

The remaining variables are averages of the features from the HAR dataset
by each activity and subject, giving 180 rows of averages (6 × 30).

See *Collection of raw data* section above for explanation of variables.
Each feature is normalized and bounded within [-1,1].

Full list of variables:

- `tBodyAcc-mean()-X`
- `tBodyAcc-mean()-Y`
- `tBodyAcc-mean()-Z`
- `tGravityAcc-mean()-X`
- `tGravityAcc-mean()-Y`
- `tGravityAcc-mean()-Z`
- `tBodyAccJerk-mean()-X`
- `tBodyAccJerk-mean()-Y`
- `tBodyAccJerk-mean()-Z`
- `tBodyGyro-mean()-X`
- `tBodyGyro-mean()-Y`
- `tBodyGyro-mean()-Z`
- `tBodyGyroJerk-mean()-X`
- `tBodyGyroJerk-mean()-Y`
- `tBodyGyroJerk-mean()-Z`
- `tBodyAccMag-mean()`
- `tGravityAccMag-mean()`
- `tBodyAccJerkMag-mean()`
- `tBodyGyroMag-mean()`
- `tBodyGyroJerkMag-mean()`
- `fBodyAcc-mean()-X`
- `fBodyAcc-mean()-Y`
- `fBodyAcc-mean()-Z`
- `fBodyAccJerk-mean()-X`
- `fBodyAccJerk-mean()-Y`
- `fBodyAccJerk-mean()-Z`
- `fBodyGyro-mean()-X`
- `fBodyGyro-mean()-Y`
- `fBodyGyro-mean()-Z`
- `fBodyAccMag-mean()`
- `fBodyBodyAccJerkMag-mean()`
- `fBodyBodyGyroMag-mean()`
- `fBodyBodyGyroJerkMag-mean()`
- `tBodyAcc-std()-X`
- `tBodyAcc-std()-Y`
- `tBodyAcc-std()-Z`
- `tGravityAcc-std()-X`
- `tGravityAcc-std()-Y`
- `tGravityAcc-std()-Z`
- `tBodyAccJerk-std()-X`
- `tBodyAccJerk-std()-Y`
- `tBodyAccJerk-std()-Z`
- `tBodyGyro-std()-X`
- `tBodyGyro-std()-Y`
- `tBodyGyro-std()-Z`
- `tBodyGyroJerk-std()-X`
- `tBodyGyroJerk-std()-Y`
- `tBodyGyroJerk-std()-Z`
- `tBodyAccMag-std()`
- `tGravityAccMag-std()`
- `tBodyAccJerkMag-std()`
- `tBodyGyroMag-std()`
- `tBodyGyroJerkMag-std()`
- `fBodyAcc-std()-X`
- `fBodyAcc-std()-Y`
- `fBodyAcc-std()-Z`
- `fBodyAccJerk-std()-X`
- `fBodyAccJerk-std()-Y`
- `fBodyAccJerk-std()-Z`
- `fBodyGyro-std()-X`
- `fBodyGyro-std()-Y`
- `fBodyGyro-std()-Z`
- `fBodyAccMag-std()`
- `fBodyBodyAccJerkMag-std()`
- `fBodyBodyGyroMag-std()`
- `fBodyBodyGyroJerkMag-std()`
