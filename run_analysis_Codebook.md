---
title: "run_analysis_Codebook"
author: "Pravesh Parekh"
date: "Sunday, April 26, 2015"
output: html_document
---

### Project Description
This is the codebook for the solution to course assignment for Coursera course titled "Getting and Cleaning Data". 

The main objectives of this assignment were:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

### Data Source
Data was acquired from the **Human Activity Recognition Using Smartphones Data Set**.
Data was downloaded using R
```{r}
download.file('https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip', 'UCI_HAR_Dataset.zip')
```
Subsequently, the datafile was unzipped. The dataset has the following files:

- 'README.txt': a description of the dataset

- 'features_info.txt': Shows information about the variables used on the feature vector.

- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.

- train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. [same for test case]

- Other intertial data were not considered for the project

### Steps followed to achieve the objectives and create the tidy data set

1. Download and unzip the dataset

2. Read all the X_ and y_ text files along with features and activity_labels file using read.table;
For example,
```{r}
X_train <- read.table('E:/Coursera/Getting and Cleaning Data/Week 3/Assignment 2/UCI HAR Dataset/train/X_train.txt')
```

3. Bind all the y variable to its counterpart x variable using cbind (train to train set and test to test set); also append the subject information

4. Using rbind, add all the information in one data frame ---**Objective 1**

5. Read the features.txt file and use it to name the columns of the data frame from step 4 ---**Objective 4**

6. Using pattern recognition (grep) find all column names that have "mean" or "std" and subset into a new data frame (along with subject number and the y label) ---**Objective 2**

7. Convert y variable (label) to factor to provide descriptive activity name ---**Objective 3**

8. Loop over each activity and each subject and calculate mean for all the variables present in the data frame (this is essentially calculating mean of all the columns selected in Step 6); append "Mean_" at the begining of each column name and assign to "tidy_df" variable ---**Objective 5**

9. Use write.table to write the data frame as a text file; use row.name = FALSE

**N.B: Refer to README.md for a detailed explanation of the run_analysis.R script**

### Description of the variables in the tidy_df variable

A summary of the number of variables, their types, and some data in each of the variables can be generated using the follwing R script

```{r}
str(tidy_df)
```

A summary of the dataset can be generated using:
```{r}
summary(tidy_df)
```

Number of columns in tidy_df: 81
Number of observations in tidy_df: 180

#### Understanding the variable name coding

**_From the original dataset:_**

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

- tBodyAcc-XYZ
- tGravityAcc-XYZ
- tBodyAccJerk-XYZ
- tBodyGyro-XYZ
- tBodyGyroJerk-XYZ
- tBodyAccMag
- tGravityAccMag
- tBodyAccJerkMag
- tBodyGyroMag
- tBodyGyroJerkMag
- fBodyAcc-XYZ
- fBodyAccJerk-XYZ
- fBodyGyro-XYZ
- fBodyAccMag
- fBodyAccJerkMag
- fBodyGyroMag
- fBodyGyroJerkMag

These variables are associated with either **mean** or **std** which stand for mean and standard deviation respecitvely. 

The column names mention for the tidy df use the same coding with "Mean_" prepended.


**A brief description of the 81 variables/columns in the data frame follows**

**The type of variable is indicated in the bracket**

- **Activity.Name**: The name of the activity; total of 6 activities (character type):
    - WALKING            
    - WALKING_UPSTAIRS
    - WALKING_DOWNSTAIRS 
    - SITTING
    - STANDING          
    - LAYING  


- **Subject.Number**: The number of the subject perfoming the activity; 1-30 (character type)

- **Mean_tBodyAcc.mean...X**: Mean of  tBodyAcc.mean...X (numeric type)

- **Mean_tBodyAcc.mean...Y**: Mean of  tBodyAcc.mean...Y (numeric type)

- **Mean_tBodyAcc.mean...Z**: Mean of  tBodyAcc.mean...Z (numeric type)

- **Mean_tGravityAcc.mean...X**: Mean of  tGravityAcc.mean...X (numeric type)

- **Mean_tGravityAcc.mean...Y**: Mean of  tGravityAcc.mean...Y (numeric type)

- **Mean_tGravityAcc.mean...Z**: Mean of  tGravityAcc.mean...Z (numeric type)

- **Mean_tBodyAccJerk.mean...X**: Mean of  tBodyAccJerk.mean...X (numeric type)

- **Mean_tBodyAccJerk.mean...Y**: Mean of  tBodyAccJerk.mean...Y (numeric type)

- **Mean_tBodyAccJerk.mean...Z**: Mean of  tBodyAccJerk.mean...Z (numeric type)

- **Mean_tBodyGyro.mean...X**: Mean of  tBodyGyro.mean...X (numeric type)

- **Mean_tBodyGyro.mean...Y**: Mean of  tBodyGyro.mean...Y (numeric type)

- **Mean_tBodyGyro.mean...Z**: Mean of  tBodyGyro.mean...Z (numeric type)

- **Mean_tBodyGyroJerk.mean...X**: Mean of  tBodyGyroJerk.mean...X (numeric type)

- **Mean_tBodyGyroJerk.mean...Y**: Mean of  tBodyGyroJerk.mean...Y (numeric type)

- **Mean_tBodyGyroJerk.mean...Z**: Mean of  tBodyGyroJerk.mean...Z (numeric type)

- **Mean_tBodyAccMag.mean..**: Mean of  tBodyAccMag.mean.. (numeric type)

- **Mean_tGravityAccMag.mean..**: Mean of  tGravityAccMag.mean.. (numeric type)

- **Mean_tBodyAccJerkMag.mean..**: Mean of  tBodyAccJerkMag.mean.. (numeric type)

- **Mean_tBodyGyroMag.mean..**: Mean of  tBodyGyroMag.mean.. (numeric type)

- **Mean_tBodyGyroJerkMag.mean..**: Mean of  tBodyGyroJerkMag.mean.. (numeric type)

- **Mean_fBodyAcc.mean...X**: Mean of  fBodyAcc.mean...X (numeric type)

- **Mean_fBodyAcc.mean...Y**: Mean of  fBodyAcc.mean...Y (numeric type)

- **Mean_fBodyAcc.mean...Z**: Mean of  fBodyAcc.mean...Z (numeric type)

- **Mean_fBodyAcc.meanFreq...X**: Mean of  fBodyAcc.meanFreq...X (numeric type)

- **Mean_fBodyAcc.meanFreq...Y**: Mean of  fBodyAcc.meanFreq...Y (numeric type)

- **Mean_fBodyAcc.meanFreq...Z**: Mean of  fBodyAcc.meanFreq...Z (numeric type)

- **Mean_fBodyAccJerk.mean...X**: Mean of  fBodyAccJerk.mean...X (numeric type)

- **Mean_fBodyAccJerk.mean...Y**: Mean of  fBodyAccJerk.mean...Y (numeric type)

- **Mean_fBodyAccJerk.mean...Z**: Mean of  fBodyAccJerk.mean...Z (numeric type)

- **Mean_fBodyAccJerk.meanFreq...X**: Mean of  fBodyAccJerk.meanFreq...X (numeric type)

- **Mean_fBodyAccJerk.meanFreq...Y**: Mean of  fBodyAccJerk.meanFreq...Y (numeric type)

- **Mean_fBodyAccJerk.meanFreq...Z**: Mean of  fBodyAccJerk.meanFreq...Z (numeric type)

- **Mean_fBodyGyro.mean...X**: Mean of  fBodyGyro.mean...X (numeric type)

- **Mean_fBodyGyro.mean...Y**: Mean of  fBodyGyro.mean...Y (numeric type)

- **Mean_fBodyGyro.mean...Z**: Mean of  fBodyGyro.mean...Z (numeric type)

- **Mean_fBodyGyro.meanFreq...X**: Mean of  fBodyGyro.meanFreq...X (numeric type)

- **Mean_fBodyGyro.meanFreq...Y**: Mean of  fBodyGyro.meanFreq...Y (numeric type)

- **Mean_fBodyGyro.meanFreq...Z**: Mean of  fBodyGyro.meanFreq...Z (numeric type)

- **Mean_fBodyAccMag.mean..**: Mean of  fBodyAccMag.mean.. (numeric type)

- **Mean_fBodyAccMag.meanFreq..**: Mean of  fBodyAccMag.meanFreq.. (numeric type)

- **Mean_fBodyBodyAccJerkMag.mean..**: Mean of  fBodyBodyAccJerkMag.mean.. (numeric type)

- **Mean_fBodyBodyAccJerkMag.meanFreq..**: Mean of  fBodyBodyAccJerkMag.meanFreq.. (numeric type)

- **Mean_fBodyBodyGyroMag.mean..**: Mean of  fBodyBodyGyroMag.mean.. (numeric type)

- **Mean_fBodyBodyGyroMag.meanFreq..**: Mean of  fBodyBodyGyroMag.meanFreq.. (numeric type)

- **Mean_fBodyBodyGyroJerkMag.mean..**: Mean of  fBodyBodyGyroJerkMag.mean.. (numeric type)

- **Mean_fBodyBodyGyroJerkMag.meanFreq..**: Mean of  fBodyBodyGyroJerkMag.meanFreq.. (numeric type)

- **Mean_tBodyAcc.std...X**: Mean of  tBodyAcc.std...X (numeric type)

- **Mean_tBodyAcc.std...Y**: Mean of  tBodyAcc.std...Y (numeric type)

- **Mean_tBodyAcc.std...Z**: Mean of  tBodyAcc.std...Z (numeric type)

- **Mean_tGravityAcc.std...X**: Mean of  tGravityAcc.std...X (numeric type)

- **Mean_tGravityAcc.std...Y**: Mean of  tGravityAcc.std...Y (numeric type)

- **Mean_tGravityAcc.std...Z**: Mean of  tGravityAcc.std...Z (numeric type)

- **Mean_tBodyAccJerk.std...X**: Mean of  tBodyAccJerk.std...X (numeric type)

- **Mean_tBodyAccJerk.std...Y**: Mean of  tBodyAccJerk.std...Y (numeric type)

- **Mean_tBodyAccJerk.std...Z**: Mean of  tBodyAccJerk.std...Z (numeric type)

- **Mean_tBodyGyro.std...X**: Mean of  tBodyGyro.std...X (numeric type)

- **Mean_tBodyGyro.std...Y**: Mean of  tBodyGyro.std...Y (numeric type)

- **Mean_tBodyGyro.std...Z**: Mean of  tBodyGyro.std...Z (numeric type)

- **Mean_tBodyGyroJerk.std...X**: Mean of  tBodyGyroJerk.std...X (numeric type)

- **Mean_tBodyGyroJerk.std...Y**: Mean of  tBodyGyroJerk.std...Y (numeric type)

- **Mean_tBodyGyroJerk.std...Z**: Mean of  tBodyGyroJerk.std...Z (numeric type)

- **Mean_tBodyAccMag.std..**: Mean of  tBodyAccMag.std.. (numeric type)

- **Mean_tGravityAccMag.std..**: Mean of  tGravityAccMag.std.. (numeric type)

- **Mean_tBodyAccJerkMag.std..**: Mean of  tBodyAccJerkMag.std.. (numeric type)

- **Mean_tBodyGyroMag.std..**: Mean of  tBodyGyroMag.std.. (numeric type)

- **Mean_tBodyGyroJerkMag.std..**: Mean of  tBodyGyroJerkMag.std.. (numeric type)

- **Mean_fBodyAcc.std...X**: Mean of  fBodyAcc.std...X (numeric type)

- **Mean_fBodyAcc.std...Y**: Mean of  fBodyAcc.std...Y (numeric type)

- **Mean_fBodyAcc.std...Z**: Mean of  fBodyAcc.std...Z (numeric type)

- **Mean_fBodyAccJerk.std...X**: Mean of  fBodyAccJerk.std...X (numeric type)

- **Mean_fBodyAccJerk.std...Y**: Mean of  fBodyAccJerk.std...Y (numeric type)

- **Mean_fBodyAccJerk.std...Z**: Mean of  fBodyAccJerk.std...Z (numeric type)

- **Mean_fBodyGyro.std...X**: Mean of  fBodyGyro.std...X (numeric type)

- **Mean_fBodyGyro.std...Y**: Mean of  fBodyGyro.std...Y (numeric type)

- **Mean_fBodyGyro.std...Z**: Mean of  fBodyGyro.std...Z (numeric type)

- **Mean_fBodyAccMag.std..**: Mean of  fBodyAccMag.std.. (numeric type)

- **Mean_fBodyBodyAccJerkMag.std..**: Mean of  fBodyBodyAccJerkMag.std.. (numeric type)

- **Mean_fBodyBodyGyroMag.std..**: Mean of  fBodyBodyGyroMag.std.. (numeric type)

- **Mean_fBodyBodyGyroJerkMag.std..**: Mean of  fBodyBodyGyroJerkMag.std.. (numeric type)


--- Further details of the code can be found in README.md ---

--- End of run_analysis_Codebook.md ---