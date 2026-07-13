package main.java.CustomerSearch.Dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class Tgt_CustomerSearchDao {

	 String sql = "SELECT COUNT(*) FROM TGT_CUSTOMER";
	 
	 try (PreparedStatement ps = .prepareStatement(sql);
	         ResultSet rs = ps.executeQuery()) {
		 
		 rs.next();
		 
		 
		 
	 }
}
}
