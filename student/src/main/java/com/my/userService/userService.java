package com.my.userService;


import com.my.dao.mappers;

import com.my.entities.gam;
import com.my.entities.student;
import com.my.entities.users;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Collection;
import java.util.List;

@Service
public class userService {
   @Autowired
    private mappers mappers;
   public users select(users user){
      return mappers.select(user);
   }
public List<student> selectstu(){
       return mappers.selectStu();
}
public List<gam> selectgam(){
       return mappers.selectgam();
}
public void update(student stu){
       mappers.update(stu);
}
public void delete(Integer sno){
       mappers.delete(sno);
}
public void insert(student stu){
       mappers.insert(stu);
}
public student selectsno(Integer sno){
       return mappers.selectsno(sno);
}
}
