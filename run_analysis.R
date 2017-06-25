run_analysis <- function(){
    ## Your working derectory should be set to UCI HAR Dataset
    ## Load required libraries.
    library(dplyr)
    library(stringr)
    
    ## Read in test data
    testDat <- read.table("test/X_test.txt",header = FALSE,sep = "")
    
    ## Read in training data
    trainDat <- read.table("train/X_train.txt",header = FALSE,sep = "")
    
    ## Read in featurs data which will be used as viarible names, rename the 
    ## columns names making them easy to use
    features <- read.table("features.txt")
    names(features) <- c("index","feature")
    
    ## Use regular expression to find the index match the format "-mean()" or 
    ## "-std()" in features$feature, then assign the selected index to col_with_mean_or_std
    ## strip the "()" in features, because the "()" provide NO extra information
    col_with_mean_or_std <- grep("-mean\\(\\)|-std\\(\\)",features$feature)
    features$feature <- features$feature %>% str_replace("\\(\\)","")
  
    ## select columns in test data based on col_with_mean_or_std
    testDat <- testDat %>%
      select(c(col_with_mean_or_std))
    
    ## select columns in training data based on col_with_mean_or_std
    trainDat <- trainDat %>%
      select((c(col_with_mean_or_std)))
    
    ## combine selected test and training data and assign to harDat
    harDat <- rbind(trainDat,testDat)
    
    ## name the columns of harDat with selecte feature based on col_with_mean_or_std
    names(harDat) <- make.names(features[col_with_mean_or_std,2])
  
    ## Read in acticity id from training and test data, seperately
    activity_train <- read.table("train/y_train.txt")
    activity_test <- read.table("test/y_test.txt")
    
    ## Read in subject from training and test data, seperately
    subject_train <- read.table("train/subject_train.txt")
    subject_test <- read.table("test/subject_test.txt")
  
    ## Combine activity id from training and test
    activity_id <- rbind(activity_train,activity_test)
    
    ## Combine subject from training and test
    subject <- rbind(subject_train,subject_test)
    
    ## make a charactor vector contains "train" with the length same as 
    ## observations in training dataset
    class_label_train <- rep("train",length(activity_train$V1))    
    
    ## make a charactor vector contains "test" with the length same as 
    ## observations in test dataset
    class_label_test <- rep("test",length(activity_test$V1))
    
    ## combine the two vectors
    class_label <- c(class_label_train,class_label_test)
    
    ## Here dplyr comes in. mutate three new columns to harDat, which are "class.label"
    ## activity.id and subject
    harDat <- harDat %>%
        mutate(class.label = class_label,activity.id = 
                   activity_id$V1,subject = subject$V1)
    
    ## Read in the activity lookup data from activity_labels.txt
    ## rename the columns so as to easy use
    activity_labels <- read.table("activity_labels.txt")
    names(activity_labels) <- c("activity.id","activity")
    
    ## left join harDat and activity_labels to add a new column named "activity"
    ## which contains the descriptive name of 6 acticities
    ## After that, remove column activity.id and rearrange the columns
    harDat <- harDat %>%
        left_join(activity_labels,by = "activity.id") %>%
        select(-activity.id) %>%
        select(subject,activity,1:69)
    
    ## export the cleaned dataframe to "anblytic_data.txt"
    write.table(harDat,file="analytic_data.txt",row.names=FALSE)
    
    ## this step calculate the average based on subject and activity.
    ## first deselect class.label column, because this charactor column will not be 
    ## calculated.
    ## second, group by "activity" and "subject" column
    ## thid, calculate mean for every column.
    ## last, rearrange the columns to make them look nicer.
    group_average <- harDat %>%
        select(-class.label) %>%
        group_by(activity,subject) %>%
        summarise_all(.funs = mean,na.rm = TRUE) %>%
        select(subject,activity,1:68)
    
    ## Last step, export the dataframe to "tidy_data_average.txt" 
    write.table(group_average,file="tidy_data_average.txt",row.names=FALSE)
}
