---
title: "README.md"
author: "Pravesh Parekh"
date: "Sunday, April 26, 2015"
output: html_document
---

### Introduction

This is the README.md file for the solution to course assignment for Coursera course titled "Getting and Cleaning Data". 

This file explains in detail how the script run_analysis.R works and how the data set generated as the output of the script complies to tidy data principles.

Please refer to run_analysis_Codebook.md file to know more about the source of the data, the objectives of the project, and a description of all the variables.

Briefly, the main objectives were:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


### Code implementation: 
#### Objective 1: "Merges the training and the test sets to create one data set"

Before this objective could be achieved, it was required that the dataset is downloaded and unzipped. The dataset can be downloaded using:

```{r}
download.file('https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip', 'UCI_HAR_Dataset.zip')
```

The dataset was unzipped (outside R) and then the required files were read. Lines 7-16 of the script are required for reading the text files in the dataset. For example,

```{r}
X_train <- read.table('E:/Coursera/Getting and Cleaning Data/Week 3/Assignment 2/UCI HAR Dataset/train/X_train.txt')
```

would read the X_train,txt file into a variable called X_train.

In order to merge the train and test dataset, the X and Y variables were merged first. Also, it was important to merge the subject number of the subject which performed the activity (label or y variable). The following line of code would combine the X, Y, and the subject information for the training data and assign it to a temporary data frame

```{r}
tmp_df1 <- cbind(X_train, Y_train, subject_train)
```

Similarly, data for test set was assigned to another temporary data frame and then both the data frames were merged together using:

```{r}
df <- rbind(tmp_df1, tmp_df2)
```

#### Objective 2: "Extracts only the measurements on the mean and standard deviation for each measurement"

To achieve this step, the column names (the procedure of assigning column names is explained later) needed to be matched with "mean" and "std" for mean and standard deviations, respectively. This was achieved using the "grep" pattern matching function as below:

```{r}
mean_cols <- grep("mean", names(df))
```

The above line of the code would look into the column names of the data frame df and check for the occurrance of the word "mean". If the word is found, it would store the index of the column in mean_cols. Similarly, indices for columns having "Std" (for standard deviations) was stored in std_cols.
The data frame was subsetted using these variables as follows:

```{r}
df2 <- data.frame(df[mean_cols], df[std_cols])
```

The above data frame df2 would contain only those columns which have the measurements on the mean and standard deviation for each measurement.

The following version would retain the labels (y variable) and the subject number:

```{r}
df3 <- data.frame(df[mean_cols], df[std_cols], df[562], df[563])
```

#### Objective 3: "Uses descriptive activity names to name the activities in the data set"

For this step, it was necessary to convert the "label" information (y variable) into factor. It must be remembered that the descriptive activity names were previously read using:

```{r}
activity <- read.table('E:/Coursera/Getting and Cleaning Data/Week 3/Assignment 2/UCI HAR Dataset/activity_labels.txt')
```

Therefore, accessing the activity variable, we could use the information stored in it to define the labels for the factor variable. This is shown below:

```{r}
df3 <- cbind(df3, factor(df3[[80]], labels = activity[[2]]))
colnames(df3)[82] <- 'Activity Name'
```

The above would add a column to data frame df3 which would be factor type with values from 1-6 corresponding to each of the 6 activities described in the activity variable. The next line gives the name of the column as "Activity Name"

#### Objective 4: "Appropriately labels the data set with descriptive variable names"

This step was actually implemented in the beginning itself. It might be recollected that the features were earlier read into the variable called "features" using:

```{r}
features <- read.table('E:/Coursera/Getting and Cleaning Data/Week 3/Assignment 2/UCI HAR Dataset/features.txt')
```

Thus, the list of features could be used as a descriptive name for the columns. This was achieved using 

```{r}
colnames(df) <- c(as.character(features$V2), "Label", "Subject Number")
```

It may be noted that the additional two columns (labels and subject number) are also named here.

Once this was achieved, the column names would be retained even after subsetting for other objectives. 

#### Objective 5: "From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject."

For the final objective, two data frames were created; these would store the average values generated and the name of the activity/subject number:

```{r}
tmp_df <- as.data.frame(setNames(replicate(num_var, numeric(0), simplify = F), names(df3[1:num_var])))
colnames(tmp_df) <- paste("Mean", colnames(tmp_df), sep = "_")
tidy_df <- data.frame(Activity.Name = character(0), Subject.Number = character(0), stringsAsFactors=FALSE)
```

Three loops were then used to generate the tidy data set:

```{r}
for(act in 1:num_act)
for(sub in 1:num_sub)
for(var in 1:num_var)
```

These loops would be used to go over each activity, over each subject, and finally over all the variables that were selected above (mean and standard deviation)

The innermost loop:

```{r}
for(var in 1:num_var){
vec[var] <- mean(df3[df3$Subject.Number == sub & df3$Label == act, var])
}
```

calculates the mean for a given subject (generated in loop level 2) and a given activity (generated in root or level 1 loop). This value is assigned to a vector vec.

The code snippet:

```{r}
tidy_df[row,1] <- as.character(activity$V2[act])
tidy_df[row,2] <- sub
tmp_df[row,] <- cbind(vec)
row <- row + 1
```

updates the tidy data frame with the name of the activity and the number of the subject. The vector vec containing the mean values (for 79 variables) are stored in a temporary data frame called tmp_df.

At the end of all the loops, the tmp_df is merged with the tidy df to give tidy_df

```{r}
tidy_df <- data.frame(tidy_df, tmp_df, stringsAsFactors=FALSE) 
```

The following concluding lines of the code are for visualizing the tidy data frame and to write it a a text file

```{r}
View(tidy_df)
write.table(tidy_df, file="tidy_df.txt", row.name = FALSE)
```

### The tidy_df:
#### How it follows the tidy data principles

Here is an example of one of the columns of the tidy data frame.

-----------------------------------------------------
Activity.Name   |  Subject.Number  |  Mean_tBodyAcc.mean...X

WALKING         |       1          |   0.2773308

WALKING         |       2          |   0.2764266 

WALKING         |       3          |   0.2755675 

WALKING         |       4          |   0.2785820  

WALKING         |       5          |   0.2778423  

WALKING         |       6          |   0.2836589 



As can be seen, the first two columns represent the name of the activity and the subject number. The data is arranged in the following manner:

For each of the activities, the subjet number is arranged from 1:30 with the mean of the variable in the column next to it.

Further, the data set meets the following criteria:

- Each variable you measure should be in one column

- Each different observation of that variable should be in a different row

thereby qualifying as tidy data.


#### Summary of the tidy data frame

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

#### Concluding Remarks

--- Thank you for reading ---

--- More details about the dataset (for example, the description of the type of variables and their meanings, etc.) can be found in the associated codebook run_analysis_Codebook.md. ---


--- End of README.md ---