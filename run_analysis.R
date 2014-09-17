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
        activities_test <- merge(activities_test,act_labels)
        activities_test <- activities_test[,3]
        names(activities_test) <- "activity"
        
        subjects_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
        names(subjects_test) <- "subject"
        
        data_test <- cbind(subjects_test, activities_test, data_test)
        
        # Data from Train
        data_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
        names(data_train) <- c_labels
        data_train <- data_train[,c_keep]
        
        activities_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
        activities_train <- merge(activities_train,act_labels)
        activities_train <- activities_train[,3]
        names(activities_train) <- "activity"
        
        subjects_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
        names(subjects_train) <- "subject"
        
        data_train <- cbind(subjects_train, activities_train, data_train)
        
        # Merge Data
        data <- rbind(data_test, data_train)
        
        # Fix Naming of Factor Column
        names(data)[2] <- "activity"
        
        
}