package com.mynews.newsbigdata;

import org.rosuda.REngine.REXP;
import org.rosuda.REngine.REXPMismatchException;
import org.rosuda.REngine.RList;
import org.rosuda.REngine.Rserve.RConnection;
import org.rosuda.REngine.Rserve.RserveException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import service.NewsService2;
import vo.TestVO;

@Controller
public class RJavaConnectController {
	@Autowired
	private NewsService2 service;

	@RequestMapping("/rjavatest.do")
	public String rjavaConnect() {
//    	String driver = "org.mariadb.jdbc.Driver";
//    	Connection con;
//    	PreparedStatement pstmt;
//    	ResultSet rs;
		try {
//            Class.forName(driver);
//            con = DriverManager.getConnection(
//                    "jdbc:mariadb://70.12.113.176:3306/newsbigdata",
//                    "news",
//                    "bigdata");
//            
//            if( con != null ) {
//                System.out.println("DB 접속성공");
//            }
//            System.out.println("test");
			RConnection rc = new RConnection();
			REXP x = rc.eval("imsi<-source('C:/Rstudy/bigkindsCrawling/bigkindsRJava.R');imsi$value");
			RList list = x.asList();

			String[] newsname = list.at("newsname").asStrings();
			String[] title = list.at("title").asStrings();
			String[] category = list.at("category").asStrings();
			String[] date = list.at("date").asStrings();
			String[] url = list.at("url").asStrings();
			String[] content = list.at("content").asStrings();
			TestVO vo = new TestVO();
			for (int i = 0; i < newsname.length; i++) {
				vo.setNewsname(newsname[i]);
				vo.setTitle(title[i]);
				vo.setCategory(category[i]);
				vo.setDate(date[i]);
				vo.setUrl(url[i]);
				vo.setContent(content[i]);
				if (service.insertNews(vo) != 1) {
					System.out.println("데이터 삽입 실패");
				}
			}

//        } catch (ClassNotFoundException e) { 
//            System.out.println("연결실 패");
//        } catch (SQLException e) {
//            System.out.println("DB 수행오류");
		} catch (RserveException e) {
			System.out.println("Rserve 오류");
		} catch (REXPMismatchException e) {
			System.out.println("R 문법 오류");
		}
		return "home";
	}

}
