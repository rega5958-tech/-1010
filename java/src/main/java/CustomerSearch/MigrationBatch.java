package main.java.CustomerSearch;


import java.sql.Connection;
import java.sql.DriverManager;

public class MigrationBatch {

	public static void main(String[] args) {

		System.out.println("バッチ開始");

		
		String url = "jdbc:oracle:thin:@oracle:1521/FREEPDB1";
		String user = "system";
		String password = "Oracle123";
		try (Connection con = DriverManager.getConnection(url, user, password)) {

			con.setAutoCommit(false);
			
			System.out.println("接続成功");
		        
		        MigrationService service =
		                new MigrationService();

		        //トランザクション
		        service.convert(con);


		} catch (Exception e) {

			e.printStackTrace();
		}

		System.out.println("バッチ終了");
		System.exit(0);
	}
}