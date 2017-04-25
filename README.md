# TidyDataAssignment
Script to merge and tidy a dataset

The run_analysis.R script performs all actions necessary to produce a tidy dataset. The code works by:
	- Reading in the required variables
  - Renaming the column variables to ensure they are descriptive
  - Combine the test and training datasets together
  - Replaces the acitivity numbers with descriptive activity names
  - Select only the variables relating to the mean and standard deviation of each measurement
  - Calculates the mean for each of these variables, for each acitivity and subject
  - Transforms into a tidy dataset, by grouping all variables names into 1 column and the mean of each variable into a second column
  
  The output is a tidy dataset called train_test_combined that contains the average of each variable for each activity and each subject.
