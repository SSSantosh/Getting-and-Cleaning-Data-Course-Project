# Getting-and-Cleaning-Data-Course-Project
 
1.Steps taken in the process of tidying:
 + The training and test data sets are read specifying column names from the feature list file.
 + 79 required features which are mean and standard deviation are selected.
 + The training and test data sets are merged by rbind() function.
 + The files containing subject identifier and activity labels for both training and testing data sets     are merged together and merged with the main data set using cbind() function. 
 + The data frame is split and rearranged according to, first the activity label and then the subject.
 + The means are then calculated based on the grouping above using colMeans() function.
 +  The tidied data set containing 180 rows and 81 columns is presented.