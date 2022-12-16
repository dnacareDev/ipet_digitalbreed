package ipet_digitalbreed;

import java.sql.*;

public class IPETDigitalConnDB {

	//String url="jdbc:mysql://112.169.69.112:6613/digitalbreed?autoReconnect=true&useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true&useSSL=false&useUnicode=true&characterEncoding=euckr&zeroDateTimeBehavior=convertToNull";
	String url="jdbc:mysql://182.227.106.53:6613/digitalbreed?autoReconnect=true&useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true&useSSL=false&useUnicode=true&characterEncoding=euckr&zeroDateTimeBehavior=convertToNull";

	String user = "bms";
	String pass = "bms!@#$";

		public Connection conn = null;
        public Statement stmt = null;
		public ResultSet rs = null;
		public Statement stmt1 = null;
		public ResultSet rs1 = null;

	public IPETDigitalConnDB(){
		try {
			Class.forName("com.mysql.cj.jdbc.Driver"); 
			conn = DriverManager.getConnection(url,user,pass);
			conn.setAutoCommit(true);
		}catch(Exception e){
			System.out.println(e);
			e.printStackTrace();
		 } 
	}
	
}
