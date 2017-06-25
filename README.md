# DS_Class3_Week4_Assignment

Data Science --  Getting and Cleaning Data Course Assignment

README

## General Overview 

This repository contains three files:
1.README.md
2.codebook.md
3.run_analysis.R

run.anaysis.R is the functional file performing data cleaning task. There are two things you should know before using it.
1. You should set your working derectory to the "UCI HAR Datset" folder. The R file dose NOT perform downloading and unzipping 
job for you, so you may need to download the file and unzip it manually. After that, you need use setwd() function to set your 
working directory.
2. The R file will load library "dplyr" and "stringr". You may not need to load them by youeself, but it will not install 
the two packages for you, so make sure you already install them before run it.

## Script Description

In the R file, the comments has been made along the code, but I decide to write this description so that you may 
understand what happens more clearly.

(1)load the library "dplyr" & "stringr"

(2)read in the training and test data seperately

(3)read in features.txt for column name

(4)use regular expression to select "-mean()" and "-std()" from all features and store the index

(5)remove "()" in features

(6)use the stored index to select columns from training and test dataframe

(7)combine the training and test dataframe, assign the new dataframe to harDat,rename the columns according to features

(8)read in activity id and subject

(9)combine the activity id and subject dataframe seperately

(10)create a vector indicating each row belongs to "trainging" or "test" dataset. (This step is not necessary for this assignment
, but after the previou selection and combination steps, the indication to training or test information is lost. To prevent this,
I create a column called "class.label" to reserve this information. 

(11)use mutate function to add columns "class.label","activity.id" and "subject" to dataframe harDat

(12)read in activity lookup or mapping table from "activity_label.txt"

(13)use left_join function to add a new column named "activity" which is the deccription of activity

(14)remove the "activity.id" column and rearrange the columns 

(15)till this, the data cleaning task has been completed. I export harDat to "analytic_data.txt", whereas this file is not required
by the assignment instruction, I do not update it to this repository

(16)to calcuate the average based on activity and subject, I first remove the column "class.label", because it is a charactor
column, thus it is not meaningful to calculate such "average" for it

(17)use group_by function by taking "activity" and "subject" as parameters

(18)use summarize_all plugging in .fun = mean to calculate average for each column

(19)rearrange the result dataframe

(20)write the result to a file called "tidy_data_average.txt" with argument row.names set to FALSE. 
