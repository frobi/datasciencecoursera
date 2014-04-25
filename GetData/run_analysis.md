# Creating a tidy dataset

This is a brief description, what the run\_analysis.R script does.

The dataset is unzipped to the UCIHARDataset directory.

* load the feature and activity names

Create the test set

* load only the specific columns of the test set from X\_test.txt
* load the type of the activity from Y\_test.txt
* load the subject id from subject\_test.txt
* make the activity names readable (the Y\_test.txt contains only the activity class number)
* add the activity label and the subject id to the test set

Repeat the steps above to create the train set

* load only the specific columns of the train set from X\_train.txt
* load the type of the activity from Y\_train.txt
* load the subject id from subject\_train.txt
* make the activity names readable
* add the activity label and the subject id to the train set

* merge the test and the train set
* add header to the newly created data set

Create the tidy data set

* Reshape the data set with melting and casting

Save the tidy data set as tidy.txt 