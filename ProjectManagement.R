##USING GITHUB AND R/MARKDOWN FOR PROJECT MANAGEMENT
#Haley Ritger on May 17, 2017 as part of IDEAS workshop at UGA

#load data and create a plot
mers <- read.csv("CopyOfcases.csv")
head(mers)
#also click blue arrow in Environment tab to check how each piece of data is categorized
#some varibales should be stored as dates but they are stored as "Factors"
#ask R what class of data is onset date?
class(mers$onset)
#it is a factor; we need to reclassify as a date
head(mers$onset)
#we also need to correct some errors
#what exactly is the error?
mers$hospitalized[890]
#the year is wrong
mers$hospitalized[890] <- c('2015-02-20')
mers <- mers[-471,]
#still not sure what exactly what this line of code above is doing? subsetting the data?
#correct from factors to dates using lubridate
library(lubridate) 
mers$onset2 <- ymd(mers$onset) 
mers$hospitalized2 <- ymd(mers$hospitalized) 
class(mers$onset2)
#find days elapsed since start of epidemic
day0 <- min(na.omit(mers$onset2))
##QUESTION:  Why do we use the function na.omit? What happens if we neglect this command? 
#na.omit skips performing the calculation for blank values; not sure what would happen if we neglected the command--might just put 0 for all?
#create a new, numeric value for the “epidemic day” for each case. 
mers$epi.day <- as.numeric(mers$onset2 - day0)
##QUESTION:  What purpose does the command as.numeric serve?
#the as.numeric command tells R to classify that data point as a number (rather than say, a factor)
##making a plot
library(ggplot2) 
ggplot(data=mers) + geom_bar(mapping=aes(x=epi.day)) + labs(x='Epidemic day', y='Case count', title='Global count of MERS cases by date of symptom onset', caption="Data from: https://github.com/rambaut/MERS-Cases/blob/gh-pages/data/cases.csv")
