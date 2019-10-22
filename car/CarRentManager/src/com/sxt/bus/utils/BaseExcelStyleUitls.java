package com.sxt.bus.utils;

import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.VerticalAlignment;

public class BaseExcelStyleUitls {
	/**
	 * 提取表格头的样式
	 * 
	 * @param workbook
	 * @param fontSize
	 * @return
	 */
	protected static HSSFCellStyle createTitileStyle(HSSFWorkbook workbook,
			int fontSize) {
		HSSFCellStyle style = workbook.createCellStyle();
		style.setAlignment(HorizontalAlignment.CENTER);// 设置水平居中
		style.setVerticalAlignment(VerticalAlignment.CENTER);// 设置垂直居中
		// 创建一个字体样式
		HSSFFont font = workbook.createFont();
		font.setFontHeightInPoints((short) fontSize);
		font.setBold(true);// 设置字体样式 如加粗，斜体 等
		font.setFontName("华文彩云");
		style.setFont(font);
		return style;
	}

	/**
	 * 提取表格小标题数据的样式
	 * 
	 * @param workbook
	 * @param fontSize
	 * @return
	 */
	protected static HSSFCellStyle createSecoundTitileStyle(
			HSSFWorkbook workbook, int fontSize) {
		HSSFCellStyle style = workbook.createCellStyle();
		style.setAlignment(HorizontalAlignment.CENTER);// 设置水平居中
		style.setVerticalAlignment(VerticalAlignment.CENTER);// 设置垂直居中
		// 创建一个字体样式
		HSSFFont font = workbook.createFont();
		font.setFontHeightInPoints((short) fontSize);
		font.setBold(true);// 设置字体样式 如加粗，斜体 等
		font.setFontName("黑体");
		style.setFont(font);
		return style;
	}

	/**
	 * 提取表格表头数据的样式
	 * 
	 * @param workbook
	 * @param fontSize
	 * @return
	 */
	protected static HSSFCellStyle createTableTitileStyle(HSSFWorkbook workbook,
			int fontSize) {
		HSSFCellStyle style = workbook.createCellStyle();
		style.setAlignment(HorizontalAlignment.CENTER);// 设置水平居中
		style.setVerticalAlignment(VerticalAlignment.CENTER);// 设置垂直居中
		// 创建一个字体样式
		HSSFFont font = workbook.createFont();
		font.setFontHeightInPoints((short) fontSize);
		font.setBold(true);// 设置字体样式 如加粗，斜体 等
		font.setFontName("华文行楷");
		style.setFont(font);
		return style;
	}

	/**
	 * 提取表格数据的样式
	 * 
	 * @param workbook
	 * @param fontSize
	 * @return
	 */
	protected static HSSFCellStyle createDataStyle(HSSFWorkbook workbook,
			int fontSize) {
		HSSFCellStyle style = workbook.createCellStyle();
		style.setAlignment(HorizontalAlignment.CENTER);// 设置水平居中
		style.setVerticalAlignment(VerticalAlignment.CENTER);// 设置垂直居中
		// 创建一个字体样式
		HSSFFont font = workbook.createFont();
		font.setFontHeightInPoints((short) fontSize);
		style.setFont(font);
		return style;
	}

}
