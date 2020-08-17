# Getting and Cleaning Data course project

## How to use this repo

Execute `run_analysis.R`:

1. Download the code
2. Start an R session and run the command `source('~/run_analysis.R')` in the folder where the code was saved

The raw dataset manipulated by this code will be downloaded and extracted if it is not present in the local file system.

Dependencies:

* R version 4.0.2
* Package `dplyr` version 1.0.1

Earlier versions of R may work okay, while earlier versions of `dplyr` might not since this code uses syntax which was introduced in version 1.0.0.

## Summary data file

The final step of the code generates a summary file in CSV format. To load the summary in R, download the file and use `read.csv` to open it. No parameters are necessary aside from the file name.

## Code book

The code book is available in this repo, as [codebook.md](https://github.com/amschloss/data-cleaning-project/blob/master/codebook.md). 
