GettingAndCleaningData
======================

Getting and Cleaning Data Course Project


########################### TEST


load X_test.txt
load first file
X_test <- read.table("UCI HAR Dataset/test/X_test.txt")

load features.txt
load features of variables. (one time)
features <- read.table("UCI HAR Dataset/features.txt")

name variables X_test
rename variables with second column of data frame features
vector_nombres <- features[, 2]
colnames(X_test) <- vector_nombres

selected columns mean and std
select only columns that i will use
columnas <- grep("mean|std", names(X_test))

sub data set X_test
subdataset with specific columns
X_test_f <- X_test[,columnas]
  
load other files
load Y_test.txt
Y_test <- read.table("UCI HAR Dataset/test/Y_test.txt")
load subject_test.txt
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")

rename variables with correct name
colnames(Y_test) <- c("ActivityID")
colnames(subject_test) <- c("SubjectID")

load activity_labels.txt
activity <- read.table("UCI HAR Dataset/activity_labels.txt")
colnames(activity) <- c("ActivityID","ActivityName")

concatenate variables
total_test <- cbind(subject_test,Y_test,X_test_f)

MERGE 1  / TEST DATA
merge all files
test_data <- merge(total_test,activity,by=c("ActivityID"))
order columns
test_data <- test_data[,c(2,82,3:81)]


########################### TRAIN
repeat the same steps described previously

load X_train.txt
X_train <- read.table("UCI HAR Dataset/train/X_train.txt")

name variables X_train
colnames(X_train) <- vector_nombres

selected columns mean and std
columnas2 <- grep("mean|std", names(X_train))

sub data set X_train
X_train_f <- X_train[,columnas2]

load Y_train.txt
Y_train <- read.table("UCI HAR Dataset/train/Y_train.txt")

load subject_train.txt
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")

rename variables
colnames(Y_train) <- c("ActivityID")
colnames(subject_train) <- c("SubjectID")

concatenate variables
total_train <- cbind(subject_train,Y_train,X_train_f)

MERGE 1  / TRAIN DATA
train_data <- merge(total_train,activity,by=c("ActivityID"))
train_data <- train_data[,c(2,82,3:81)]


################# FINAL

only test dimentions
dim(test_data)
dim(train_data)

create a final data set
final_data <- rbind(test_data,train_data)
  
calculate mean
averages <- aggregate(final_data[,-1], by=list(final_data$SubjectID,final_data$ActivityName), FUN=mean)

write a file with final result
write.table(averages, "DataSetFinal.txt", sep="\t")


