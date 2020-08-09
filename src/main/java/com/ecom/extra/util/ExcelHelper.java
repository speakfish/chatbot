package com.ecom.extra.util;

import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.lang3.StringUtils;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.util.StringUtil;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import com.ecom.chatbot.entity.HkAllocateLogic;
import com.ecom.extra.controller.BaseController;
import com.ecom.extra.service.BaseService;
import com.mchange.v2.c3p0.ComboPooledDataSource;


public class ExcelHelper extends BaseController {
	@Resource
    public static BaseService  baseService;
   private static void importReportLogic(QueryRunner qr){
	   String path="C:/Users/long.liu/OneDrive - Wolters Kluwer/Desktop/logic/Allocation_Conditions_for_WorkCollection_MABS24_FRS_HK.xlsx";
	   //String reportName="Form_J";
	   String reportName="MA(BS)24";
	   XSSFSheet sheet =null;
	   XSSFRow row=null;
	   String contentE=null;
	   String contentG=null;
	   FileInputStream fileInputStream=null;
	   XSSFWorkbook sheets=null;
	   String sql=null;
	   try {
		   fileInputStream=new FileInputStream(path);
		 sheets=new XSSFWorkbook(fileInputStream);
		for(int i=0;i<sheets.getNumberOfSheets();i++){
		sheet=sheets.getSheetAt(i);
		int rowNum=sheet.getPhysicalNumberOfRows();
		for(int r=0;r<rowNum;r++){
			row=sheet.getRow(r);
			if(!isRowEmpty(row)){
			contentE=row.getCell(4).toString();
			contentG=row.getCell(6).toString();
			String[] param=new String[]{reportName,contentG,contentE};
				sql="insert into hk_allocate_logic(reportName,logic,cellLogicName) values(?,?,?)";
				qr.update(sql,param);
			}
		}
		}
		
	} catch (Exception e) {
		e.printStackTrace();
	}finally{
		try {
			sheets.close();
			fileInputStream.close();
		} catch (Exception e2) {
			e2.printStackTrace();
		}
		
	}
   }
   public static boolean isRowEmpty(Row row){
	   for(int c=row.getFirstCellNum();c<row.getLastCellNum();c++){
		   Cell cell =row.getCell(c);
		   if(cell!=null&&cell.getCellType()!=Cell.CELL_TYPE_BLANK){
			   return false;
		   }
	   }
	   return true;
   }
   public static ComboPooledDataSource getDataSource(){
		ComboPooledDataSource dataSource11 = new ComboPooledDataSource();
		try {
			dataSource11.setDriverClass("com.mysql.jdbc.Driver");
			dataSource11.setUser("root");
			dataSource11.setPassword("");
			dataSource11.setJdbcUrl("jdbc:mysql://127.0.0.1:3306/chatbot?useUnicode=true&characterEncoding=UTF-8&useOldAliasMetadataBehavior=true&autoReconnect=true");
			 
		}catch(Exception e){
			e.printStackTrace();
		}
		return dataSource11;
	}
  public static void main(String[] args) throws IOException {
	  QueryRunner query=new QueryRunner(getDataSource());
       importReportLogic(query);
    }
}
