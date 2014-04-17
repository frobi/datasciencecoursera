setwd("E:\\ProjectProg\\R")
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(fileUrl, destfile="housing_idaho.csv",method="internal")
dateDownloaded <- date()
data<-read.csv("housing_idaho.csv", header = TRUE)
head(data)
length(data$TYPE==1 & data$VAL == 24)
# olyan subset kellene ahol TYPE==1 & VAL==24
length(na.omit(data$VAL))
subset<-na.omit(data$VAL)
length(subset==24)
length(which(subset==24))

# végső megoldás == 53
which(data$VAL==24)
length(which(data$TYPE==1 & data$VAL==24))

# ez 2129-et ad, ez tartalmazza NA-kat is?
nrow(data[data$VAL==24,])

####
# download xls
fileUrl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
## file corrupted, downloaded manually
download.file(fileUrl, destfile="NGAP.xlsx",method="internal",method="wb")
library(xlsx)
dat<-read.xlsx("getdata_NGAP.xlsx",sheetIndex=1,rowIndex=18:23,colIndex=7:15)
## 36534720
sum(dat$Zip*dat$Ext,na.rm=T)


###
library(XML)
## fileUrl changed from https to http
fileUrl<-"http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
data<-xmlTreeParse(fileUrl,useInternal=T)
root<-xmlRoot(data)
xmlName(root)
names(root)
# zipcode == 21231
# valami jobb verzio h ne kelljen külön subset?
zip<-xpathSApply(data,"//zipcode",xmlValue)
length(which(zip==21231)) #127

#meg nem teszteltem
#zip[zip==21231]


###
fileUrl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
download.file(fileUrl, destfile="housing_idaho_p.csv",method="internal")
library(data.table)
DT<-fread("housing_idaho_p.csv",sep=",",header=T)
DT[,mean(pwgtp15),by=SEX]
