package com.mynews.newsbigdata;

import java.sql.Connection;
import java.sql.DriverManager;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Value;

public class MariaDBConnectionTest {	
	@Value("${db.driver}")
	private String driver;
	@Value("${db.url}")
	private String URL;
	@Value("${db.userName}")
	private String USER;
	@Value("${db.password}")
	private String PW;
    
    @Test
    public void testConnection() throws Exception {
    	System.out.println(driver);
    	System.out.println(URL);
    	System.out.println(USER);
    	System.out.println(PW);
        Class.forName(driver);
        try {
            Connection con = DriverManager.getConnection(URL, USER, PW);
            //sysout으로 콘솔 로그 출력
            System.out.println(con);
        }
        catch(Exception e) {
            e.printStackTrace();
        }
    }
}
