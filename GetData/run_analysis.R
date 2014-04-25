#### Getting and Cleaning Data programming assignment
####
#### R script that creates a tidy dataset from a raw dataset
#### Written by Robert Farkas

library(reshape2)

## load features and activity labels
features <- read.table("UCIHARDataset/features.txt",header=F,stringsAsFactors=F)
a.l <- read.table("UCIHARDataset/activity_labels.txt")

## first working on the test set

# get the necessery columns
c <- grep("mean|std",features[,2])
f <- rep("NULL",561)
f[c] <- "numeric"
rm(c)

# load only the specific columns
x.test <- read.table("UCIHARDataset/test/X_test.txt", header=F, colClasses=f)
y.test <- read.table("UCIHARDataset/test/Y_test.txt", header=F)
s.test <- read.table("UCIHARDataset/test/subject_test.txt", header=F)
m.test <- dim(y.test)[1]  # no.training examples
# make readable activity labels
y.l <- rep("",m.test)

# I'm sure, that there is a better solution that don't need loops
for(i in 1:m.test)
{
  for(k in 1:6)
  {
    if (y.test[i,1] == a.l[k,1])
      y.l[i] <- as.character(a.l[k,2])
  }
}

# add the activity labels to x.test
x.test <- cbind(x.test,y.l)
# add the subjects
x.test <- cbind(x.test,s.test)

## create the train set
# steps are the same as load the test set
x.train <- read.table("UCIHARDataset/train/X_train.txt", header=F, colClasses=f)
y.train <- read.table("UCIHARDataset/train/Y_train.txt", header=F)
s.train <- read.table("UCIHARDataset/train/subject_train.txt", header=F)
m.train <- dim(y.train)[1]  # no.training examples

y.l <- rep("",m.train)
for(i in 1:m.train)
{
  for(k in 1:6)
  {
    if (y.train[i,1] == a.l[k,1])
      y.l[i] <- as.character(a.l[k,2])
  }
}

x.train <- cbind(x.train,y.l)
x.train <- cbind(x.train,s.train)

## merge the test and train set
tidy <- rbind(x.test,x.train)
# remove unnecessery data
rm(list=c("x.test","y.test","s.test","x.train","y.train","s.train"))

## add header to the tidy data set
# load the feature names
fn <- grep("mean|std",features[,2],value=T)
# remove parentheses, replace - with .
# eg.: tBodyAcc-mean()-X -> tBodyAcc.mean.X
fn <- gsub('\\()',"",fn)
fn <- gsub("-",".",fn)
fn <- append(fn,"activity.label")
fn <- append(fn,"subject.id")
# add the header
colnames(tidy) <- fn

#### at this point the data set is clean

## create a second, independent tidy data set
# 6 activity * 30 subject = 180 row
# new dataset 180x81
# melt
tmelt <- melt(tidy, id=c("activity.label","subject.id"))
# dcast
final.data <- dcast(tmelt,subject.id+activity.label ~ variable, mean)
# remove tidy, tmelt
rm("tidy","tmelt")

# save the data set
write.table(final.data, file="tidy.txt")

# system.time(source("run_analysis.R"))
# user  system  elapsed
# 9.31  0.22    9.58