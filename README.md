# tidydata
Coursera Getting and Cleaning Data Project

Scriptname: run_analysis.R
Function: This script loads the data for the human activity recognition using smartphones data 
which can be found at https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

#Step.1a The script loads up the test and training data sets; Each set (train, test) contains three files: subject_<set>.txt, a file containing the subject id of the participant for each observation; X_<set>.txt, a file containing measurements for each observation; and y_<set>.txt, a file containing an activity label id for each observation of the experiment

A new tidy data set of the mean measurements of the standard deviation and mean columns is created. The data set observes the "tidy data" principles as documented in Hadley Wickham's paper (Ref: Section 2.3, page 4, http://www.jstatsoft.org/v59/i10/paper)

1. Each variable forms a column.
2. Each observation forms a row.
3. Each type of observational unit forms a table.

For variable descriptions please see codebook.md

Output: This scripts creates a text file of the tidy data set as described above. 

