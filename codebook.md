# Tidied Human Activity Recognition Data Code Book

Coursera Project: Getting and Cleaning Data  
Author: Adam Schloss  
Date: 10-14 Aug 2020

## Study Design

### Data Source

The data in question were collected in 2012 by Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, and Luca Oneto (hereafter referred to as "the study authors"), of [Smartlab](https://sites.google.com/view/smartlabunige) at the Università degli Studi di Genova. Following is their methodology:

> The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 
> 
> The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

### Data Features (variables)

The study authors 

## Modifications to the Original Data Set



## Variable Naming Convention

The signal variables have been renamed to be more understandable in the absence of a code book or other supporting documentation. Each variable is named using the following multi-part convention, with each part separated by a `-` for ease of readability:

| Name part | Meaning | Allowable values |
| --- | --- | --- |
| domain | Is this signal measured in the time domain, or has it been Fourier-transformed to the frequency domain? | `time`, `fourier` |
| signal type | Does this signal measure body movement, or the acceleration due to gravity? | `body`, `gravity` |
| source | What physical device did this signal come from? Was it differentiated in time? | `accelerometer`, `accelerometerjerk`, `gyroscope`, `gyroscopejerk` |
| component | Along which axis was this signal measured? Or, is this signal the magnitude of an X-Y-Z signal combination? | `magnitude`, `x`, `y`, `z` |
