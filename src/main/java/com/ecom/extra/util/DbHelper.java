package com.ecom.extra.util;

import java.beans.PropertyVetoException;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.sql.DataSource;

import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanListHandler;
import org.apache.commons.dbutils.handlers.MapListHandler;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.ecom.core.AppException;
import com.ecom.extra.Const;
import com.mchange.v2.c3p0.ComboPooledDataSource;

public class DbHelper {
	private static Log log = LogFactory.getLog(DbHelper.class);

	public static Map<String, DataSource> dataSourceMap = new HashMap<String, DataSource>();

	public static Map<String, String> driverClassNameMap = new HashMap<String, String>();
	static {
		driverClassNameMap.put("mysql", "com.mysql.jdbc.Driver");
		driverClassNameMap.put("oracle", "oracle.jdbc.driver.OracleDriver");
		driverClassNameMap.put("sqlserver", "net.sourceforge.jtds.jdbc.Driver");
		driverClassNameMap.put("sybase", "com.sybase.jdbc3.jdbc.SybDriver");
	}

	public static void registDataSource(String code, String databaseType, String connectURI, String username,
			String pswd, int initialSize, int maxtotal, int maxWaitMillis) {

		try {
			ComboPooledDataSource dataSource = new ComboPooledDataSource();
			dataSource.setDriverClass(driverClassNameMap.get(databaseType.toLowerCase()));
			dataSource.setUser(username);
			dataSource.setPassword(pswd);
			dataSource.setJdbcUrl(connectURI.trim());
			dataSource.setInitialPoolSize(initialSize);
			dataSource.setMaxPoolSize(maxtotal);
			dataSource.setIdleConnectionTestPeriod(maxWaitMillis);
			dataSourceMap.put(code, dataSource);
		} catch (PropertyVetoException e) {
			log.error("Register Database connection Error",e);
		}
		log.info("--->regist:" + code);
	}

	public static Map<String, Integer> getDataSourceStats(String code) throws SQLException {
		ComboPooledDataSource bds = (ComboPooledDataSource) dataSourceMap.get(code);
		Map<String, Integer> map = new HashMap<String, Integer>(2);
		if (bds != null) {
			map.put("active_number", bds.getThreadPoolNumActiveThreads());
			map.put("idle_number", bds.getThreadPoolNumIdleThreads());
		}
		return map;
	}

	public static QueryRunner getQueryRunner(String code) throws AppException {
		if (Const.isDebug) {
			code = "test";
		}
		DataSource ds = dataSourceMap.get(code);
		if (ds != null) {
			return new QueryRunner(ds);
		}
		throw new AppException("数据源获取失败:" + code);
	}

	public static List find(String code, String sql, Object... params) throws SQLException, AppException {
		QueryRunner qr = getQueryRunner(code);
		List ls = qr.query(sql, new MapListHandler(), params);
		return ls;
	}

	public static List find(String code, Class resultClass, String sql, Object... params) throws SQLException,
			AppException {
		QueryRunner qr = getQueryRunner(code);
		List ls = qr.query(sql, new BeanListHandler(resultClass), params);
		return ls;
	}

	public static void runSql(String code, String sql, Object... params) throws AppException, SQLException {
		QueryRunner qr = getQueryRunner(code);
		qr.update(sql, params);
	}
	
	public static void batch(String code, String sql, Object[][] params) throws SQLException{
		QueryRunner qr = getQueryRunner(code);
		 qr.batch(sql, params);
	}

	public static void addMonitorMark(String code, String msgId, String msgType ,String searchTime) throws AppException, SQLException {
		String sql = "insert into cos3_monitor_mark(msgid,msgtype,creattime) values(?,?,?)";
		runSql(code, sql, msgId, msgType,searchTime);
	}

	public static String getCamps2DatabaseCode() {
		return Const.isDebug ? "test" : "camps2";
	}

	public static String getEDIDatabaseCode() {
		// return "edi";
		return Const.isDebug ? "test" : "edi";
	}
	
	public static String getOracleEDIGISADatabaseCode() {
		// return "edi";
		return Const.isDebug ? "test" : "oracleEdi_gisa";
	}
	public static String getOracleEDIGISBDatabaseCode() {
        // return "edi";
        return Const.isDebug ? "test" : "oracleEdi_gisb";
    }
	public static String getOracleEDIGISCDatabaseCode() {
        // return "edi";
        return Const.isDebug ? "test" : "oracleEdi_gisc";
    }

	public static void main(String[] args) {
		// -----------------DBUtils连接测试数据源-----------------------------
	  
		/*ComboPooledDataSource dataSource11 = new ComboPooledDataSource();
		try {
		    dataSource11.setDriverClass(driverClassNameMap.get("oracle"));
            dataSource11.setUser("sinogisb");
            dataSource11.setPassword("sinogisb");
            dataSource11.setJdbcUrl("jdbc:oracle:thin:@//172.16.99.249:1581/pilotb");
            String sql1="select * from mft_message where rownum<=10";

			// dataSource11.setDriverClass(driverClassNameMap.get("mysql"));
			// dataSource11.setUser("root");
			// dataSource11.setPassword("root");
			// dataSource11.setJdbcUrl("jdbc:mysql://localhost:3306/coscon?useUnicode=true&characterEncoding=UTF-8&useOldAliasMetadataBehavior=true&autoReconnect=true");
			// sql1 = "select * from cos_flow_business";

			// dataSource11.setDriverClass(driverClassNameMap.get("sybase"));
			// dataSource11.setUser("dbediadm");
			// dataSource11.setPassword("dbediadm");
			// dataSource11.setJdbcUrl("jdbc:sybase:Tds:172.22.224.136:4100/dbedi?charset=utf8&jconnect_version=0");
			// sql1 =
			// "select a.FILE_ID,a.PROCESS_UUID from  EDI_INTER_FILE a WHERE STATUS = 'SUCCESS' and REC_UPD_DT >= convert(varchar, getdate(), 112)";

			QueryRunner qr = new QueryRunner(dataSource11);
			List param = new ArrayList();
			List ls = qr.query(sql1, new ArrayListHandler(), param.toArray());
			if (ls != null) {
				for (int i = 0; i < ls.size(); i++) {
					Object[] o = (Object[]) ls.get(i);
					System.out.println(o[2] + "||" + o[1]);
				}
			}
		} catch (Exception e2) {
		}*/
	}
}
