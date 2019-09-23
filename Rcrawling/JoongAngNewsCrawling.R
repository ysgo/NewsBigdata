install.packages("RSelenium")
install.packages("rvest")
library(rvest)
library(RSelenium)
library(stringr)

#중앙일보
remDr<-remoteDriver(remoteServerAddr = "localhost", port=4445, browserName="chrome")
remDr$open()
remDr$navigate("https://joongang.joins.com/?cloc=joongang-home-bi")
Sys.sleep(5)

politics = NULL
business=NULL
SocialAffairs=NULL
world=NULL

for(categorynb in 2:5){
  if(categorynb==2){
    #정치메뉴시작
    categorynbBtn<-paste0('#doc > div.uh > nav > div.main_section > ul > li:nth-child(',categorynb,') > a > h2')
    categorynbBtnLink<-remDr$findElements(using='css',categorynbBtn)
    sapply(categorynbBtnLink,function(x){x$clickElement()})
    Sys.sleep(3)
  }else{
    menuBtn<-(' body > div.doc > header > div.uh > nav > a')
    menuBtnLink<-remDr$findElements(using='css',menuBtn)
    sapply(menuBtnLink,function(x){x$clickElement()})
    Sys.sleep(1)
    
    categorynbBtn<-paste0('#mega_menu > div.bd > ul:nth-child(1) > li:nth-child(',categorynb,') > a > strong')
    categorynbBtnLink<-remDr$findElements(using='css',categorynbBtn)
    sapply(categorynbBtnLink,function(x){x$clickElement()})
    Sys.sleep(3)
  }
  page<-4
  endFlag <- FALSE
  
  repeat{
    # 페이지 위치 조정
    webElem <- remDr$findElement("css", "body")
    remDr$executeScript("scrollTo(0, 100)", args = list(webElem))
    Sys.sleep(1)
    
    for(index in 1:15){#1:15
      #제목 클릭후 제목 날짜 내용 크롤링
      titleaddr<-paste0('#content > div.list_basic.list_sectionhome > ul > li:nth-child(',index,') > h2 > a')
      titleLink<-remDr$findElements(using='css',titleaddr)
      sapply(titleLink,function(x){x$clickElement()})
      Sys.sleep(5)
      
      #제목
      title1<-'#article_title'
      title1Link<-remDr$findElements(using='css',title1)
      title<-unlist(sapply(title1Link,function(x){x$getElementText()}))
      if (length(titleLink)==0){
        endFlag <- TRUE
        break
      }
      #날짜 
      dateaddr<-'#body > div.article_head > div.clearfx > div.byline > em:nth-child(2)'
      dateLink<-remDr$findElements(using='css',dateaddr)
      if(length(dateLink)!=1){
        dateaddr<-'#content > article > header > div.info > p:nth-child(1)'
        dateLink<-remDr$findElements(using='css',dateaddr)
      }
      date<-unlist(sapply(dateLink,function(x){x$getElementText()}))
      date<-gsub("입력 ","",date)
      
      #내용
      contentaddr<-'#article_body'
      contentLink<-remDr$findElements(using='css',contentaddr)
      content<-unlist(sapply(contentLink,function(x){x$getElementText()}))
      
      #이미지텍스트
      imgtextaddr<-'#article_body > div.ab_photo'
      imgtextLink<-remDr$findElements(using='css',imgtextaddr)
      if(length(imgtextLink)!=0){
        imgtext<-unlist(sapply(imgtextLink,function(x){x$getElementText()}))
        
        imgtext <- gsub("\\[","",gsub("]","",imgtext))
        imgtext <- gsub("[()]","",imgtext)
        
        # #사진 주석 제외처리
        content <- gsub("\\[","",gsub("]","",content))
        content<- gsub("[()]","",content)
        
        j <- 1
        repeat{
          content<-str_replace(content,imgtext[j],"")
          
          if(j==length(imgtext)){
            break
          }
          j <- j+1
        }
      }
      #영상텍스트
      videoaddr<-'#article_body > div:nth-child(16) > div'
      videoLink<-remDr$findElements(using='css',videoaddr)
      if(length(videoLink)!=0){
        videotext<-unlist(sapply(videoLink,function(x){x$getElementText()}))
        content<-str_replace(content,videotext,"")
      }
      
      if(categorynb==2){
        politics<-c(politics,title)
        politics<-c(politics,date)
        politics<-c(politics,content)
      }else if(categorynb==3){
        business<-c(business,title)
        business<-c(business,date)
        business<-c(business,content)
      }else if(categorynb==4){
        SocialAffairs<-c(SocialAffairs,title)
        SocialAffairs<-c(SocialAffairs,date)
        SocialAffairs<-c(SocialAffairs,content)
      }else if(categorynb==5){
        world<-c(world,title)
        world<-c(world,date)
        world<-c(world,content)
      }
      
      print(title)
      remDr$goBack()
      Sys.sleep(3)
    }
    if(endFlag)
      break
    
    if(page==13){
      nextPageCSS <-('#content > div.paging_comm > a.btn_next')
      nextPageLink<-remDr$findElements(using='css',nextPageCSS)
      sapply(nextPageLink,function(x){x$clickElement()})
      Sys.sleep(3)
      page<-4
    }else{
      linkCss<-paste0('#content > div.paging_comm > a:nth-child(',page,')')
      linkCssLink<-remDr$findElements(using='css',linkCss)
      sapply(linkCssLink,function(x){x$clickElement()})
      Sys.sleep(3)
      page<-page+1
    }
  }
  
}
