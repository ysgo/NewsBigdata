install.packages("KoNLP")
install.packages("wordcloud2")
install.packages("RColorBrewer")
install.packages("memoise")
install.packages("tidyverse")
install.packages("devtools")

library(devtools)
library(KoNLP)
library(wordcloud2)
library(RColorBrewer)
library(rvest)
library(dplyr)
library(stringr)
library(DBI)
library(rJava)
library(RJDBC)
library(tm)
update.packages()
library(tidyverse)
useNIADic()
Sys.getenv("JAVA_HOME")

drv<-JDBC(driverClass="com.mysql.jdbc.Driver",classPath="C:/Rstudy/mysql-connector-java-5.1.40.jar")
conn<-dbConnect(drv,"jdbc:mysql://")

result<-dbGetQuery(conn,"select content from bigkinds")

View(result)
test<-result[2,]


a<-as.character(noun)
unA<-paste(unlist(SimplePos22(a)))
extracted<-str_match(unA,"([가-힇]+)/NC")
keyword <- extracted[, 2]
keyword<-na.omit(keyword)
keyword<-Filter(function(x) {nchar(x)>=2}, keyword)
keyword30<-sort(table(keyword),TRUE)
keyword30<-head(sort(table(keyword),TRUE),30)
keyword30<-as.data.frame(keyword30)
wordcloud2(keyword30)


