package main.java.CustomerSearch;

import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.List;

import main.java.CustomerSearch.Dto.Mst_Customer_Type_ConversionDto;
import main.java.CustomerSearch.Dto.Src_CustomerDto;
import main.java.CustomerSearch.Dao.Mst_Customer_Type_ConversionDao;
import main.java.CustomerSearch.Dao.Src_CustomerDao;
import main.java.CustomerSearch.Dao.Tgt_CustomerSearchDao;

public class MigrationService {

	Timestamp batchStartTime = new Timestamp(System.currentTimeMillis());

	public void convert(Connection con) throws SQLException {

		//件数確認

		Tgt_CustomerSearchDao migration = new Tgt_CustomerSearchDao();

		boolean canMigration = migration.checkTarget(con);

		if (!canMigration) {
			return;
		}

		//開始ログ

		System.out.println("==================================================");
		System.out.println("Migration Start");
		System.out.println("Table      : SRC_CUSTOMER => TGT_CUSTOMER");
		System.out.println("Start Time : " + batchStartTime);
		System.out.println("==================================================");

		//変換マスタ取得

		Mst_Customer_Type_ConversionDao conversionDao = new Mst_Customer_Type_ConversionDao();

		List<Mst_Customer_Type_ConversionDto> conversionList = conversionDao.getCustomerTypeConversionList(con);

		//SRC_CUSTOMER取得(1000件毎に表示)

		int offset = 0;
		int limit = 1000;

		Src_CustomerDao srcDao = new Src_CustomerDao();

		while (true) {

			List<Src_CustomerDto> customerList = srcDao.getCustomerList(con, offset, limit);

			System.out.println("取得件数=" + customerList.size());

			if (customerList.isEmpty()) {
				break;
			}

			//変換マスタテーブル、Src_CustomerでのCUSTOMER_TYPE_ID値変換

			try {

				for (Src_CustomerDto customer : customerList) {

					Integer targetType = null;

					for (Mst_Customer_Type_ConversionDto conversion : conversionList) {

						if (conversion.getSourceType().equals(customer.getCustomerTypeId())) {

							targetType = conversion.getTargetType();

							break;
						}
					}

					if (targetType == null) {

						System.out.println(
								"変換エラー CUSTOMER_ID="
										+ customer.getCustomerId()
										+ " CUSTOMER_TYPE_ID="
										+ customer.getCustomerTypeId());

						continue;
					}

					System.out.println(
							"変換成功 CUSTOMER_ID="
									+ customer.getCustomerId()
									+ " : "
									+ customer.getCustomerTypeId()
									+ " → "
									+ targetType);
					// INSERT
					migration.insertCustomer(
							con,
							customer,
							targetType,
							batchStartTime);
					
					System.out.println("INSERT処理完了");

				}

				// 1000件単位でコミット
				//con.commit();
				con.rollback();
			}

			catch (Exception e) {

				con.rollback();

				throw e;
			}

			offset += limit;
			//TGT_CUSTOMER登録

			//終了ログ

		}
	}
}
