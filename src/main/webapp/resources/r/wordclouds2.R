if(!require(KoNLP)) install.packages("KoNLP")
if(!require(devtools)) install.packages("devtools")
if(!require(stringr)) install.packages("stringr")
if(!require(dplyr)) install.packages("dplyr")
if(!require(RJDBC)) install.packages("RJDBC")
if(!require(DBI)) install.packages("DBI")
if(!require(rJava)) install.packages("rJava")
if(!require(Rserve)) install.packages("Rserve")

drv<-JDBC(driverClass="com.mysql.jdbc.Driver",classPath=connectPath)
conn<-dbConnect(drv,driver, userName, password)

if(ctg=='전체'){
  result<-dbGetQuery(conn,'select content from (select * from news_list where DATE=curdate()) news_list order by rand() limit 10')
}else{
  result<-dbGetQuery(conn,paste0('select content from (select * from news_list where DATE=curdate()) news_list where category="',ctg,'" order by rand() limit 15'))
}

resultStr<-as.character(result)
unA<-paste(unlist(SimplePos22(resultStr)))
extracted<-str_match(unA,"([가-힇]+)/NC")
keyword <- extracted[, 2] %>% na.omit(keyword)
keyword<-Filter(function(x) {nchar(x)>=2}, keyword)
keyword30<-head(sort(table(keyword),TRUE),30)

keyword30<-as.data.frame(keyword30)

