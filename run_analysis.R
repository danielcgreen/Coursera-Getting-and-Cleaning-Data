
# This function is designed to return a tidy dataset comprised of mean data points across
# a variety of measurments from Human Activity Recognition Using Smartphone Data Set.
#
# Data Dictionary:
# Subject - the test subject wearing the data capture device
# Activity - an activity being performed by the subject
# Remaining Columns - the mean of activity measurements captured (see ./UCI HAR Dataset/features_info.txt)
#
# Source Dataset:
# http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
#
# Example Usage:
# data <- run_analysis()

run_analysis <- function(){
        
        # Column Labels
        c_labels <- read.table("./UCI HAR Dataset/features.txt")
        c_labels <- c_labels[,2] # Remove Row Number
        
        # Columns to Keep (Means, Standard Deviations)
        c_keep <- c(1,2,3,4,5,6,41,42,43,44,45,46,81,82,83,84,85,86,121,122,123,124,125,126,161,162,163,164,165,166,201,202,214,215,227,228,240,241,253,254,266,267,268,269,270,271,345,346,347,348,349,350,424,425,426,427,428,429,503,504,516,517,529,530,542,543)
        
        # Activity Labels
        act_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")
        names(act_labels) <- c("id", "Activity")
        
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
        
        # Data from Train
        data_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
        names(data_train) <- c_labels
        data_train <- data_train[,c_keep]
        
        activities_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
        activities_train <- merge(activities_train,act_labels) # Apply friendly activity names
        activities_train <- activities_train[,3] # Return only friendly activity names
        names(activities_train) <- "activity"
        
        subjects_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
        names(subjects_train) <- "subject"
        
        data_train <- cbind(subjects_train, activities_train, data_train)
        
        names(data_train)[2] <- "activity" # Correct activity column name from cbind function
        
        # Merge Test and Training Dataset
        data <- rbind(data_test, data_train)
        
        # Summarize Data by Subject and Activity
        tidy <- aggregate(data[,3:68], by=data[c("subject","activity")], FUN=mean, na.rm = TRUE)
        
        # Return Tidy Dataset
        tidy
}