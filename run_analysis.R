# Assuming that the dataset is already downloaded and extracted; set as working directory
setwd("E:/Coursera/Getting and Cleaning Data/Week 3/Assignment 2/UCI HAR Dataset")

# ----- Read the files -----
# Read all three text files in each train and test folders
# Also read the features and activity label files
subject_train <- read.table('E:/Coursera/Getting and Cleaning Data/Week 3/Assignment 2/UCI HAR Dataset/train/subject_train.txt')
X_train <- read.table('E:/Coursera/Getting and Cleaning Data/Week 3/Assignment 2/UCI HAR Dataset/train/X_train.txt')
Y_train <- read.table('E:/Coursera/Getting and Cleaning Data/Week 3/Assignment 2/UCI HAR Dataset/train/y_train.txt')

subject_test <- read.table('E:/Coursera/Getting and Cleaning Data/Week 3/Assignment 2/UCI HAR Dataset/test/subject_test.txt')
X_test <- read.table('E:/Coursera/Getting and Cleaning Data/Week 3/Assignment 2/UCI HAR Dataset/test/X_test.txt')
Y_test <- read.table('E:/Coursera/Getting and Cleaning Data/Week 3/Assignment 2/UCI HAR Dataset/test/y_test.txt')

features <- read.table('E:/Coursera/Getting and Cleaning Data/Week 3/Assignment 2/UCI HAR Dataset/features.txt')
activity <- read.table('E:/Coursera/Getting and Cleaning Data/Week 3/Assignment 2/UCI HAR Dataset/activity_labels.txt')

# ----- Step 1 -----
# Merge X and Y variables first; then merge everything into one
tmp_df1 <- cbind(X_train, Y_train, subject_train)
tmp_df2 <- cbind(X_test, Y_test, subject_test)
df <- rbind(tmp_df1, tmp_df2)

# ----- Step 4 -----
# Use the features variable to label the merged data frame
# Y variable column is named as label 
# Subject variable column is named as Subject Number
colnames(df) <- c(as.character(features$V2), "Label", "Subject Number")

# ----- Step 2 -----
# Find the colnames that have "mean" or "std" in their names; subset these to df2
mean_cols <- grep("mean", names(df))
std_cols <- grep("std", names(df))
df2 <- data.frame(df[mean_cols], df[std_cols])

# Create the data frame as above (mean and std) but retain label and subject number
df3 <- data.frame(df[mean_cols], df[std_cols], df[562], df[563])

# ----- Step 3 -----
# Replace the "Labels" with specific activity names
# It is not clear if it should be made a factor
# I am converting it into a factor and then adding it as a column
df3 <- cbind(df3, factor(df3[[80]], labels = activity[[2]]))
colnames(df3)[82] <- 'Activity Name'

# ----- Step 4: Line 28 -----

# ----- Step 5 -----
num_act <- 6   # Known
num_sub <- 30  # Known
num_var <- length(df3) - 3   # The number of variables in the dataset (excluding labels/label names/subject number)

# Loop over number of activities, number of subjects, and number of variables
# There must be simpler loop commands (the apply family) that does this
# Old coding habits from other languages die hard

# Initialize the tidy data frame to store values
# Append "Mean_" at the end of each of the colnames
tmp_df <- as.data.frame(setNames(replicate(num_var, numeric(0), simplify = F), names(df3[1:num_var])))
colnames(tmp_df) <- paste("Mean", colnames(tmp_df), sep = "_")
tidy_df <- data.frame(Activity.Name = character(0), Subject.Number = character(0), stringsAsFactors=FALSE)

# Counter variables
row <- 1
vec <- as.vector(NA)

for(act in 1:num_act){
        for(sub in 1:num_sub){
                for(var in 1:num_var){
                        vec[var] <- mean(df3[df3$Subject.Number == sub & df3$Label == act, var])
                }
                tidy_df[row,1] <- as.character(activity$V2[act])
                tidy_df[row,2] <- sub
                tmp_df[row,] <- cbind(vec)
                row <- row + 1
        }
}

tidy_df <- data.frame(tidy_df, tmp_df, stringsAsFactors=FALSE)   # This is the tidy df; Step 5 complete
View(tidy_df)   # To view the tidy data frame
write.table(tidy_df, file="tidy_df.txt", row.name = FALSE)   # Write the tidy df
