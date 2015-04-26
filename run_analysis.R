library(dplyr)

# save the data in the project folder in your directory and merge  

getwd()
x_train <- read.table("project/train/X_train.txt")
y_train <- read.table("project/train/y_train.txt")
subject_train <- read.table("project/train/subject_train.txt")

x_test <- read.table("project/test/X_test.txt")
y_test <- read.table("project/test/y_test.txt")
subject_test <- read.table("project/test/subject_test.txt")

x_data <- rbind(x_train, x_test)

y_data <- rbind(y_train, y_test)

subject_data <- rbind(subject_train, subject_test)

#extract standard deviation and mean

features <- read.table("project/features.txt")

#?grep

mean_and_std_features <- grep("-(mean|std)\\(\\)", features[, 2])

x_data <- x_data[, mean_and_std_features]

# setting feature names
names(x_data) <- features[mean_and_std_features, 2]


# Use descriptive activity names to name the activities in the data set

activities <- read.table("project/activity_labels.txt")
#head(activities)
# rename correct activity names
y_data[, 1] <- activities[y_data[, 1], 2]

# rename columns
names(y_data) <- "activity"


# rename column
names(subject_data) <- "subject"

# consolidating all tables in one
all_data <- cbind(x_data, y_data, subject_data)
dim(all_data)
head (all_data)
tail(all_data)
# creating the new table

averages_data <- ddply(all_data, .(subject, activity), function(x) colMeans(x[, 1:66]))

write.table(averages_data, "averages_data.txt", row.name=FALSE)
