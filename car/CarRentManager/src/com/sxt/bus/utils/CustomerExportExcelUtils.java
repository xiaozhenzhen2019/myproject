package com.sxt.bus.utils;

import java.io.IOException;
import java.net.URLEncoder;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.util.CellRangeAddress;

import com.sxt.bus.domain.Customer;

/**
 * 导出的工具类
 * 
 * @author Administrator
 * 
 */
public class CustomerExportExcelUtils extends BaseExcelStyleUitls{

	/**
	 * 导出客户数据
	 * 
	 * @param list
	 *            客户数据集合
	 * @param resp
	 *            响应对象
	 */
	public static void exportCustomer(List<Customer> list, HttpServletResponse response,
			String fileName,String title) {
		// 处理文件名  如果不处理，下载下来之后就没有文件名
		try {
			fileName = URLEncoder.encode(fileName, "utf-8");
		} catch (Exception e) {
			e.printStackTrace();
		}
		//处理文件类型
		response.setContentType("application/x-download");
		// 设置下载的文件名
		response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\"");
		//创建一个工作表
		HSSFWorkbook workbook = new HSSFWorkbook();//是一个空的，没有sheet的excel
		//在这个工作表里面创建sheet
		//创建sheet并取名
		HSSFSheet sheet = workbook.createSheet(title);
		//设置整个Excel表格的列的默认宽度
		sheet.setDefaultColumnWidth((short) 30);
		//开始写数据
		int row=0;//记录行号
		//写第一行数据
		//创建一行
		HSSFRow titleRow = sheet.createRow(row);
		//合并  是在整个sheet的基础上进行
		CellRangeAddress region1=new CellRangeAddress(row, row, 0, 5);
		sheet.addMergedRegion(region1);
		//在这一行里面创建列
		HSSFCell titleRowCell0 = titleRow.createCell(0);
		titleRowCell0.setCellValue(title);
		titleRowCell0.setCellStyle(createTitileStyle(workbook, 30));
		//写第二行数据
		row++;
		//合并
		CellRangeAddress region2=new CellRangeAddress(row, row, 0, 5);
		sheet.addMergedRegion(region2);
		HSSFRow secoundTitleRow = sheet.createRow(row);
		HSSFCell secoundTitleRowCell0 = secoundTitleRow.createCell(0);
		secoundTitleRowCell0.setCellValue("总条数:"+list.size()+" 导出时间:"+new Date().toLocaleString());
		secoundTitleRowCell0.setCellStyle(createSecoundTitileStyle(workbook, 25));
		//第三行数据
		row++;
		Object[] colunms={"身份证号","客户姓名","客户性别","客户地址","客户电话","客户职位"};
		//创建表头的样式 
		HSSFCellStyle tableTitileStyle = createTableTitileStyle(workbook, 20);
		//创建行
		HSSFRow tableTitleRow = sheet.createRow(row);
		for (int i = 0; i < colunms.length; i++) {
			HSSFCell tableTitileCell = tableTitleRow.createCell(i);
			tableTitileCell.setCellStyle(tableTitileStyle);
			tableTitileCell.setCellValue(colunms[i].toString());
		}
		
		
		HSSFCellStyle dataStyle = createDataStyle(workbook, 16);
		//第四行数据
		for (int i = 0; i < list.size(); i++) {
			Customer c=list.get(i);
			row++;
			//创建行
			HSSFRow dataRow = sheet.createRow(row);
			int cel=0;
			HSSFCell dataCell0 = dataRow.createCell(cel++);
			dataCell0.setCellValue(c.getIdentity());
			dataCell0.setCellStyle(dataStyle);
			
			HSSFCell dataCell1 = dataRow.createCell(cel++);
			dataCell1.setCellValue(c.getCustname());
			dataCell1.setCellStyle(dataStyle);
			
			HSSFCell dataCell2 = dataRow.createCell(cel++);
			dataCell2.setCellValue(c.getSex()==1?"男":"女");
			dataCell2.setCellStyle(dataStyle);
			
			HSSFCell dataCell3 = dataRow.createCell(cel++);
			dataCell3.setCellValue(c.getAddress());
			dataCell3.setCellStyle(dataStyle);
			
			HSSFCell dataCell4 = dataRow.createCell(cel++);
			dataCell4.setCellValue(c.getPhone());
			dataCell4.setCellStyle(dataStyle);
			
			HSSFCell dataCell5 = dataRow.createCell(cel++);
			dataCell5.setCellValue(c.getCareer());
			dataCell5.setCellStyle(dataStyle);
		}
		try {
			//把excel写出来
			workbook.write(response.getOutputStream());
		} catch (IOException e) {
			e.printStackTrace();
		}

	}

	
}
