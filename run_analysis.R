# step 1
feature_vector <- read.table("features.txt")

train_data <- read.table("X_train.txt",col.names = feature_vector[,2])
test_data <- read.table("X_test.txt",col.names = feature_vector[,2])

merged_data <- rbind(train_data,test_data)


# step 2
mean_locations <- grep("mean",feature_vector$V2)
std_locations <- grep("std",feature_vector$V2)

extracted_data_mean <- merged_data[,mean_locations]
extracted_data_std <- merged_data[,std_locations]
extracted_data <- cbind(extracted_data_mean,extracted_data_std)


# step 3
subject_num_train <- read.table("subject_train.txt")
subject_num_test <- read.table("subject_test.txt")
subject_num_merged <- rbind(subject_num_train,subject_num_test)
colnames(subject_num_merged) <- "Identifier for Subject"

activity_num_train <- read.table("y_train.txt")
activity_num_test <- read.table("y_test.txt")
activity_num_merged <- rbind(activity_num_train,activity_num_test)
colnames(activity_num_merged) <- c("Activity_num")
  
activity_labels <- read.table("activity_labels.txt")

for (i in 1:6)
activity_num_merged[activity_num_merged$Activity_num==i,"Activity"] <- activity_labels$V2[i]

extracted_data <- cbind(subject_num_merged,extracted_data)
extracted_data <- cbind(activity_num_merged,extracted_data)


# step 5 (tidying)

extracted_data_activity <- split(extracted_data,extracted_data$Activity_num)

extracted_data_better <- data.frame()
r <- data.frame()

for (i in 1:6)
{
    extracted_data_subject <- split(extracted_data_activity[[i]],extracted_data_activity[[i]]$'Identifier for Subject')  
    for (j in 1:30)
    {
   
       extracted_data_better <- rbind(extracted_data_better,extracted_data_subject[[j]])
       
    }
}

tidy_data <- data.frame()

for (i in 1:6)
{
    for (j in 1:30)
    {
      
      Means_num <- colMeans(extracted_data_better[extracted_data_better$`Identifier for Subject`== j & extracted_data_better$Activity_num ==i,c(1,3:82)])
      Means_df <- t(as.data.frame(Means_num))
      tidy_data <- rbind(tidy_data,Means_df)
    
       
    }
}


for (i in 1:6)
  tidy_data[tidy_data$Activity_num==i,"Activity"] <- activity_labels$V2[i]

Activity <- tidy_data[,82]
tidy_data <- cbind(Activity,tidy_data[,2:81])

row.names(tidy_data) <- c(1:180)

write.table(tidy_data,file = "tidy_data.txt",row.names = FALSE)

