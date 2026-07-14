package main.java.CustomerSearch.Dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import main.java.CustomerSearch.Dto.Mst_Customer_Type_ConversionDto;

public class Mst_Customer_Type_ConversionDao {

	public List<Mst_Customer_Type_ConversionDto> getCustomerTypeConversionList(Connection con)
			throws SQLException {

		List<Mst_Customer_Type_ConversionDto> list = new ArrayList<>();

		//顧客種別変換マスタ(MST_CUSTOMER_TYPE_CONVERSION)のデータ取得
		String sql = "SELECT " +
				" CONVERSION_ID, " +
				" SOURCE_TYPE, " +
				" TARGET_TYPE, " +
				" DESCRIPTION " +
				"FROM MST_CUSTOMER_TYPE_CONVERSION " +
				"WHERE DELETE_FLAG = 0";

		try (PreparedStatement ps = con.prepareStatement(sql);
				ResultSet Res = ps.executeQuery()) {

			while (Res.next()) {

				Mst_Customer_Type_ConversionDto dto = new Mst_Customer_Type_ConversionDto();

				dto.setConversionId(Res.getInt("CONVERSION_ID"));

				dto.setSourceType(Res.getString("SOURCE_TYPE"));

				dto.setTargetType(Res.getInt("TARGET_TYPE"));

				dto.setDescription(Res.getString("DESCRIPTION"));

				list.add(dto);
			}
		}

		return list;
	}
}
