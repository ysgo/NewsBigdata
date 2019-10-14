# install.packages("RSelenium")
# install.packages("rvest")
# install.packages("rJava")
# install.packages("Rserve")
library(rvest)
library(RSelenium)
library(stringr)
library(DBI)
library(rJava)
library(RJDBC)



remDr<-remoteDriver(remoteServerAddr = "localhost", port=4445, browserName="chrome")
remDr$open()
remDr$navigate("https://www.bigkinds.or.kr/v2/news/search.do")
Sys.sleep(6)

newsname=NULL
title=NULL
category=NULL
date=NULL
url=NULL
content=NULL
menunb <- 1
for(menu in 1:4){
  if (menu==4)
    menunb<-6
  
  menuBtn<-paste0('#filter-category-00',menunb,'000000')
  menuBtnLink<-remDr$findElements(using='css',menuBtn)
  sapply(menuBtnLink,function(x){x$clickElement()})
  Sys.sleep(3)
  
  categoryaddr<-paste0('#filter-category > div > div:nth-child(',menunb,') > label')
  categoryLink<-remDr$findElements(using='css',categoryaddr)
  getCategory<-unlist(sapply(categoryLink,function(x){x$getElementText()}))
  getCategory<-str_sub(getCategory,start = 1L,end=2L)
  Sys.sleep(2)
  
  #############################################################################################3

  page<-4
  for(pageNB in 1:1){ 
    for(index in 1:1){
 
      NewsNameaddr<-paste0('#news-results > div:nth-child(',index,') > div.news-item__body > div.news-item__meta > a')
      NewsNameLink<-remDr$findElements(using='css',NewsNameaddr)
      getNewsName<-unlist(sapply(NewsNameLink,function(x){x$getElementText()}))
      # Sys.sleep(3)
      titleaddr<-paste0('#news-results > div:nth-child(',index,') > div.news-item__body > h4')
      titleLink<-remDr$findElements(using='css',titleaddr)
      sapply(titleLink,function(x){x$clickElement()})
      Sys.sleep(2)
      # if (length(titleLink)==0){
      #   endFlag <- TRUE
      #   break
      # }
      
      titleddr<-'#news-detail-modal > div > div > div.modal-header > h4.modal-title'
      titleLink<-remDr$findElements(using='css',titleddr)
      getTitle<-unlist(sapply(titleLink,function(x){x$getElementText()}))
      getTitle<-gsub(pattern = "\\\"", replacement = "", getTitle)
      
      dateaddr<-'#news-detail-modal > div > div > div.modal-header > div.pull-left > span:nth-child(4)'
      dateLink<-remDr$findElements(using='css',dateaddr)
      getDate<-unlist(sapply(dateLink,function(x){x$getElementText()}))
      
      imgaddr<-'#news-detail-modal > div > div > div.modal-body > div > div > img'
      imgLink<-remDr$findElements(using='css',imgaddr)
      if(length(imgLink)==0){
        getUrl<-0
      }else{
        getUrl<-unlist(sapply(imgLink,function(x){x$getElementAttribute("src")}))
      }
      contentaddr<-'#news-detail-modal > div > div > div.modal-body > div'
      contentLink<-remDr$findElements(using='css',contentaddr)
      getContent<-unlist(sapply(contentLink,function(x){x$getElementText()}))
      getContent<-gsub(pattern = "\n", replacement = "<br>", getContent)
      
      newsname<-c(newsname,getNewsName)
      title<-c(title,getTitle)
      category<-c(category,getCategory)
      date<-c(date,getDate)
      url<-c(url,getUrl)
      content<-c(content,getContent)

      xbtnaddr<-'#news-detail-modal > div > div > div.modal-header > button > span'
      xbtnLink<-remDr$findElements(using='css',xbtnaddr)
      sapply(xbtnLink,function(x){x$clickElement()})
      
      Sys.sleep(2)
    }

    # if(page==4)
    #   break
    
    linkCss<-paste0('#news-results-pagination > ul > li:nth-child(',page,') > a')
    linkCssLink<-remDr$findElements(using='css',linkCss)
    sapply(linkCssLink,function(x){x$clickElement()})
    Sys.sleep(3)
    if(page==10)
      page<-4
    else
      page<-page+1
  }
  # 
  # if(menunb==1){
  #   dfPolitics<-data.frame(newsname,title,category,date,url,content)
  #   # write.csv(dfPolitics,"dfPolitics.csv",row.names=FALSE, fileEncoding = "UTF-8")
  #   # write.csv(dfPolitics,"dfPoliticsNotEncodingtest.csv",row.names=FALSE)
  #   # break
  # }else if(menunb==2){
  #   dfBusiness<-data.frame(newsname,title,category,date,url,content)
  #   # write.csv(dfBusiness,"dfBusiness.csv",row.names=FALSE,fileEncoding = "UTF-8")
  #   # write.csv(dfBusiness,"dfBusinessNotEncoding.csv",row.names=FALSE)
  #   
  # }else if(menunb==3){
  #   dfSocialAffairs<-data.frame(newsname,title,category,date,url,content)
  #   # write.csv(dfSocialAffairs,"dfSocialAffairs.csv",row.names=FALSE,fileEncoding = "UTF-8")
  #   # write.csv(dfSocialAffairs,"dfSocialAffairsNotEncoding.csv",row.names=FALSE)
  # }else if(menunb==5){
  #   dfWorld<-data.frame(newsname,title,category,date,url,content)
  #   # write.csv(dfWorld,"dfWorld.csv",row.names=FALSE,fileEncoding = "UTF-8")
  #   # write.csv(dfWorld,"dfWorldNotEncoding.csv",row.names=FALSE)
  # }
  

  menuBtn<-paste0('#filter-category-00',menunb,'000000')
  menuBtnLink<-remDr$findElements(using='css',menuBtn)
  sapply(menuBtnLink,function(x){x$clickElement()})
  Sys.sleep(3)
  if(menunb==6)
    break
  menunb <- menunb + 1
}

remDr$close()
dfall<- data.frame(newsname,title,category,date,url,content)

