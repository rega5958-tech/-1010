package main.java.CustomerSearch;

import java.sql.Connection;
import java.sql.DriverManager;

public class MigrationBatch {

	public static void main(String[] args) {

		System.out.println("バッチ開始");

		//ALLと単体引数の同時記載実行対策
		boolean hasAll = false;

		for (String target : args) {
			if ("ALL".equals(target)) {
				hasAll = true;
				break;
			}
		}

		if (hasAll && args.length > 1) {
			System.out.println(
					"指定が不正です。ALLと同時にテーブル指定はできません。");
			return;
		}

		//未入力時のALL選択処理
		if (args.length == 0) {
			args = new String[] { "ALL" };
		}

		for (String argstarget : args) {

			switch (argstarget) {

			case "ALL":
				System.out.println("全移行");
				break;

			case "SRC_CUSTOMER":
				System.out.println("SRC_CUSTOMER移行");
				break;

			default:
				System.out.println("不正な引数：" + argstarget);
				return;
			}
		}

		//DB接続
		String url = "jdbc:oracle:thin:@oracle:1521/FREEPDB1";
		String user = "system";
		String password = "Oracle123";
		try (Connection con = DriverManager.getConnection(url, user, password)) {

			con.setAutoCommit(false);

			System.out.println("接続成功");

			MigrationService service = new MigrationService();

			service.convert(con);

		} catch (Exception e) {

			e.printStackTrace();
		}

		System.out.println("バッチ終了");
		System.exit(0);
	}
}