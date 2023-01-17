package org.zerock.web;

import java.sql.Connection;
import java.sql.DriverManager;

import org.junit.Test;

public class MYSQLConnectionTest {
	private static final String Driver = "com.mysql.cj.jdbc.Driver";
	
	private static final String URL = "jdbc:mysql://127.0.0.1:3306/book_ex?useSSL=false&allowPublicKeyRetrieval=true&serverTimezoneUTC";
	
	@Test
	
	public void testConnection() throws Exception{
		
		Class.forName(Driver);
		
		try(Connection con = DriverManager.getConnection(URL, "zerock", "zerock")){
			System.out.println(con);
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
}
