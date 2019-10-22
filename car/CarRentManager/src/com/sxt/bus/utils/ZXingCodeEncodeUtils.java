package com.sxt.bus.utils;

import java.awt.BasicStroke;
import java.awt.Color;
import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.EnumMap;

import javax.imageio.ImageIO;

import com.google.zxing.BarcodeFormat;
import com.google.zxing.EncodeHintType;
import com.google.zxing.MultiFormatWriter;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.qrcode.decoder.ErrorCorrectionLevel;

/**
 * 生成二维码
 * 
 * @author 老雷
 * 
 */
public class ZXingCodeEncodeUtils {
	// 设置相前的常量
	// 二维码颜色
	private static final int BLACK = 0xFF000000;
	// 二维码背景颜色
	private static final int WHITE = 0xFFFFFFFF;
	// 二维码格式参数
	private static final EnumMap<EncodeHintType, Object> hints = new EnumMap<EncodeHintType, Object>(
			EncodeHintType.class);
	static {
		/*
		 * 二维码的纠错级别(排错率),4个级别： L (7%)、 M (15%)、 Q (25%)、 H (30%)(最高H)
		 * 纠错信息同样存储在二维码中，纠错级别越高，纠错信息占用的空间越多，那么能存储的有用讯息就越少；共有四级； 选择M，扫描速度快。
		 */
		hints.put(EncodeHintType.ERROR_CORRECTION, ErrorCorrectionLevel.H);
		// 二维码边界空白大小 1,2,3,4 (4为默认,最大)
		hints.put(EncodeHintType.MARGIN, 1);
		hints.put(EncodeHintType.CHARACTER_SET, "UTF-8");
	}
	
	/**
	 * 生成一个普通的二维码保存到D盘
	 * @param text  二维码里面存放的内容
	 * @param width  二维的宽度
	 * @param height  二维码的高度
	 * @param outPutPath  输出路径  D:/laolei.gif
	 * @param imageType  image/gif
	 */
	public static void createZxingCodeNormal(String text, int width, int height, String outPutPath, String imageType){
		try {
			//1、生成二维码
			BitMatrix encode = new MultiFormatWriter().encode(text, BarcodeFormat.QR_CODE, width, height, hints);
			//2、获取二维码宽高
			int codeWidth = encode.getWidth();
			int codeHeight = encode.getHeight();
			// 3、将二维码放入缓冲流
			BufferedImage image = new BufferedImage(codeWidth, codeHeight, BufferedImage.TYPE_INT_RGB);
			for (int i = 0; i < codeWidth; i++) {
				for (int j = 0; j < codeHeight; j++) {
					// 4、循环将二维码内容定入图片
					image.setRGB(i, j, encode.get(i, j) ? BLACK : WHITE);
				}
			}
			File outPutImage = new File(outPutPath);
			// 如果图片不存在创建图片
			if (!outPutImage.exists()){
				outPutImage.createNewFile();
			}
			// 5、将二维码写入图片
			ImageIO.write(image, imageType, outPutImage);
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("生成二维码图片失败");
		}
	}
	
	
	/**
	 * 生成一个普通的二维  返回一个图片流
	 * @param text  内容
	 * @param width  图片的宽度
	 * @param height 图片的高度
	 */
	public static BufferedImage createZxingCodeNormal(String text, int width, int height) {
		BufferedImage bufferedImage=null;
		try {
			//1、生成二维码
			BitMatrix encode = new MultiFormatWriter().encode(text, BarcodeFormat.QR_CODE, width, height, hints);
			//2、获取二维码宽高
			int codeWidth = encode.getWidth();
			int codeHeight = encode.getHeight();
			// 3、将二维码放入缓冲流
			bufferedImage = new BufferedImage(codeWidth, codeHeight, BufferedImage.TYPE_INT_RGB);
			for (int i = 0; i < codeWidth; i++) {
				for (int j = 0; j < codeHeight; j++) {
					// 4、循环将二维码内容定入图片
					bufferedImage.setRGB(i, j, encode.get(i, j) ? BLACK : WHITE);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("生成二维码图片失败");
		}
		return bufferedImage;
	}
	
	/**
	 * 生成一个带logo的二维码  返回一个图片流
	 * 原理：先生成一个不带logo的二维码  再向这个二维码里面的中间添加logo的流
	 * @param text  内容
	 * @param width  图片的宽度
	 * @param height 图片的高度
	 * @param logoStream   指中间的logo的流
	 */
	public static BufferedImage createZxingCodeLogo(String text, int width, int height, InputStream logoStream) {
		//1,生成普通的二维码
		BufferedImage image=createZxingCodeNormal(text, width, height);
		if (image == null) {
			System.out.println("二维码生成失败");
			return null;
		}
		//2,把logoStream写到bufferedImage里面
		try {
			// 获取画笔
			Graphics2D g = image.createGraphics();
			if(logoStream==null){
				System.out.println("logo的流为空");
				return image;
			}else{
				// 读取logo图片
				BufferedImage logo = ImageIO.read(logoStream);
				// 设置二维码大小，太大，会覆盖二维码，此处20%  
				//如是logn的宽度和高度大于二维码除以5之后的宽度和高就就使用二维码除以5之后的值作为logo的宽高
				int logoWidth = logo.getWidth(null) > image.getWidth() / 5
						? (image.getWidth()/5) : logo.getWidth(null);
				int logoHeight = logo.getHeight(null) > image.getHeight() / 5
						? (image.getHeight() /5) : logo.getHeight(null);
				// 设置logo图片放置位置
				// long的开始坐标
				int x = (image.getWidth() - logoWidth)/2;
				int y = (image.getHeight() - logoHeight) / 2;
				// 开始合并绘制图片
				g.drawImage(logo, x, y, logoWidth, logoHeight, null);
				//画一个圆角的矩形
				g.drawRoundRect(x, y, logoWidth, logoHeight, 15, 15);
				// logo边框大小
				g.setStroke(new BasicStroke(2));
				// logo边框颜色
				g.setColor(Color.WHITE);
				g.drawRect(x, y, logoWidth, logoHeight);
				g.dispose();
				logo.flush();
				image.flush();
			}
		} catch (Exception e) {
			System.out.println("二维码绘制logo失败");
		}
		return image;
		
	}
	
	
	public static void main(String[] args) throws IOException {
        InputStream logoStream=new FileInputStream("E:\\资料\\相关素材\\美女\\img2.jpg");
		//		createZxingCodeNormal("老雷", 400, 400, "D:/laolei01.gif", "gif");
		BufferedImage bufferedImage = createZxingCodeLogo("老雷", 400, 400,logoStream);
		File file=new File("D:/laolei04.gif");
		file.createNewFile();
		ImageIO.write(bufferedImage, "gif", new FileOutputStream(file));
	}
	

}
