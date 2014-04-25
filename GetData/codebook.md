# CodeBook for the tidy data set

Describes variables in the tidy data set. The data set has 180 rows and 81 columns.

* subject.id: Identifies the subject who performed the activity. It's range is from 1 to 30.
* activity.label: name of the performed activity (6 class: WALKING, WALKING\_UPSTAIRS, WALKING\_DOWNSTAIRS, SITTING, STANDING, LAYING)

The other 79 variables are the average of the specific features for each activity and each subject. The variable names corresponds to the feature names of the raw data set. This data set is contains only the means, standard deviations and mean frequencies of the features. For further information about the features, please read the UCIHARDataset/features_info.txt.