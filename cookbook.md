# Cookbook

Data Science --  Getting and Cleaning Data Course Assignment

Cookbook

## General Purpose

This cookbook is created to "describes the variables, the data, and any transformations 
or work that you performed to clean up the data". This file built on three files on the website -- "features.txt", 
"features_info.txt" and "README.txt". For information on variables and unit, please check the "features_info.txt" file.
It includes a quite detailed descriptionn on both.

Because the lack of related knowledge to this particular area, I just follow the original files and keep least changes to them.
I recommand you read the files for better understanding. I just list the steps, and hopefully, this wil give you a roughly idea 
how I manipulate the data and get the tidy data.

(1)Download and unzip file from(https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)  
I did this manually, however, it can be done perfectly automatically.

(2)Aim to find "the measurements on the mean and standard deviation for each measurement". I did research on the "features_info.txt"
and found the particular pattern "-mean()" and "-std()" for these two measurements. In order to find these features, I use regular 
expression and store the index.

(3)Combine the training and test dataset with selected columns , strip "()" ,use make.names to selected features and 
assign it to dataframe harDat. 

(4)This combination cause an information loss. To prevent it, I add a column called "class.label" setting to "train" or "test".
Till now, I first make change to original data by adding a new column.

(5)Read in the activity id and subject.

(6)Read in activity name from "activity_labels.txt"

(8)Left join the data frame harDat and activity to add a new colomn "activity". I make a second change by adding this column.

(9)Export dataframe harDat to file named "analytic_data.txt"

(10)In case of calculate average based on "activity" and "subject", column 'class.label" is not necessary, 
so I remove it and group the harDat dataframe by "activity" and "subject", then use summarize_all to calculate average 
for each column. Assign the result dataframe to group_average.

(11)Export group_average to the result file named "tidy_data_average.txt"

## Guide to file "tidy_data_average.txt"

There is a new column called "activity" which is the description names of each 6 activities. Column subject is from file 
"subject_train.txt" and "subject_test.txt". All other columns come from the function summarize_all.

It contians 68 columns and 180 rows.


