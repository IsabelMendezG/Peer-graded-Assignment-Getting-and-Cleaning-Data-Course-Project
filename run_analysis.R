
# This script requires dplyr package
#title: Peer Graded Assignment: Getting and Cleaning Data Course Project
#author: Isabel Méndez

library(dplyr)

filename <- "getdata-projectfiles-UCI HAR Dataset.zip"

# Checking if zip are already in the same folder and if not, download the file from web.
if (!file.exists(filename)){
  linkURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(linkURL, filename, method="curl")
}  

# Checking if folder exists
if (!file.exists("UCI HAR Dataset")) { 
  unzip(filename) 
}
features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","functions"))
activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
X_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
X_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")

# 1. Merges the training and the test sets to create one data set.

X <- rbind(X_train, X_test)
Y <- rbind(y_train, y_test)
Subject <- rbind(subject_train, subject_test)
Merged_Data <- cbind(Subject, Y, X)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
Tidy <- Merged_Data %>% select(subject, code, contains("mean"), contains("std"))
# 3. Descriptive activity names to name the activities in the data set

Tidy$code <- activities[Tidy$code, 2]

# 4. Appropriately labels the data set with descriptive variable names.

names(Tidy)[2] = "activity"
names(Tidy)<-gsub("Acc", "Accelerometer", names(Tidy))
names(Tidy)<-gsub("Gyro", "Gyroscope", names(Tidy))
names(Tidy)<-gsub("BodyBody", "Body", names(Tidy))
names(Tidy)<-gsub("Mag", "Magnitude", names(Tidy))
names(Tidy)<-gsub("^t", "Time", names(Tidy))
names(Tidy)<-gsub("^f", "Frequency", names(Tidy))
names(Tidy)<-gsub("tBody", "TimeBody", names(Tidy))
names(Tidy)<-gsub("-mean()", "Mean", names(Tidy), ignore.case = TRUE)
names(Tidy)<-gsub("-std()", "std", names(Tidy), ignore.case = TRUE)
names(Tidy)<-gsub("-freq()", "frequency", names(Tidy), ignore.case = TRUE)
names(Tidy)<-gsub("angle", "Angle", names(Tidy))
names(Tidy)<-gsub("gravity", "Gravity", names(Tidy))

#5 From the data set in step 4, creates a second, independent tidy data set with 
# the average of each variable for each activity and each subject.
FinalTidyDataset <- Tidy %>%
  group_by(subject, activity) %>%
  summarise_all(funs(mean))
write.table(FinalTidyDataset, "FinalTidyDataset.txt", row.name=FALSE)
str(FinalTidyDataset)



