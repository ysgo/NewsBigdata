start <- Sys.time()
if(!require(stringr)) install.packages("stringr")
if(!require(dplyr)) install.packages("dplyr")
if(!require(RJDBC)) install.packages("RJDBC")
if(!require(DBI)) install.packages("DBI")
if(!require(devtools)) install.packages("devtools")
if(!require(KoNLP)) install.packages("KoNLP")
if(!require(rJava)) install.packages("rJava")
if(!require(Rserve)) install.packages("Rserve")

drv <- JDBC(driverClass=driverClass, classPath=connectPath)
conn <- dbConnect(drv, driver, userName, password)

if(ctg == '전체') {
  result <- dbGetQuery(conn, 'select content from (select * from news_list where DATE=curdate()) news_list order by rand() limit 10')
} else {
  result <- dbGetQuery(conn, paste0('select content from (select * from news_list where DATE=curdate()) news_list where category="',ctg,'" order by rand() limit 15'))
}
print(paste('result :', result))

resultStr <- paste(unlist(SimplePos22(as.character(result))))
extracted <- str_match(resultStr, "([가-힇]+)/NC")
keyword <- extracted[, 2] %>% na.omit(keyword)
keyword <- Filter(function(x) { nchar(x) >= 2 }, keyword)
print(paste('keyword :', keyword))

keyword30 <- as.data.frame(head(sort(table(keyword), TRUE), 30))
print(paste('keyword30 :', keyword30))

end <- Sys.time(); print(start); print(end)
print(paste('WordClouds Time Estimate :', end-start))
dbDisconnect(conn)
rm(list=setdiff(ls(), "keyword30"))

