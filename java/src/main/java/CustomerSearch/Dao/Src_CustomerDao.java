package main.java.CustomerSearch.Dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import main.java.CustomerSearch.Dto.Src_CustomerDto;

public class Src_CustomerDao {

	public List<Src_CustomerDto> getCustomerList(Connection con, int offset, int limit) throws SQLException {

		List<Src_CustomerDto> customerList = new ArrayList<>();

		//SRC_CUSTOMER(移行元)データ一覧取得
		String sql = "SELECT " +
				" CUSTOMER_ID, " +
				" CUSTOMER_NAME, " +
				" ADDRESS, " +
				" CUSTOMER_TYPE_ID " +
				"FROM SRC_CUSTOMER " +
				"WHERE DELETE_FLAG = 0 " +
				"ORDER BY CUSTOMER_ID " +
				"FETCH FIRST 1 ROW ONLY";
		//"OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

		try (PreparedStatement ps = con.prepareStatement(sql)) {
			/*ps.setInt(1, offset);
			ps.setInt(2, limit);*/
			try (ResultSet Res = ps.executeQuery()) {

				while (Res.next()) {

					Src_CustomerDto dto = new Src_CustomerDto();

					dto.setCustomerId(Res.getInt("CUSTOMER_ID"));
					dto.setCustomerName(Res.getString("CUSTOMER_NAME"));
					dto.setAddress(Res.getString("ADDRESS"));
					dto.setCustomerTypeId(Res.getString("CUSTOMER_TYPE_ID"));

					customerList.add(dto);
				}
			}
			return customerList;
		}
	}
}
