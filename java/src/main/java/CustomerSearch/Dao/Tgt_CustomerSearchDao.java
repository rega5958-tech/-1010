package main.java.CustomerSearch.Dao;

import java.sql.Timestamp;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import main.java.CustomerSearch.Dto.Src_CustomerDto;
import main.java.CustomerSearch.Dto.Tgt_CustomerSearchDto;

public class Tgt_CustomerSearchDao {

	private static final Logger logger = LoggerFactory.getLogger(Tgt_CustomerSearchDao.class);

	//TGT_CUSTOMER(移行先)の件数確認
	public boolean checkTarget(Connection con) throws SQLException {

		String sql = "SELECT COUNT(*) FROM TGT_CUSTOMER";

		try (PreparedStatement ps = con.prepareStatement(sql);
				ResultSet Res = ps.executeQuery()) {

			Res.next();

			int count = Res.getInt(1);
			

			if (count > 0) {

				logger.info(
						"==================================================" +
						"Migration Info\n" +
						"Table      : SRC_CUSTOMER => TGT_CUSTOMER\n" +
						"データが1件以上入っているため移行処理をスキップします。" +
						"移行処理をする場合は、対象テーブルを空にしてください。" +
						"==================================================");
				
				return false;
			}

			System.out.println("TGT_CUSTOMERは空です");
			
			return true;
		}
	}

	//TGT_CUSTOMER(移行先)のデータ移行
	public void insertCustomer(
			Connection con,
			Src_CustomerDto customer,
	        Integer targetType,
	        Timestamp batchStartTime)
			throws SQLException {

		String sql = "INSERT INTO TGT_CUSTOMER ( " +
				" CUSTOMER_ID, " +
				" CUSTOMER_NAME, " +
				" ADDRESS, " +
				" CUSTOMER_TYPE_ID, " +
				" DELETE_FLAG, " +
				" CREATED_BY, " +
				" CREATED_AT, " +
				" UPDATED_BY, " +
				" UPDATED_AT " +
				") VALUES ( " +
				" ?, ?, ?, ?, ?, ?, ?, ?, ? )" ;

		try (PreparedStatement ps = con.prepareStatement(sql)) {

			ps.setInt(1, customer.getCustomerId());
			ps.setString(2, customer.getCustomerName());
			ps.setString(3, customer.getAddress());
			ps.setInt(4, targetType);
			ps.setInt(5, 0);
			ps.setString(6, "migration_batch");
			ps.setTimestamp(7, batchStartTime);
			ps.setNull(8, Types.VARCHAR);
			ps.setNull(9, Types.TIMESTAMP);
			
			ps.executeUpdate();

		}

	}
}
