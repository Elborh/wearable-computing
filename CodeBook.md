# Code book 
This file is a code book for the "tidy_grouped_data.txt" data set.
It consists of two parts. The first part describes the experiment in which the original data was collected. The second part is a detailed description of the tidy data set.

## Experiment design
According to the [description](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) of the raw data set, the data was collected as a result of the following procedure:

>The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

>The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

The raw data was then cleaned and transformed according to the steps specified in the "Processing steps" section of the [README](https://github.com/Elborh/wearable-computing/blob/master/README.md) file.

## Tidy data set
The output data set is put into the "tidy_grouped_data.txt" file. It contains 180 observations and 68 variables.
The below table contains the description of the data set variables:

Column No | Column name | Description
--------- | ----------- | -----------
1 | subjectId | Integer number from 1 to 30, identifying the person who performed the activity
2 | activity | Categorical variable specifying the activity. One of the following: "walking", "walking_upstairs", "walking_downstairs", "sitting", "standing", "laying"
3-68 | {compound name} | Numeric variables selected from or estimated based upon smartphone sensor signals. All variables are normalized, bounded within [-1,1] range and averaged (using mean function) within subject and ativity groups. In order to understand the specific meaning of each variable refer to the below table and the "Experiment design" section. This variables are unitless because of the normalization algorithms applied.

The variable #3-68 names consist of the predefined parts or suffixes. The presence of specific suffix in the variable name enables to interprete the variable meaning.

Suffix | Description
------ | -----------
avg | The variable is summarized by mean function within each activity and subjectId groups
Time | Time domain signal captured at a constant rate of 50 Hz
Freq | Frequency domain signal determined by the application of the Fast Fourier Transform (FFT) algorithm
Body | Body signal as determined by the Butterworth filter
Gravity | Gravity signal as determined by the Butterworth filter
Acc | Data comming from the accelerometer
Gyro | Data comming from the gyroscope
Jerk | Measurement of jerk movements determined by the body linear acceleration and angular velocity 
Mag | The magnitude calculated using the Euclidean norm
Mean | The mean summarization applied to the original sensor signals
Std | The standard deviation summarization applied to the original sensor signals
X / Y / Z | The signal direction in the 3-axial system of coordinates
