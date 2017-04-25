
#Set the working directory to folder containing the data
setwd('~/UCI HAR Dataset')

#Read in all the required files
activities <- read.table('activity_labels.txt')
features <- read.table('features.txt')
subject_test <- read.table('test/subject_test.txt')
X_test <- read.table('test/X_test.txt')
y_test <- read.table('test/y_test.txt')
subject_train <- read.table('train/subject_train.txt')
X_train <- read.table('train/X_train.txt')
y_train <- read.table('train/y_train.txt')

#Rename the column names of the X datasets to the variable names in the features dataset
colnames(X_test) <- features$V2
colnames(X_train) <- features$V2

#Rename the column names of the y and subject datasets
y_test <- rename(y_test, activity = V1)
y_train <- rename(y_train, activity = V1)
subject_test <- rename(subject_test, subject = V1)
subject_train <- rename(subject_train, subject = V1)

#Add the y dataset to the X dataset to include the activities being performed 
#Then combine the subject dataset to know who is performing each activity
X1_test <- cbind(y_test,X_test)
X2_test <- cbind(subject_test,X1_test)
X1_train <- cbind(y_train,X_train)
X2_train <- cbind(subject_train,X1_train)

#Merges the training and the test sets to create one data set.
train_test_combined <- rbind(X2_test,X2_train)

#adjust the column names in the combined dataset so that they can be used for searching later on
valid_column_names <- make.names(names=names(train_test_combined), unique=TRUE, allow_ = TRUE)
names(train_test_combined) <- valid_column_names

#Replaces the numbers in the acitvity column with the description of the activites
train_test_combined <- merge(train_test_combined, activities, by.x = 'activity', by.y = 'V1') %>%
    mutate(activity = V2 ) %>%

#Extracts only the measurements on the mean and standard deviation for each measurement. 
    select(matches("activity|subject|mean|std")) %>%

#get the average of each variable grouped by the acitivity and subject
    group_by(activity,subject) %>% summarise_each(funs(mean)) %>%

#turn the data frame into a tidy dataset by having the variable type in one column and the mean of the variable in another column
   gather(Variable, Mean, -activity, -subject)

#Save the output dataset into the working directory
write.table(train_test_combined,'train_test_combined.txt', row.names = FALSE)
