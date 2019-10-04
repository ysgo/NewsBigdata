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


#빅카인즈
remDr<-remoteDriver(remoteServerAddr = "localhost", port=4445, browserName="chrome")
remDr$open()
remDr$navigate("https://www.bigkinds.or.kr/v2/news/search.do")
Sys.sleep(10)


newsname=NULL
title=NULL
category=NULL
date=NULL
url=NULL
content=NULL
for(menunb in 1:4){

  
  if (menunb==4)
    menunb<-5
  
  menuBtn<-paste0('#filter-category-00',menunb,'000000')
  menuBtnLink<-remDr$findElements(using='css',menuBtn)
  sapply(menuBtnLink,function(x){x$clickElement()})
  Sys.sleep(7)
  
  categoryaddr<-paste0('#filter-category > div > div:nth-child(',menunb,') > label')
  categoryLink<-remDr$findElements(using='css',categoryaddr)
  getCategory<-unlist(sapply(categoryLink,function(x){x$getElementText()}))
  getCategory<-str_sub(getCategory,start = 1L,end=2L)
  Sys.sleep(3)
  
  #############################################################################################3

  page<-4
  for(pageNB in 1:1){ #5페이지까지 원할때
    for(index in 1:1){
      #신문사이름
      NewsNameaddr<-paste0('#news-results > div:nth-child(',index,') > div.news-item__body > div.news-item__meta > a')
      NewsNameLink<-remDr$findElements(using='css',NewsNameaddr)
      getNewsName<-unlist(sapply(NewsNameLink,function(x){x$getElementText()}))
      Sys.sleep(3)
      #페이지별 기사 반복 클릭 1페이지-10개 리스트
      titleaddr<-paste0('#news-results > div:nth-child(',index,') > div.news-item__body > h4')
      titleLink<-remDr$findElements(using='css',titleaddr)
      sapply(titleLink,function(x){x$clickElement()})
      Sys.sleep(5)
      #마지막페이지일때 멈춤
      # if (length(titleLink)==0){
      #   endFlag <- TRUE
      #   break
      # }
      
      #제목
      titleddr<-'#news-detail-modal > div > div > div.modal-header > h4.modal-title'
      titleLink<-remDr$findElements(using='css',titleddr)
      getTitle<-unlist(sapply(titleLink,function(x){x$getElementText()}))
      getTitle<-gsub(pattern = "\\\"", replacement = "", getTitle)
      
      #날짜
      dateaddr<-'#news-detail-modal > div > div > div.modal-header > div.pull-left > span:nth-child(4)'
      dateLink<-remDr$findElements(using='css',dateaddr)
      getDate<-unlist(sapply(dateLink,function(x){x$getElementText()}))
      
      #사진
      imgaddr<-'#news-detail-modal > div > div > div.modal-body > div > div > img'
      imgLink<-remDr$findElements(using='css',imgaddr)
      if(length(imgLink)==0){
        getUrl<-0
      }else{
        getUrl<-unlist(sapply(imgLink,function(x){x$getElementAttribute("src")}))
      }
      #내용
      contentaddr<-'#news-detail-modal > div > div > div.modal-body > div'
      contentLink<-remDr$findElements(using='css',contentaddr)
      getContent<-unlist(sapply(contentLink,function(x){x$getElementText()}))

#####################################################
      
      newsname<-c(newsname,getNewsName)
      title<-c(title,getTitle)
      category<-c(category,getCategory)
      date<-c(date,getDate)
      url<-c(url,getUrl)
      content<-c(content,getContent)
      
      print(getTitle)
      
      
      #x 닫기버튼
      xbtnaddr<-'#news-detail-modal > div > div > div.modal-header > button > span'
      xbtnLink<-remDr$findElements(using='css',xbtnaddr)
      sapply(xbtnLink,function(x){x$clickElement()})
      
      Sys.sleep(5)
    }
    
    
    # if(page==7)
    #   page<-7
    
    linkCss<-paste0('#news-results-pagination > ul > li:nth-child(',page,') > a')
    linkCssLink<-remDr$findElements(using='css',linkCss)
    sapply(linkCssLink,function(x){x$clickElement()})
    Sys.sleep(7)
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
  Sys.sleep(7)
  
}

dfall<- data.frame(newsname,title,category,date,url,content)

