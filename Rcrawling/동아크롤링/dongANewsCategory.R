install.packages("RSelenium")
install.packages("rvest")
library(rvest)
library(RSelenium)
library(stringr)


#동아일보
remDr<-remoteDriver(remoteServerAddr = "localhost", port=4445, browserName="chrome")
remDr$open()
remDr$navigate("http://www.donga.com")

# politics = NULL
# business=NULL
# world=NULL
# SocialAffairs=NULL


title=NULL
date=NULL
content=NULL

#메뉴클릭
menuBtn<-('#header > div > div.header_logo > span.btn_allmenu > span')
menuBtnLink<-remDr$findElements(using='css',menuBtn)
sapply(menuBtnLink,function(x){x$clickElement()})
Sys.sleep(1)

#정치
categorynbBtn<-('#allmenu_layer > div > div.menu_wrap > ul.menu_list.main_menu > li:nth-child(2) > a')
categorynbBtnLink<-remDr$findElements(using='css',categorynbBtn)
sapply(categorynbBtnLink,function(x){x$clickElement()})
Sys.sleep(3)
latestBtn<-('#container > div.conMenu > ul > li:nth-child(1) > a')
latestBtnLink<-remDr$findElements(using='css',latestBtn)
sapply(latestBtnLink,function(x){x$clickElement()})
Sys.sleep(3)

page<-3
endFlag <- FALSE
for(repeatnb in 1:5){#400

  titleaddr<-('#contents > div.page > a:nth-child(5)')
  titleLink<-remDr$findElements(using='css',titleaddr)
  sapply(titleLink,function(x){x$clickElement()})

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
    title3<-unlist(sapply(title1Link,function(x){x$getElementText()}))
    #날짜
    dateaddr<-'#container > div.article_title > div.title_foot > span:nth-child(2)'
    dateLink<-remDr$findElements(using='css',dateaddr)
    date3<-unlist(sapply(dateLink,function(x){x$getElementText()}))
    date3<-gsub("입력 ","",date3)
    
    #내용
    contentaddr<-'#contents > div.article_view > div.article_txt'
    contentLink<-remDr$findElements(using='css',contentaddr)
    content3<-unlist(sapply(contentLink,function(x){x$getElementText()}))
    
    # #사진 일때,. 슬라이드일때
    # imgtextaddr<-'#contents > div.article_view > div.article_txt > div.articlePhotoC'
    # imgtextLink<-remDr$findElements(using='css',imgtextaddr)
    # 
    # imgtextaddrs<-'#contents > div.article_view > div.article_txt > div.articlePhoto_slide'
    # imgtextLinks<-remDr$findElements(using='css',imgtextaddrs)
    # 
    # http://www.donga.com/news/List/Politics/article/all/20190924/97561635/1
    # 
    # if(length(imgtextLink)>=0){
      # imgtext<-unlist(sapply(imgtextLink,function(x){x$getElementText()}))
      # 
      # x<-imgtext[2]
      # gsub("(","\\[(]",x)
    # }else if(length(imgtextLinks)>=0){
    #   imgtextslide<-unlist(sapply(imgtextLinks,function(x){x$getElementText()}))
    # }
    # imgtext<-gsub("[()]","",imgtext)
    # 
    # 
    # content3<-str_replace(pattern=imgtext,replacement = "",content3)
    # 
    # split(a,content3)
    # 
    # a<-str_sub(imgtext,start=1,end=-1)
    # 
    # content3<-gsub(pattern = "^.*?\\n\\n", replacement = "", content3)
    # content3<-str_extract(pattern = "^.*?\\n\\n", replacement = "", content3)
    # 
    # imgtext<-gsub(pattern = "\\(", replacement = "\\\\(", imgtext)
    # 
    # a<-gsub(pattern =" © ", replacement = "", a)
    # gsub(pattern ="[[:punct:]]", replacement = "", a)
    # a<-imgtext[2]
    # a<-substr(a,1,37)
    # gsub("©","",a)
    # gsub(pattern = "^.*?\\n\\n\\n", replacement = "", content3)
    # 
    # j <- 1
    # repeat{
    #   content3<-gsub(pattern = "^.*?\\n\\n", replacement = "", content3)
    #   
    #   if(j==length(imgtext)){
    #     break
    #   }
    #   j <- j+1
    # }
    
    # #주요기사링크파트
    # textadaddr<-'#contents > div.article_view > div.article_txt > div.article_relation'
    # textadLink<-remDr$findElements(using='css',textadaddr)
    # textad<-unlist(sapply(textadLink,function(x){x$getElementText()}))
    # 
    # content3<-gsub("[()]","",content3)
    # str_match(content3,textad)
    # content3<-str_replace(pattern=textad,replacement = "",content3)
    # content3<-sub(pattern = textad,replacement = "",content3)
    
    
    
    # politics<-c(politics,title3)
    # politics<-c(politics,date3)
    # politics<-c(politics,content3)
    title<-c(title,paste0(title3,"#"))
    date<-c(date,paste0(date3,"#"))
    content<-c(content,paste0(content3,"^"))
    
    
    print(title3)
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
dfpoliticsUTF<-data.frame(title,date,content)
write.csv(dfpoliticsUTF,"dfpoliticsUTF.csv",row.names=FALSE,fileEncoding = "UTF-8")

str(dfpolitics)
dfpolitics$content[2]


#경제

#메뉴클릭
menuBtn<-('#header > div > div.header_logo > span.btn_allmenu > span')
menuBtnLink<-remDr$findElements(using='css',menuBtn)
sapply(menuBtnLink,function(x){x$clickElement()})
Sys.sleep(1)

categorynbBtn<-('#allmenu_layer > div > div.menu_wrap > ul.menu_list.main_menu > li:nth-child(3) > a')
categorynbBtnLink<-remDr$findElements(using='css',categorynbBtn)
sapply(categorynbBtnLink,function(x){x$clickElement()})
Sys.sleep(3)
latestBtn<-('#container > div.conMenu > ul > li:nth-child(1) > a')
latestBtnLink<-remDr$findElements(using='css',latestBtn)
sapply(latestBtnLink,function(x){x$clickElement()})
Sys.sleep(3)

page<-3
endFlag <- FALSE
for(repeatnb in 1:5){#400
  
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
    title3<-unlist(sapply(title1Link,function(x){x$getElementText()}))
    #날짜
    dateaddr<-'#container > div.article_title > div.title_foot > span:nth-child(2)'
    dateLink<-remDr$findElements(using='css',dateaddr)
    date3<-unlist(sapply(dateLink,function(x){x$getElementText()}))
    date3<-gsub("입력 ","",date3)
    
    #내용
    contentaddr<-'#contents > div.article_view > div.article_txt'
    contentLink<-remDr$findElements(using='css',contentaddr)
    content3<-unlist(sapply(contentLink,function(x){x$getElementText()}))
    
    # business<-c(business,title3)
    # business<-c(business,date3)
    # business<-c(business,content3)
    
    title<-c(title,title3)
    date<-c(date,date3)
    content<-c(content,content3)
    
    print(title3)
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
dfpoli<-data.frame(title,date,content)
write.csv(business,"business.csv",row.names=FALSE)


#국제

#메뉴클릭
menuBtn<-('#header > div > div.header_logo > span.btn_allmenu > span')
menuBtnLink<-remDr$findElements(using='css',menuBtn)
sapply(menuBtnLink,function(x){x$clickElement()})
Sys.sleep(1)

categorynbBtn<-('#allmenu_layer > div > div.menu_wrap > ul.menu_list.main_menu > li:nth-child(4) > a')
categorynbBtnLink<-remDr$findElements(using='css',categorynbBtn)
sapply(categorynbBtnLink,function(x){x$clickElement()})
Sys.sleep(3)
latestBtn<-('#container > div.conMenu > ul > li:nth-child(1) > a')
latestBtnLink<-remDr$findElements(using='css',latestBtn)
sapply(latestBtnLink,function(x){x$clickElement()})
Sys.sleep(3)

page<-3
endFlag <- FALSE
for(repeatnb in 1:5){#400
  
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
    title3<-unlist(sapply(title1Link,function(x){x$getElementText()}))
    #날짜
    dateaddr<-'#container > div.article_title > div.title_foot > span:nth-child(2)'
    dateLink<-remDr$findElements(using='css',dateaddr)
    date3<-unlist(sapply(dateLink,function(x){x$getElementText()}))
    date3<-gsub("입력 ","",date3)
    
    #내용
    contentaddr<-'#contents > div.article_view > div.article_txt'
    contentLink<-remDr$findElements(using='css',contentaddr)
    content3<-unlist(sapply(contentLink,function(x){x$getElementText()}))
    
    # world<-c(world,title3)
    # world<-c(world,date3)
    # world<-c(world,content3)
    
    title<-c(title,title3)
    date<-c(date,date3)
    content<-c(content,content3)
    
    print(title3)
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
dfpoli<-data.frame(title,date,content)
write.csv(world,"world.csv",row.names=FALSE)


#사회

#메뉴클릭
menuBtn<-('#header > div > div.header_logo > span.btn_allmenu > span')
menuBtnLink<-remDr$findElements(using='css',menuBtn)
sapply(menuBtnLink,function(x){x$clickElement()})
Sys.sleep(1)

categorynbBtn<-('#allmenu_layer > div > div.menu_wrap > ul.menu_list.main_menu > li:nth-child(5) > a')
categorynbBtnLink<-remDr$findElements(using='css',categorynbBtn)
sapply(categorynbBtnLink,function(x){x$clickElement()})
Sys.sleep(3)
latestBtn<-('#container > div.conMenu > ul > li:nth-child(1) > a')
latestBtnLink<-remDr$findElements(using='css',latestBtn)
sapply(latestBtnLink,function(x){x$clickElement()})
Sys.sleep(3)

page<-3
endFlag <- FALSE
for(repeatnb in 1:5){#400
  
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
    title3<-unlist(sapply(title1Link,function(x){x$getElementText()}))
    #날짜
    dateaddr<-'#container > div.article_title > div.title_foot > span:nth-child(2)'
    dateLink<-remDr$findElements(using='css',dateaddr)
    date3<-unlist(sapply(dateLink,function(x){x$getElementText()}))
    date3<-gsub("입력 ","",date3)
    
    #내용
    contentaddr<-'#contents > div.article_view > div.article_txt'
    contentLink<-remDr$findElements(using='css',contentaddr)
    content3<-unlist(sapply(contentLink,function(x){x$getElementText()}))
    
    # SocialAffairs<-c(SocialAffairs,title3)
    # SocialAffairs<-c(SocialAffairs,date3)
    # SocialAffairs<-c(SocialAffairs,content3)
    
    title<-c(title,title3)
    date<-c(date,date3)
    content<-c(content,content3)
    
    print(title3)
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

dfpoli<-data.frame(title,date,content)
write.csv(SocialAffairs,"SocialAffairs.csv",row.names=FALSE)





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
#   #   content3<-str_replace(content3,imgtext[j],"")
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
#         # content3 <- gsub("\\[","",gsub("]","",content3))
#         # content3<- gsub("[()]","",content3)
#         #
# 
#         # print(imgtext)
#         textad <- gsub("\\[","",gsub("]","",textad))
#         textad <- gsub("[()]","",textad)
#         content3<-str_replace(content3,textad,"")


# if(categorynb==2){
#   
# }else if(categorynb==3){
# 
# }else if(categorynb==4){
# 
# }else if(categorynb==5){
# 
# }
# 
