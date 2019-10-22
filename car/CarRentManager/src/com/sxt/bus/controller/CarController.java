package com.sxt.bus.controller;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.sxt.bus.domain.Car;
import com.sxt.bus.service.CarService;
import com.sxt.bus.utils.StrUtils;
import com.sxt.bus.vo.CarVo;
import com.sxt.sys.utils.DataGridView;

@Controller
@RequestMapping("car")
public class CarController {
	@Autowired
	private CarService carService;

	/**
	 * 跳转到business/carManager.jsp
	 */
	@RequestMapping("toCarManager")
	public String toCarManager() {
		return "business/carManager";
	}

	/**
	 * 加载所有的车辆
	 */
	@RequestMapping("loadCars")
	@ResponseBody
	public DataGridView loadCars(CarVo carVo) {
		System.out.println(carVo.toString());
		return this.carService.queryAllCars(carVo);
	}

	/**
	 * 图片上传
	 */
	@RequestMapping("uploadCarImg")
	@ResponseBody
	public String uploadCarImg(MultipartFile mf, HttpSession session) {
		// 得到上传保存的tomcat的路径
		ServletContext context = session.getServletContext();
		String realPath = context.getRealPath("/upload");
		// 得到文件的老名字
		String oldName = mf.getOriginalFilename();// 取到文件的后缀名
		// 得到新名字
		String newName = StrUtils.createFileNameUseTime(oldName);
		// 得到文件夹名
		String folderName = StrUtils.createDirUseCurrentDate();
		// 根据文件夹名构造新的文件夹
		// File folder=new File(realPath, folderName);
		File folder = new File(realPath + "/" + folderName);
		// 判断文件夹是否存在
		if (!folder.exists()) {
			// 创建文件夹
			folder.mkdirs();
		}
		// 在服务器的upload路径下构造一个文件
		File file = new File(folder.getAbsolutePath() + "/" + newName);
		// 上传
		try {
			mf.transferTo(file);
		} catch (IllegalStateException | IOException e) {
			e.printStackTrace();
		}
		return "../upload/"+folderName+"/"+newName;
	}

	/**
	 * 添加车辆
	 */
	@RequestMapping("addCar")
	@ResponseBody
	public Map<String, Object> addCar(CarVo carVo) {
		Map<String, Object> map = new HashMap<>();
		String status = "success";
		String msg = "添加成功";
		try {
			carService.addCar(carVo);
		} catch (Exception e) {
			e.printStackTrace();
			status = "error";
			msg = "添加失败";
		}
		map.put("status", status);
		map.put("msg", msg);
		return map;

	}

	/**
	 * 修改车辆
	 */
	@RequestMapping("updateCar")
	@ResponseBody
	public Map<String, Object> updateCar(CarVo carVo,HttpSession session) {
		Map<String, Object> map = new HashMap<>();
		String status = "success";
		String msg = "修改成功";
		try {
			//如果carVo里面的imagPath=数据库里面的carimg  说明图片没有修改
			Car car=carService.queryCarByCarNumber(carVo.getCarnumber());
			if(carVo.getCarimg()!=null&&!carVo.getCarimg().equals(car.getCarimg())){
				deleteFileOnServer(session, car);
			}
			carService.updateCar(carVo);
		} catch (Exception e) {
			e.printStackTrace();
			status = "error";
			msg = "修改失败";
		}
		map.put("status", status);
		map.put("msg", msg);
		return map;

	}
	/**
	 * 删除图片
	 * @param session
	 * @param car
	 */
	private void deleteFileOnServer(HttpSession session, Car car) {
		String carimg = car.getCarimg();
		if(carimg!=null){
			//说明图片发生的变化 把老图片删除 
			//../upload/2018-06-11/2018061111075205868526.jpg
			String path=session.getServletContext().getRealPath("/");
			String realPath=path+(carimg.substring(3, carimg.length()));
			File file=new File(realPath);
			if(file.exists()){
				file.delete();
				System.out.println("文件删除成功");
			}
		}
	}

	/**
	 * 删除车辆
	 */
	@RequestMapping("deleteCar")
	@ResponseBody
	public Map<String, Object> deleteCar(CarVo carVo,HttpSession session) {
		Map<String, Object> map = new HashMap<>();
		String status = "success";
		String msg = "删除成功";
		try {
			Car car=carService.queryCarByCarNumber(carVo.getCarnumber());
			if(car.getCarimg()!=null){
				deleteFileOnServer(session, car);
			}
			carService.deleteCar(carVo);
		} catch (Exception e) {
			e.printStackTrace();
			status = "error";
			msg = "删除失败";
		}
		map.put("status", status);
		map.put("msg", msg);
		return map;
	}

}
