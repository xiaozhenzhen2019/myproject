package com.my.controller;

import com.my.entities.gam;
import com.my.entities.student;
import com.my.entities.users;
import com.my.userService.userService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.management.monitor.GaugeMonitor;
import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;

@Controller
public class usercontroller {
    @Autowired
private userService service;
    @PostMapping("/user/login")
public String select(users user, Map<String,Object> map, HttpSession session){
        users u=service.select(user);
        if(u!=null){
            session.setAttribute("user",u.getUname());
            return "redirect:/main";
        }else {
map.put("err","用户名或密码错误！");
            return "/index";
        }
}
@GetMapping("/show")
    public String selectstu(Map<String,Object> map){
    List<student> list=service.selectstu();
map.put("stu",list);
        return "list";
}
@GetMapping("/stu")
public String add(Map<String,Object> map){
        List<gam> gam=service.selectgam();
        map.put("gam",gam);
        return "add";
}
@PostMapping("/stu")
    public String adds(student stu){
        service.insert(stu);
        return "redirect:/show";
}
@GetMapping("/stu/{sno}")
    public String selectsno(@PathVariable Integer sno, Model model){
        student stu=service.selectsno(sno);
        List<gam> gam=service.selectgam();
    model.addAttribute("gam",gam);
        model.addAttribute("stu",stu);
        return "add";
}
@PutMapping("/stu")
    public String update(student stu){
        service.update(stu);
        return "redirect:/show";
}
@DeleteMapping("/stu/{sno}")
    public String delete(@PathVariable Integer sno)
{
    service.delete(sno);
    return "redirect:/show";
}
}
