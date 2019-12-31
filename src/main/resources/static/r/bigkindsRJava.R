start <- Sys.time(); print(paste('start : ', start))
if(!require(rvest)) install.packages("rvest")
if(!require(stringr)) install.packages("stringr")
if(!require(RSelenium)) install.packages("RSelenium")
if(!require(rJava)) install.packages("rJava")
if(!require(Rserve)) install.packages("Rserve")
if(!require(DBI)) install.packages("DBI")
if(!require(RJDBC)) install.packages("RJDBC")

drv <- JDBC(driverClass=driverClass, classPath=connectPath)
conn <- dbConnect(drv, driver, userName, password)
pJS <- wdman::phantomjs(port = seleniumPort)
remDr <- remoteDriver(remoteServerAddr=seleniumIP,port = seleniumPort, browserName = seleniumBrowser)

remDr$open(); remDr$maxWindowSize()
remDr$navigate("https://www.bigkinds.or.kr/v2/news/search.do")
Sys.sleep(8)
getIdx <- as.numeric(dbGetQuery(conn, "select idx from news_list order by idx desc limit 1"))
ifelse(is.na(getIdx), getIdx<-0, getIdx)
idx=NULL;newsname=NULL;title=NULL;category=NULL;date=NULL;url=NULL;content=NULL;dataSize=NULL
print('getElementText is Start')
tryCatch({
  for(menu in 1:1) {
    if (menu == 4)
      menu <- 6
    menuBtn <- paste0('#filter-category-00',menu,'000000')
    menuBtnLink <- remDr$findElements(using='css',menuBtn)
    sapply(menuBtnLink, function(x){ x$clickElement() })
    Sys.sleep(6)
    
    categoryaddr <- paste0('#filter-category > div > div:nth-child(', menu, ') > label')
    categoryLink <- remDr$findElements(using='css', categoryaddr)
    getCategory <- unlist(sapply(categoryLink, function(x){ x$getElementText() }))
    getCategory <- str_sub(getCategory, start=1L, end=2L)
    #############################################################################################3
    page<-4
    for(pageNB in 1:1) { 
      for(index in 1:1){
        print(paste0('pageNB: ', pageNB))
        print(paste0('index: ', index))
        NewsNameaddr <- paste0('#news-results > div:nth-child(',index,') > div.news-item__body > div.news-item__meta > a')
        NewsNameLink <- remDr$findElements(using='css', NewsNameaddr)
        getNewsName <- unlist(sapply(NewsNameLink, function(x){ x$getElementText() }))
        
        dateaddr <- paste0('#news-results > div:nth-child(',index,') > div.news-item__body > div.news-item__meta > span.news-item__date')
        dateLink <- remDr$findElements(using='css', dateaddr)
        getDate <- unlist(sapply(dateLink, function(x){ x$getElementText() }))
        
        titleaddr <- paste0('#news-results > div:nth-child(',index,') > div.news-item__body > h4')
        titleLink <- remDr$findElements(using='css', titleaddr)
        getTitle <- unlist(sapply(titleLink, function(x){ x$getElementText() }))
        getTitle <- gsub(pattern = "\\\"", replacement = "", getTitle)
        sapply(titleLink, function(x){ x$clickElement() })
        Sys.sleep(3)
        
        imgaddr <- '#news-detail-modal > div > div > div.modal-body > div > div > img'
        imgLink <- remDr$findElements(using='css', imgaddr)
        if(length(imgLink) == 0) {
          getUrl <- 0
        } else {
          getUrl <- unlist(sapply(imgLink, function(x){ x$getElementAttribute("src") }))
        }
        contentaddr <- '#news-detail-modal > div > div > div.modal-body > div'
        contentLink <- remDr$findElements(using='css', contentaddr)
        getContent <- unlist(sapply(contentLink, function(x){ x$getElementText() }))
        getContent <- gsub(pattern = "\n", replacement = "<br>", getContent)
        Sys.sleep(3)
        
        xbtnaddr <- '#news-detail-modal > div > div > div.modal-header > button > span'
        xbtnLink <- remDr$findElements(using='css', xbtnaddr)
        sapply(xbtnLink, function(x){ x$clickElement() })
        Sys.sleep(3)
        getIdx <- getIdx + 1
        getSize <- object.size(c(getIdx, getNewsName, getTitle, getCategory, getDate, getUrl, getContent))
        
        print(paste('idx: ', getIdx))
        print(paste('newsname: ', getNewsName))
        print(paste('title: ', getTitle))
        print(paste('category: ', getCategory))
        print(paste('date: ', getDate))
        print(paste('url: ', getUrl))
        print(paste('content: ', getContent))

        query <- paste0("select count(idx) from (select * from news_list where dataSize=", getSize, 
          ") as n where newsname like '%", getNewsName, "%' or category like '%", getCategory, "%'")
        dataDistinct <- dbGetQuery(conn, query)
        if(dataDistinct > 0) next
        
        idx <- c(idx, getIdx)
        newsname <- c(newsname, getNewsName)
        title <- c(title, getTitle)
        category <- c(category, getCategory)
        date <- c(date, getDate)
        url <- c(url, getUrl)
        content <- c(content, getContent)
        dataSize <- c(dataSize, getSize)
      }
      
      if(page == 4)
        break
      linkCss <- paste0('#news-results-pagination > ul > li:nth-child(', page, ') > a')
      linkCssLink <- remDr$findElements(using='css', linkCss)
      sapply(linkCssLink, function(x){ x$clickElement() })
      Sys.sleep(6)
      if(page == 10)
        page <- 4
      else
        page <- page + 1 
    }
    
    if(menu == 1)
      break
    remDr$executeScript("scrollBy(0, -8000)")
    Sys.sleep(1)
    menuBtn <- '#collapse-step-2 > div > div > div.col-sm-3.col-lg-2 > div > h4 > button > i'
    menuBtnLink <- remDr$findElements(using='css', menuBtn)
    sapply(menuBtnLink, function(x){ x$clickElement() })
    Sys.sleep(7)
  }
  result <- data.frame(idx, newsname, title, category, date, url, content, dataSize)
  print('getElementText is Finish')
  write.csv2(result, path, row.names = FALSE)
  dbSendQuery(conn, paste0("load data local infile '",path,"' into table news_list character set utf8 fields terminated by ';' lines terminated by '\n' ignore 1 lines"))
}, error = function(e) {
  #next
  print(e)
}, warning = function(e) {
  print(e)
}, finally = {
  end <- Sys.time(); print(paste('End Time : ', end))
  print(paste('Total execution time estimate : ', end-start))
  remDr$close(); pJS$stop()
  rm(list=ls())
})