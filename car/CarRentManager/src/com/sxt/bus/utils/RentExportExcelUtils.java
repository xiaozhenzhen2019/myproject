package com.sxt.bus.utils;

import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.net.URLEncoder;
import java.util.Date;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFClientAnchor;
import org.apache.poi.hssf.usermodel.HSSFPatriarch;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.ClientAnchor;
import org.apache.poi.ss.util.CellRangeAddress;

import com.sxt.bus.domain.Customer;
import com.sxt.bus.domain.Rent;

/**
 * 出租单导出工具类
 * 
 * @author Administrator
 * 
 */
public class RentExportExcelUtils extends BaseExcelStyleUitls {

	/**
	 * 导出的主方法
	 * 
	 * @param rent
	 *            出租单的信息
	 * @param customer
	 *            客户信息
	 * @param fileName
	 *            文件名
	 * @param title
	 *            标题
	 * @param response
	 *            响应对象
	 */
	public static void exportRent(Rent rent, Customer customer,
			String fileName, String title, HttpServletResponse response) {
		// 处理文件名 如果不处理，下载下来之后就没有文件名
		try {
			fileName = URLEncoder.encode(fileName, "utf-8");
		} catch (Exception e) {
			e.printStackTrace();
		}
		// 处理文件类型
		response.setContentType("application/x-download");
		// 设置下载的文件名
		response.setHeader("Content-Disposition", "attachment; filename=\""
				+ fileName + "\"");
		// 创建一个工作表
		HSSFWorkbook workbook = new HSSFWorkbook();// 是一个空的，没有sheet的excel
		// 在这个工作表里面创建sheet
		// 创建sheet并取名
		HSSFSheet sheet = workbook.createSheet(title);
		// 设置整个Excel表格的列的默认宽度
		sheet.setDefaultColumnWidth((short) 30);
		sheet.setColumnWidth(1, (short) 50*256);
		// 开始写数据
		int row = 0;// 记录行号
		// 写第一行数据
		// 创建一行
		HSSFRow titleRow = sheet.createRow(row);
		// 合并 是在整个sheet的基础上进行
		CellRangeAddress region1 = new CellRangeAddress(row, row, 0, 3);
		sheet.addMergedRegion(region1);
		// 在这一行里面创建列
		HSSFCell titleRowCell0 = titleRow.createCell(0);
		titleRowCell0.setCellValue(title);
		titleRowCell0.setCellStyle(createTitileStyle(workbook, 30));
		
		row++;
		//第二行
		HSSFRow row2 = sheet.createRow(row);
		row2.setHeight((short)3000);//设置行高  此时行高系统会除以20  最终的高度为150
		HSSFCell row2Cell0 = row2.createCell(0);
		row2Cell0.setCellValue("出租单号:");
		row2Cell0.setCellStyle(createDataStyle(workbook, 14));
		
		HSSFCell row2Cell1 = row2.createCell(1);
		row2Cell1.setCellValue(rent.getRentid());
		row2Cell1.setCellStyle(createDataStyle(workbook, 14));
		
		HSSFCell row2Cell2 = row2.createCell(2);
		row2Cell2.setCellValue("二维码:");
		row2Cell2.setCellStyle(createDataStyle(workbook, 14));
		
		HSSFCell row2Cell3 = row2.createCell(3);
		
		//放二维码
		BufferedImage image=ZXingCodeEncodeUtils.createZxingCodeNormal(rent.getRentid(), 300, 300);
		ByteArrayOutputStream byteArrayOut = new ByteArrayOutputStream();   
		 try {
			 //把图片流写入内存流
			ImageIO.write(image, "jpg", byteArrayOut);
		} catch (IOException e1) {
			e1.printStackTrace();
		} 
		  //画图的顶级管理器，一个sheet只能获取一个（一定要注意这点）  
		 HSSFPatriarch patriarch = sheet.createDrawingPatriarch(); 
		//anchor主要用于设置图片的属性  
		 /**
		  * 参数1：
		  * 参数2：
		  * 参数3：
		  * 参数4：
		  * 参数5：
		  * 参数6：
		  * 参数7：
		  * 参数8：
		  */
        HSSFClientAnchor anchor = new HSSFClientAnchor(0, 0, 0, 255,(short) 3, 1, (short) 4, 1);     
        anchor.setAnchorType(ClientAnchor.AnchorType.DONT_MOVE_AND_RESIZE);  
        patriarch.createPicture(anchor, workbook.addPicture(byteArrayOut.toByteArray(), HSSFWorkbook.PICTURE_TYPE_JPEG));    
		
         row2Cell3.setCellStyle(createDataStyle(workbook, 14));
		
		//第三行
		row++;
		HSSFRow row3 = sheet.createRow(row);
		HSSFCell row3Cell0 = row3.createCell(0);
		row3Cell0.setCellValue("客户姓名:");
		row3Cell0.setCellStyle(createDataStyle(workbook, 14));
		
		HSSFCell row3Cell1 = row3.createCell(1);
		row3Cell1.setCellValue(customer.getCustname());
		row3Cell1.setCellStyle(createDataStyle(workbook, 14));
		
		HSSFCell row3Cell2 = row3.createCell(2);
		row3Cell2.setCellValue("客户身份证号:");
		row3Cell2.setCellStyle(createDataStyle(workbook, 14));
		
		HSSFCell row3Cell3 = row3.createCell(3);
		row3Cell3.setCellValue(rent.getIdentity());
		row3Cell3.setCellStyle(createDataStyle(workbook, 14));
		//第四行
		row++;
		HSSFRow row4 = sheet.createRow(row);
		HSSFCell row4Cell0 = row4.createCell(0);
		row4Cell0.setCellValue("起租时间:");
		row4Cell0.setCellStyle(createDataStyle(workbook, 14));
		
		HSSFCell row4Cell1 = row4.createCell(1);
		row4Cell1.setCellValue(rent.getBegindate().toLocaleString());
		row4Cell1.setCellStyle(createDataStyle(workbook, 14));
		
		HSSFCell row4Cell2 = row4.createCell(2);
		row4Cell2.setCellValue("还车时间:");
		row4Cell2.setCellStyle(createDataStyle(workbook, 14));
		
		HSSFCell row4Cell3 = row4.createCell(3);
		row4Cell3.setCellValue(rent.getReturndate().toLocaleString());
		row4Cell3.setCellStyle(createDataStyle(workbook, 14));
		//第五行
		row++;
		HSSFRow row5 = sheet.createRow(row);
		HSSFCell row5Cell0 = row5.createCell(0);
		row5Cell0.setCellValue("车辆编号");
		row5Cell0.setCellStyle(createDataStyle(workbook, 14));
		
		HSSFCell row5Cell1 = row5.createCell(1);
		row5Cell1.setCellValue(rent.getCarnumber());
		row5Cell1.setCellStyle(createDataStyle(workbook, 14));
		
		HSSFCell row5Cell2 = row5.createCell(2);
		row5Cell2.setCellValue("出租价格");
		row5Cell2.setCellStyle(createDataStyle(workbook, 14));
		
		HSSFCell row5Cell3 = row5.createCell(3);
		row5Cell3.setCellValue(rent.getPrice()+"");
		row5Cell3.setCellStyle(createDataStyle(workbook, 14));
		row++;
		row++;
		
		HSSFRow row7 = sheet.createRow(row);
		HSSFCell row7Cell3 = row7.createCell(2);
		row7Cell3.setCellValue("打印时间:");
		row7Cell3.setCellStyle(createDataStyle(workbook, 14));
		
		HSSFCell row7Cell4 = row7.createCell(3);
		row7Cell4.setCellValue(new Date().toLocaleString());
		row7Cell4.setCellStyle(createDataStyle(workbook, 14));
		
		row++;
		
		HSSFRow row8 = sheet.createRow(row);
		HSSFCell row8Cell3 = row8.createCell(2);
		row8Cell3.setCellValue("操作员:");
		row8Cell3.setCellStyle(createDataStyle(workbook, 14));
		
		HSSFCell row8Cell4 = row8.createCell(3);
		row8Cell4.setCellValue(rent.getOpername());
		row8Cell4.setCellStyle(createDataStyle(workbook, 14));
		
		row++;
		HSSFRow row9 = sheet.createRow(row);
		HSSFCell row9Cell3 = row9.createCell(2);
		row9Cell3.setCellValue("客户签名:");
		row9Cell3.setCellStyle(createDataStyle(workbook, 14));
		
		HSSFCell row9Cell4 = row9.createCell(3);
		row9Cell4.setCellValue("");
		row9Cell4.setCellStyle(createDataStyle(workbook, 14));
		
		try {
			// 把excel写出来
			workbook.write(response.getOutputStream());
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}
