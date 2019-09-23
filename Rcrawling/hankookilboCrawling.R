install.packages("RSelenium")
install.packages("rvest")
library(rvest)
library(RSelenium)
library(stringr)

politics = NULL
business=NULL
SocialAffairs=NULL
world=NULL
#한국일보
remDr<-remoteDriver(remoteServerAddr = "localhost", port=4445, browserName="chrome")
remDr$open()
remDr$navigate("https://www.hankookilbo.com/")

for(categorynb in 2:5){
  menuBtn<-paste0('body > nav > div.wrapper > ul.gnb > li:nth-child(',categorynb,') > a')
  menuBtnLink<-remDr$findElements(using='css',menuBtn)
  sapply(menuBtnLink,function(x){x$clickElement()})
  Sys.sleep(3)
  
  page<-2
  for(first1to10 in 1:10){
    for(index in 1){#1:15
      #제목 클릭후 날짜 내용 크롤링
      titleaddr<-paste0('#DataFrm > ul > li:nth-child(',index,') > div.body > a > p.title')
      titleLink<-remDr$findElements(using='css',titleaddr)
      sapply(titleLink,function(x){x$clickElement()})
      Sys.sleep(5)
      
      #제목
      title1<-'#content > article > header > h3'
      title1Link<-remDr$findElements(using='css',title1)
      title<-unlist(sapply(title1Link,function(x){x$getElementText()}))
      
      #날짜 
      dateaddr<-'#content > article > header > div.info >p'
      dateLink<-remDr$findElements(using='css',dateaddr)
      if(length(dateLink)!=1){
        dateaddr<-'#content > article > header > div.info > p:nth-child(1)'
        dateLink<-remDr$findElements(using='css',dateaddr)
      }
      date<-unlist(sapply(dateLink,function(x){x$getElementText()}))
      date<-gsub("입력 ","",date)
      
      #내용
      contentaddr<-'#article_story'
      contentLink<-remDr$findElements(using='css',contentaddr)
      content<-unlist(sapply(contentLink,function(x){x$getElementText()}))
      
      #이미지파트
      imgtextaddr<-'#article_story > figure'
      imgtextLink<-remDr$findElements(using='css',imgtextaddr)
      if(length(imgtextLink)!=0){
        imgtext<-unlist(sapply(imgtextLink,function(x){x$getElementText()}))
        # imgtext <- gsub("\\[","",gsub("]","",imgtext))
        # imgtext <- gsub("[()]","",imgtext)
        # imgtext <- gsub("[[©]]","",imgtext)
        # j <- 1
        # repeat{
        #   content<-str_replace(content,imgtext[j],"")
        #   
        #   if(j==length(imgtext)){
        #     break
        #   }
        #   j <- j+1
        # }
      }
      
      #webElem <- remDr$findElement(using='css', '#article_story > div.article-feedback.read')
      #remDr$executeScript("scrollTo(0,document.body.scrollHeight)", args = list(webElem))
      
      #Sys.sleep(1)
      #피드백파트
      feedbackaddr<-'#article_story > div.article-feedback.read'
      feedbackLink<-remDr$findElements(using='css',feedbackaddr)
      feedback<-unlist(sapply(feedbackLink,function(x){x$getElementText()}))
      print(feedback)
      
      #사진 주석 제외처리 +피드백
      content <- gsub("\\[","",gsub("]","",content))
      content<- gsub("[()]","",content)
      
      imgtext <- gsub("\\[","",gsub("]","",imgtext))
      imgtext <- gsub("[()]","",imgtext)
      
      #content<-gsub(feedback,"",content)
      
      
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
    
    if(page==11){
      nextPageCSS <-('#DataFrm > div.pagination > a.next')
      nextPageLink<-remDr$findElements(using='css',nextPageCSS)
      sapply(nextPageLink,function(x){x$clickElement()})
      Sys.sleep(3)
    }else{
      linkCss<-paste0('#DataFrm > div.pagination > a:nth-child(',page,')')
      linkCssLink<-remDr$findElements(using='css',linkCss)
      sapply(linkCssLink,function(x){x$clickElement()})
      Sys.sleep(3)
      page<-page+1
    }
  }
  
  page<-3
  endFlag <- FALSE
  for(x in 1:2){
  #repeat{
    for(index in 1){#1:15
      #제목 클릭후 날짜 내용 크롤링
      titleaddr<-paste0('#DataFrm > ul > li:nth-child(',index,') > div.body > a > p.title')
      titleLink<-remDr$findElements(using='css',titleaddr)
      sapply(titleLink,function(x){x$clickElement()})
      Sys.sleep(5)
      if (length(titleLink)==0){
        endFlag <- TRUE
        break
      }
      
      #제목
      title1<-'#content > article > header > h3'
      title1Link<-remDr$findElements(using='css',title1)
      title<-unlist(sapply(title1Link,function(x){x$getElementText()}))
      
      #날짜 
      dateaddr<-'#content > article > header > div.info >p'
      dateLink<-remDr$findElements(using='css',dateaddr)
      if(length(dateLink)!=1){
        dateaddr<-'#content > article > header > div.info > p:nth-child(1)'
        dateLink<-remDr$findElements(using='css',dateaddr)
      }
      date<-unlist(sapply(dateLink,function(x){x$getElementText()}))
      date<-gsub("입력 ","",date)
      
      #내용
      contentaddr<-'#article_story'
      contentLink<-remDr$findElements(using='css',contentaddr)
      content<-unlist(sapply(contentLink,function(x){x$getElementText()}))
      
      #이미지파트
      imgtextaddr<-'#article_story > figure'
      imgtextLink<-remDr$findElements(using='css',imgtextaddr)
      imgtext<-unlist(sapply(imgtextLink,function(x){x$getElementText()}))
      
      #webElem <- remDr$findElement(using='css', '#article_story > div.article-feedback.read')
      #remDr$executeScript("scrollTo(0,document.body.scrollHeight)", args = list(webElem))
      
      #Sys.sleep(1)
      #피드백파트
      # feedbackaddr<-'#article_story > div.article-feedback.read'
      # feedbackLink<-remDr$findElements(using='css',feedbackaddr)
      # feedback<-unlist(sapply(feedbackLink,function(x){x$getElementText()}))
      
      #사진 주석 제외처리 +피드백
      content <- gsub("\\[","",gsub("]","",content))
      content<- gsub("[()]","",content)
      
      imgtext <- gsub("\\[","",gsub("]","",imgtext))
      imgtext <- gsub("[()]","",imgtext)
      
      #content<-gsub(feedback,"",content)
      
      j <- 1
      repeat{
        content<-str_replace(content,imgtext[j],"")
        if(j==length(imgtext)){
          break
        }
        j <- j+1
      }
      
      if(categorynb==2){
        politics = NULL
        politics<-c(politics,title)
        politics<-c(politics,date)
        politics<-c(politics,content)
      }else if(categorynb==3){
        business=NULL
        business<-c(business,title)
        business<-c(business,date)
        business<-c(business,content)
      }else if(categorynb==4){
        SocialAffairs=NULL
        SocialAffairs<-c(SocialAffairs,title)
        SocialAffairs<-c(SocialAffairs,date)
        SocialAffairs<-c(SocialAffairs,content)
      }else if(categorynb==5){
        world=NULL
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
    
    if(page==12){
      nextPageCSS <-('#DataFrm > div.pagination > a.next')
      nextPageLink<-remDr$findElements(using='css',nextPageCSS)
      sapply(nextPageLink,function(x){x$clickElement()})
      Sys.sleep(3)
      page<-3
    }else{
      linkCss<-paste0('#DataFrm > div.pagination > a:nth-child(',page,')')
      linkCssLink<-remDr$findElements(using='css',linkCss)
      sapply(linkCssLink,function(x){x$clickElement()})
      Sys.sleep(3)
      page<-page+1
    }
  }
  
}
