# Tidied Human Activity Recognition Data Code Book

Coursera Project: Getting and Cleaning Data  
Author: Adam Schloss  
Date: 10-14 Aug 2020

## Study Design

### Data Source

The data in question were collected in 2012 by Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, and Luca Oneto (hereafter referred to as "the study authors"), of [Smartlab](https://sites.google.com/view/smartlabunige) at the Università degli Studi di Genova [1]. Following is their methodology:

> The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 
> 
> The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

### Data Features (variables)

The study authors have provided the following information regarding the contents of each feature vector:

> The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 
> 
> Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 
> 
> Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 
> 
> These signals were used to estimate variables of the feature vector for each pattern:    
> '-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.
> 
> * tBodyAcc-XYZ
> * tGravityAcc-XYZ
> * tBodyAccJerk-XYZ
> * tBodyGyro-XYZ
> * tBodyGyroJerk-XYZ
> * tBodyAccMag
> * tGravityAccMag
> * tBodyAccJerkMag
> * tBodyGyroMag
> * tBodyGyroJerkMag
> * fBodyAcc-XYZ
> * fBodyAccJerk-XYZ
> * fBodyGyro-XYZ
> * fBodyAccMag
> * fBodyAccJerkMag
> * fBodyGyroMag
> * fBodyGyroJerkMag
> 
> The set of variables that were estimated from these signals are: 
> 
> * mean(): Mean value
> * std(): Standard deviation
> * mad(): Median absolute deviation 
> * max(): Largest value in array
> * min(): Smallest value in array
> * sma(): Signal magnitude area
> * energy(): Energy measure. Sum of the squares divided by the number of values. 
> * iqr(): Interquartile range 
> * entropy(): Signal entropy
> * arCoeff(): Autorregresion coefficients with Burg order equal to 4
> * correlation(): correlation coefficient between two signals
> * maxInds(): index of the frequency component with largest magnitude
> * meanFreq(): Weighted average of the frequency components to obtain a mean frequency
> * skewness(): skewness of the frequency domain signal 
> * kurtosis(): kurtosis of the frequency domain signal 
> * bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
> * angle(): Angle between [two] vectors.

All of the data in the set has been normalized to the range [-1, 1]. No units were reported; since the data are normalized, the question of units is moot.

## Modifications to the Original Data Set

Three key modifications have been made to the original data set.

### Data set merging

As specified above, the original data set was randomly split so that 21 subjects were included in a "training" group and the other 9 subjects were included in a "test" group. Each group had its data stored in a separate set of files. These two groups have been recombined into one.

### File merging

The original data set contained three files with the following contents, for each of the test and training groups:

* Signal data values
* Numeric activity codes
* Numeric subject identifiers

In addition, there were also two more files containing the following information, applied equally to both groups:

* Signal data labels (variable names)
* Activity code conversion table

All together, eight files were merged into a single data set.

### Variable selection

The problem specification requested that only estimates of mean or standard deviation be included in the tidied set. This condition means that the set of signal variables shrinks from 561 to 66.

## Variable Naming Convention

The tidy data set includes 68 columns. The first, `subjectid`, lists the numeric study subject identifier. The second, `activity`, 

The signal variables have been named to be more understandable in the absence of a code book or other supporting documentation. Each variable is named using the following five-part convention, with each part separated by a `-` for ease of readability:

| Name part | Meaning | Allowable values |
| --- | --- | --- |
| domain | Is this signal measured in the time domain, or has it been Fourier-transformed to the frequency domain? | `time`, `fourier` |
| signal type | Does this signal measure body movement, or the acceleration due to gravity? | `body`, `gravity` |
| source | What physical device did this signal come from? Was it differentiated in time? | `accelerometer`, `accelerometerjerk`, `gyroscope`, `gyroscopejerk` |
| calculation | Which value was estimated for this signal? | `mean`, `stdev` |
| component | Along which axis was this signal measured? Or, is this signal the magnitude of an X-Y-Z signal combination? | `magnitude`, `x`, `y`, `z` |

## References

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012