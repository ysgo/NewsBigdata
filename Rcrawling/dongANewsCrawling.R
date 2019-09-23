install.packages("RSelenium")
install.packages("rvest")
library(rvest)
library(RSelenium)
library(stringr)


#한국일보
remDr<-remoteDriver(remoteServerAddr = "localhost", port=4445, browserName="chrome")
remDr$open()
remDr$navigate("http://www.donga.com")

politics = NULL
business=NULL
world=NULL
SocialAffairs=NULL

for(categorynb in 2:5){
  menuBtn<-('#header > div > div.header_logo > span.btn_allmenu > span')
  menuBtnLink<-remDr$findElements(using='css',menuBtn)
  sapply(menuBtnLink,function(x){x$clickElement()})
  Sys.sleep(1)
  categorynbBtn<-paste0('#allmenu_layer > div > div.menu_wrap > ul.menu_list.main_menu > li:nth-child(',categorynb,') > a')
  categorynbBtnLink<-remDr$findElements(using='css',categorynbBtn)
  sapply(categorynbBtnLink,function(x){x$clickElement()})
  Sys.sleep(3)
  latestBtn<-('#container > div.conMenu > ul > li:nth-child(1) > a')
  latestBtnLink<-remDr$findElements(using='css',latestBtn)
  sapply(latestBtnLink,function(x){x$clickElement()})
  Sys.sleep(3)
  
  page<-3
  endFlag <- FALSE
  for(repeatnb in 400){#400
    
    for(index in 3:22){ #3:22
      #한페이지 뉴스제목수 /클릭후 제목 날짜 내용 크롤링
      titleaddr<-paste0('#contents > div:nth-child(',index,') > div.rightList > a > span.tit')
      titleLink<-remDr$findElements(using='css',titleaddr)
      sapply(titleLink,function(x){x$clickElement()})
      Sys.sleep(5) #5
      if (length(titleLink)==0){
        endFlag <- TRUE
        break
      }
      
      #제목
      title1<-'#container > div.article_title > h1'
      title1Link<-remDr$findElements(using='css',title1)
      title<-unlist(sapply(title1Link,function(x){x$getElementText()}))
      #날짜
      dateaddr<-'#container > div.article_title > div.title_foot > span:nth-child(2)'
      dateLink<-remDr$findElements(using='css',dateaddr)
      date<-unlist(sapply(dateLink,function(x){x$getElementText()}))
      date<-gsub("입력 ","",date)
    
      #내용
      contentaddr<-'#contents > div.article_view > div.article_txt'
      contentLink<-remDr$findElements(using='css',contentaddr)
      content<-unlist(sapply(contentLink,function(x){x$getElementText()}))
    
      # #이미지파트
      # imgtextaddr<-'#contents > div.article_view > div.article_txt > div.articlePhotoC'
      # imgtextLink<-remDr$findElements(using='css',imgtextaddr)
      # if(length(imgtextLink)!=0){
      #   imgtext<-unlist(sapply(imgtextLink,function(x){x$getElementText()}))
      #   # imgtext <- gsub("\\[","",gsub("]","",imgtext))
      #   # imgtext <- gsub("[()]","",imgtext)
      # 
      #   # imgtext <- gsub("[[©]]","",imgtext)
      # 
      #   # j <- 1
      #   # repeat{
      #   #   content<-str_replace(content,imgtext[j],"")
      #   #
      #   #   if(j==length(imgtext)){
      #   #     break
      #   #   }
      #   #   j <- j+1
      #   # }
      #   }
# 
#         #주요기사링크파트
#         textadaddr<-'#contents > div.article_view > div.article_txt > div.article_relation'
#         textadLink<-remDr$findElements(using='css',textadaddr)
#         textad<-unlist(sapply(textadLink,function(x){x$getElementText()}))
# 
#         # #사진 주석 제외처리
#         # content <- gsub("\\[","",gsub("]","",content))
#         # content<- gsub("[()]","",content)
#         #
# 
#         # print(imgtext)
#         textad <- gsub("\\[","",gsub("]","",textad))
#         textad <- gsub("[()]","",textad)
#         content<-str_replace(content,textad,"")

        
        if(categorynb==2){
          politics<-c(politics,title)
          politics<-c(politics,date)
          politics<-c(politics,content)
        }else if(categorynb==3){
          business<-c(business,title)
          business<-c(business,date)
          business<-c(business,content)
        }else if(categorynb==4){
          world<-c(world,title)
          world<-c(world,date)
          world<-c(world,content)
        }else if(categorynb==5){
          SocialAffairs<-c(SocialAffairs,title)
          SocialAffairs<-c(SocialAffairs,date)
          SocialAffairs<-c(SocialAffairs,content)
        }
        
        print(title)
        remDr$goBack()
        Sys.sleep(5)
      }
      if(endFlag)
        break
      
      if(page==12){
        nextPageCSS <-('#contents > div.page > a.right.on')
        nextPageLink<-remDr$findElements(using='css',nextPageCSS)
        sapply(nextPageLink,function(x){x$clickElement()})
        Sys.sleep(4)
        page<-3
      }else{
        linkCss<-paste0('#contents > div.page > a:nth-child(',page,')')
        linkCssLink<-remDr$findElements(using='css',linkCss)
        sapply(linkCssLink,function(x){x$clickElement()})
        Sys.sleep(4)
        page<-page+1
      }
    }
  }
  
  # write.csv(politics,"politics.csv")
  