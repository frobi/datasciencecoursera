library(httr)
library(httpuv)
library(RJSONIO)
library(jsonlite)

# 1. Find OAuth settings for github:
# http://developer.github.com/v3/oauth/
oauth_endpoints("github")

# 2. Register an application at https://github.com/settings/applications
# Insert your values below - if secret is omitted, it will look it up in
# the GITHUB_CONSUMER_SECRET environmental variable.
#
# Use http://localhost:1410 as the callback url
myapp <- oauth_app("github", key="d3c72a9c1ed755518798",secret="b0fedc8d40b380a0d2f14ac65b473669c54c7b52")

# 3. Get OAuth credentials
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)

# 4. Use API
req <- GET("https://api.github.com/rate_limit", config(token = github_token))

con<-content(req)
cont_proc<-jsonlite::fromJSON(toJSON(con))

stop_for_status(req)
content(req)

# Q2
library(sqldf)

dl.url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
download.file(dl.url, destfile = "acs.csv", method = "internal")


sqldf("select pwgtp1 from acs where AGEP < 50")


# Q3
sqldf("select distinct AGEP from acs")

# Q4
page <- url("http://biostat.jhsph.edu/~jleek/contact.html ")
htmlCode <- readLines(page)
close(page)

lines <- c(10, 20, 30, 100)
result <- c()

for(i in lines){
  characters <- nchar(htmlCode[i])
  result <- c(result, characters)
}

result

# Q5
library(foreign)

dl.url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for"
download.file(dl.url, destfile = "sstdata.for", method = "internal")

data <- read.fortran("sstdata.for",c("F4"))
df <- read.fwf("sstdata.for",skip=4,widths=c(-1,14,4,4,-5,4,4,5,4,4,5,4,4))
