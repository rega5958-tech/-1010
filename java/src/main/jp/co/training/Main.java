package main.jp.co.training;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Main {

    public static void main(String[] args) {

        String url = "jdbc:oracle:thin:@oracle:1521/FREEPDB1";
        String user = "system";
        String password = "Oracle123";

        try (Connection con = DriverManager.getConnection(url, user, password)) {
            System.out.println("接続成功！");
            System.out.println(con);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
