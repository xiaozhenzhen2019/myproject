package com.sxt.bus.utils;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Random;
import java.util.UUID;


/**
 * 字符串生成工具
 * @author Administrator
 *
 */
public class StrUtils {
	
	
	private static SimpleDateFormat sdf=new SimpleDateFormat("yyyyMMddHHmmssSSSS");
	private static SimpleDateFormat sdf3=new SimpleDateFormat("yyyyMMdd_HHmmss_SSSS");
	private static SimpleDateFormat sdf2=new SimpleDateFormat("yyyy-MM-dd");
	
	/**
	 * 随机数对象
	 */
	private static Random random=new Random();
	
	/**
	 * 第一种使用时间+随机数
	 * @param oldName 文件老名字  saasdfasfdsa.sdfadsf.dsafdsafdsa.fsdaf.jpg
	 */
	public static String createFileNameUseMillisecond(String oldName){
		//得到当前毫秒
		long millisecond=System.currentTimeMillis();
		//生成四位随机数
		int num=random.nextInt(9000)+1000;
		//得到文件的后缀
		String suffix=oldName.substring(oldName.lastIndexOf("."), oldName.length());
		return millisecond+""+num+suffix;
	}
	
	/**
	 * 第二种使用日期+时间+随机数  [推荐使用]
	 * @param args
	 */
	public static String createFileNameUseTime(String oldName){
		//得到当前毫秒
		String prefix=sdf.format(new Date());
		//生成四位随机数
		int num=random.nextInt(9000)+1000;
		//得到文件的后缀
		String suffix=oldName.substring(oldName.lastIndexOf("."), oldName.length());
		return prefix+""+num+suffix;
	}
	
	/**
	 * 使用UUID   UUID在同一个虚拟器下面是不可能重复的
	 * @param args
	 */
	public static String createFileNameUseUUID(String oldName){
		//得到当前毫秒
		String prefix=UUID.randomUUID().toString().replace("-", "");
		//得到文件的后缀
		String suffix=oldName.substring(oldName.lastIndexOf("."), oldName.length());
		return prefix+suffix;
	}
	
	/**
	 * 根据当前时间生成文件夹名
	 * @param args
	 */
	public static String createDirUseCurrentDate(){
		return sdf2.format(new Date());
	}
	
	
	/**
	 * 生成一个带前缀的单号
	 * CZ
	 * JC
	 * @param args
	 */
	public static String createRandomStrUseTimeAndRandom4(String prefix){
		String string = sdf3.format(new Date());
		return prefix+"_"+string+"_"+(random.nextInt(90000)+10000);
	}

	public static void main(String[] args) {
		System.out.println(createRandomStrUseTimeAndRandom4("JC"));
	}
}
