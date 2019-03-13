#run_analysis.R
#Lalith Kumar
#Getting and Cleaning Data
#install.packages("dplyr")
#install.packages("data.table")
#Load packages
library(data.table)
library(dplyr)

setwd("C:/Users/lalithkumar.vemali/Documents/R")

##Downloading UCI data files from the web link##
URL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
destFile <- "CourseDataset.zip"
if (!file.exists(destFile)){
  download.file(URL, destfile = destFile, mode='wb')
}
if (!file.exists("./UCI_HAR_Dataset")){
  unzip(destFile)
}
dateDownloaded <- date()

##Read File##
setwd("./UCI_HAR_Dataset")

##Read Activity files##
ActivityTest <- read.table("./test/y_test.txt", header = F)
ActivityTrain <- read.table("./train/y_train.txt", header = F)

##Read features files##
FeaturesTest <- read.table("./test/X_test.txt", header = F)
FeaturesTrain <- read.table("./train/X_train.txt", header = F)

##Read subject files##
SubjectTest <- read.table("./test/subject_test.txt", header = F)
SubjectTrain <- read.table("./train/subject_train.txt", header = F)

##Read Activity Labels##
ActivityLabels <- read.table("./activity_labels.txt", header = F)

##Read Feature Names##
FeaturesNames <- read.table("./features.txt", header = F)

##Merging the date frame Features,Activity, Subject##
FeaturesData <- rbind(FeaturesTest, FeaturesTrain)
SubjectData <- rbind(SubjectTest, SubjectTrain)
ActivityData <- rbind(ActivityTest, ActivityTrain)

##Rename coloumns in Activity Data & Activity Labels##
names(ActivityData) <- "ActivityN"
names(ActivityLabels) <- c("ActivityN", "Activity")

##Gather factors of Activity names##
Activity <- left_join(ActivityData, ActivityLabels, "ActivityN")[, 2]

##Rename Subject Data coloumns##
names(SubjectData) <- "Subject"

##Rename FeaturesData coloumns##
names(FeaturesData) <- FeaturesNames$V2

##Create single large Dataset with variables: SubjectData,  Activity,  FeaturesData##
DataSet <- cbind(SubjectData, Activity)
DataSet <- cbind(DataSet, FeaturesData)

##Create New datasets by extracting the measurements on the mean & standard deviation for each measurement##
subFeaturesNames <- FeaturesNames$V2[grep("mean\\(\\)|std\\(\\)", FeaturesNames$V2)]
DataNames <- c("Subject", "Activity", as.character(subFeaturesNames))
DataSet <- subset(DataSet, select=DataNames)

##Rename the coloumns of the single large dataset using more descriptive activity names##
names(DataSet)<-gsub("^t", "time", names(DataSet))
names(DataSet)<-gsub("^f", "frequency", names(DataSet))
names(DataSet)<-gsub("Acc", "Accelerometer", names(DataSet))
names(DataSet)<-gsub("Gyro", "Gyroscope", names(DataSet))
names(DataSet)<-gsub("Mag", "Magnitude", names(DataSet))
names(DataSet)<-gsub("BodyBody", "Body", names(DataSet))

##Create a second, independent tidy data set with average of each variable for each activity and each subject##
SecondDataSet<-aggregate(. ~Subject + Activity, DataSet, mean)
SecondDataSet<-SecondDataSet[order(SecondDataSet$Subject,SecondDataSet$Activity),]

##Saving this tidy dataset to my local file##
write.table(SecondDataSet, file = "LKtidydata.txt",row.name=FALSE)
