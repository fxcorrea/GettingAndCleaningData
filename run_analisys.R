
########################### TEST


#load X_test.txt
X_test <- read.table("UCI HAR Dataset/test/X_test.txt")

#load features.txt
features <- read.table("UCI HAR Dataset/features.txt")

#name variables X_test
vector_nombres <- features[, 2]
colnames(X_test) <- vector_nombres

#selected columns mean and std
columnas <- grep("mean|std", names(X_test))

#sub data set X_test
X_test_f <- X_test[,columnas]
  #dim(X_test_f)

#load Y_test.txt
Y_test <- read.table("UCI HAR Dataset/test/Y_test.txt")
  #dim(Y_test)

#load subject_test.txt
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
  #dim(subject_test)

#rename variables
colnames(Y_test) <- c("ActivityID")
colnames(subject_test) <- c("SubjectID")

#load activity_labels.txt
activity <- read.table("UCI HAR Dataset/activity_labels.txt")
colnames(activity) <- c("ActivityID","ActivityName")

#concatenate variables
total_test <- cbind(subject_test,Y_test,X_test_f)
  #dim(total_test)

#MERGE 1  / TEST DATA
test_data <- merge(total_test,activity,by=c("ActivityID"))
  #dim(test_data)
test_data <- test_data[,c(2,82,3:81)]
  #test_data[1:3,1:5]




########################### TRAIN


#load X_train.txt
X_train <- read.table("UCI HAR Dataset/train/X_train.txt")

#name variables X_train
colnames(X_train) <- vector_nombres

#selected columns mean and std
columnas2 <- grep("mean|std", names(X_train))

#sub data set X_train
X_train_f <- X_train[,columnas2]
  #dim(X_train_f)

#load Y_train.txt
Y_train <- read.table("UCI HAR Dataset/train/Y_train.txt")
  #dim(Y_train)

#load subject_train.txt
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
  #dim(subject_train)

#rename variables
colnames(Y_train) <- c("ActivityID")
colnames(subject_train) <- c("SubjectID")

#concatenate variables
total_train <- cbind(subject_train,Y_train,X_train_f)
  #dim(total_train)

#MERGE 1  / TRAIN DATA
train_data <- merge(total_train,activity,by=c("ActivityID"))
  #dim(train_data)
train_data <- train_data[,c(2,82,3:81)]
#train_data[1:3,1:5]


################# FINAL

dim(test_data)
dim(train_data)

final_data <- rbind(test_data,train_data)
  #dim(final_data)
  #final_data[1:3,1:5]

averages <- aggregate(final_data[,-1], by=list(final_data$SubjectID,final_data$ActivityName), FUN=mean)

dim(averages)

write.table(averages, "DataSetFinal.txt", sep="\t")



