start <- Sys.time()
if(!require(rvest)) install.packages("rvest")
if(!require(RSelenium)) install.packages("RSelenium")
if(!require(rJava)) install.packages("rJava")
if(!require(Rserve)) install.packages("Rserve")
if(!require(stringr)) install.packages("stringr")
if(!require(httr)) install.packages("httr")

#drv <- JDBC(driverClass=driverClass, classPath=connectPath)
#conn <- dbConnect(drv, driver, userName, password)

#pJS <- wdman::phantomjs(port = seleniumPort)
#remDr <- remoteDriver(remoteServerAddr=seleniumIP,port = seleniumPort, browserName = seleniumBrowser)

pJS <- wdman::phantomjs(port = 4445L)
remDr <- remoteDriver(remoteServerAddr="localhost",port = 4445L, browserName = "chrome")

remDr$open(); remDr$maxWindowSize()
remDr$navigate("https://www.bigkinds.or.kr/v2/news/search.do")
Sys.sleep(8)
newsname=NULL;title=NULL;category=NULL;date=NULL;url=NULL;content=NULL
print('getElementText is Start')
for(menu in 1:4) {
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
      
      NewsNameaddr <- paste0('#news-results > div:nth-child(', index, ') > div.news-item__body > div.news-item__meta > a')
      NewsNameLink <- remDr$findElements(using='css', NewsNameaddr)
      getNewsName <- unlist(sapply(NewsNameLink, function(x){ x$getElementText() }))
      
      titleaddr <- paste0('#news-results > div:nth-child(', index, ') > div.news-item__body > h4')
      titleLink <- remDr$findElements(using='css', titleaddr)
      getTitle <- unlist(sapply(titleLink, function(x){ x$getElementText() }))
      getTitle <- gsub(pattern = "\\\"", replacement = "", getTitle)
      
      sapply(titleLink, function(x){ x$clickElement() })
      Sys.sleep(2)
      
      dateaddr <- '#news-detail-modal > div > div > div.modal-header > div.pull-left > span:nth-child(4)'
      dateLink <- remDr$findElements(using='css', dateaddr)
      getDate <- unlist(sapply(dateLink, function(x){ x$getElementText() }))
      
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
      
      print(paste('newsname: ', getNewsName))
      print(paste('title: ', getTitle))
      print(paste('category: ', getCategory))
      print(paste('date: ', getDate))
      print(paste('url: ', getUrl))
      print(paste('content: ', getContent))
      
      newsname <- c(newsname, getNewsName)
      title <- c(title, getTitle)
      category <- c(category, getCategory)
      date <- c(date, getDate)
      url <- c(url, getUrl)
      content <- c(content, getContent)
      
      xbtnaddr <- '#news-detail-modal > div > div > div.modal-header > button > span'
      xbtnLink <- remDr$findElements(using='css', xbtnaddr)
      sapply(xbtnLink, function(x){ x$clickElement() })
      Sys.sleep(2)
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
  
  if(menu == 6)
    break
  menuBtn <- '#collapse-step-2 > div > div > div.col-sm-3.col-lg-2 > div > h4 > button > i'
  menuBtnLink <- remDr$findElements(using='css', menuBtn)
  sapply(menuBtnLink, function(x){ x$clickElement() })
  Sys.sleep(6)
}
print('getElementText is Finish')
result <- data.frame(newsname, title, category, date, url, content)
end <- Sys.time(); print(start); print(end)
print(paste('Time estimate : ', end-start))
#dbDisconnect(conn); 
remDr$close(); pJS$stop()
rm(list=setdiff(ls(), "result"))

