# Getting and Cleaning Data: Course Project

## Background
One of the most exciting areas in all of data science right now is wearable computing. Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

## Objectives
The data provided by the Human Activity Recognition Using Smartphones Data Set is broad and separated into multiple files.  The objective of this script is to combine the various source datasets and return a summary subset of the core data for each subject and activity.

## Data Dictionary
- Subject: the test subject wearing the data capture device
- Activity: an activity being performed by the subject
- Activity Measurement Columns: the mean of each activity measurement column. See ./UCI HAR Dataset/features_info.txt for more details on each activity measurement.

## Method Overview
1. Load separate datasets
2. Capture results and merge descriptive datasets
3. Union result sets
4. Summarize complete dataset and return

## Method
### Load Separate Datasets
In this section, column labels are loaded from the features.txt file.  Then, a variable is created with the column indeces of the raw measurement fields from the source data.  Finally, a dataset used to decode activity is captured from the activity_labels.txt file.

       # Column Labels
        c_labels <- read.table("./UCI HAR Dataset/features.txt")
        c_labels <- c_labels[,2] # Remove Row Number
        
        # Columns to Keep (Means, Standard Deviations)
        c_keep <- c(1,2,3,4,5,6,41,42,43,44,45,46,81,82,83,84,85,86,121,122,123,124,125,126,161,162,163,164,165,166,201,202,214,215,227,228,240,241,253,254,266,267,268,269,270,271,345,346,347,348,349,350,424,425,426,427,428,429,503,504,516,517,529,530,542,543)
        
        # Activity Labels
        act_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")
        names(act_labels) <- c("id", "Activity")

### Capture Results and Merge Descriptive Datasets
In this section, the raw data sets are loaded from both the test and train folders within the UCI HAR dataset.  All columns are named and a subset of the measurements in the UCI HAR dataset is returned.  Finally, subject and activity datasets are merged with the activity dataset.

        # Data from Test
        data_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
        names(data_test) <- c_labels
        data_test <- data_test[,c_keep]
        
        activities_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
        activities_test <- merge(activities_test,act_labels) # Apply friendly activity names
        activities_test <- activities_test[,3] # Return only friendly activity names
        names(activities_test) <- "activity"
        
        subjects_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
        names(subjects_test) <- "subject"
        
        data_test <- cbind(subjects_test, activities_test, data_test)

        names(data_test)[2] <- "activity" # Correct activity column name from cbind function
        
### Union Results
Data is collected from both the test and train folders in the UCI HAR dataset.  These results are unioned into a single dataset for analysis.

        # Merge Test and Training Dataset
        data <- rbind(data_test, data_train)

### Summarize Complete Dataset and Return
The final dataset is now summarized.  Column means for each measurement are grouped by subject and activity.

        # Summarize Data by Subject and Activity
        tidy <- aggregate(data[,3:68], by=data[c("subject","activity")], FUN=mean, na.rm = TRUE)
        
        # Return Tidy Dataset
        tidy

## Example Usage
1. Download and unzip the dataset into your working directory (https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)
2. Run the run_analysis function

        summarized_uci_har <- run_analysis()