library(dplyr)

#scriptname: run_analysis.R
#function: This script anlayses the data for the human activity recognition using smartphones data 
#which can be found at https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
#Download into the current working directory

#Load the test and training data sets

#Load up the activity test set labels. There are 2947 rows for each observation in the test dataset
testactivitylabels<-read.table("./test/y_test.txt", stringsAsFactors = FALSE, header=FALSE)
#Load the test set into a datatable. There are 2947 observations of data
testdata<-read.table("./test/X_test.txt", stringsAsFactors = FALSE, header=FALSE, colClasses="numeric")
#Load the subjects in the test data set
testsubjects<-read.table("./test/subject_test.txt", header=FALSE)


#Load up the training set activity labels. There are 7352 rows for each observation in the training dataset
trainactivitylabels<-read.table("./train/y_train.txt", stringsAsFactors = FALSE, header=FALSE)
#Load the training set into a datatable
traindata<-read.table("./train/X_train.txt", stringsAsFactors = FALSE, header=FALSE, colClasses="numeric")
#Load the subjects in the training data set
trainsubjects<-read.table("./train/subject_train.txt", header=FALSE)

#Merge the test and training data set into a combined data set

#Create a combined activity label set 
combinedactivitylabels<-rbind(testactivitylabels,trainactivitylabels)
names(combinedactivitylabels)<-"Activity"

#Create a combined subject set
combinedsubjects<-rbind(testsubjects,trainsubjects)
names(combinedsubjects)<-"Subject_Id"

#Combine the test and train data into one big dataframe
combineddataset<-rbind(testdata,traindata)

#Convert the activity labels in the training and test set into meaningful descriptions
activity<-data.frame(c(1,2,3,4,5,6),c("WALKING","WALKING_UPSTAIRS","WALKING_DOWNSTAIRS","SITTING","STANDING","LAYING"), stringsAsFactors = FALSE)
combinedactivitylabels[,1]<-activity[combinedactivitylabels[,1],2]


#Load the column labels from the features textfile
columnlabels<-read.table("./features.txt",stringsAsFactors=FALSE,header=FALSE,colClasses="character")
z<-columnlabels[,2]

#Extracts only the measurements on the mean and standard deviation for each measurement.
#i.e. Column names that contain -mean() and -std()
reqcolumns<-sort(c(which(grepl("-mean\\(\\)",z)),which(grepl("-std\\(\\)",z))))
combineddataset<-combineddataset[,reqcolumns]

#Appropriately labels the data set with descriptive variable names.
names(combineddataset)<-gsub("-","_",gsub("\\(\\)","",z[reqcolumns]))


#Uses descriptive activity names to name the activities in the data set
newdataset<-cbind(combinedactivitylabels,combineddataset)
newdataset<-cbind(combinedsubjects,newdataset)

#creates an independent tidy data set with the average of each variable 
#for each activity and each subject.
df2<-group_by(newdataset,Subject_Id,Activity)
df3<-summarise_each(df2,funs(mean))

#Save the data to a file in the current working directory
write.csv(df3, "./tidydata.txt", row.names=FALSE)
