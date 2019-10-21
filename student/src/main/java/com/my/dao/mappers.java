package com.my.dao;

import com.my.entities.gam;
import com.my.entities.student;
import com.my.entities.users;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@Mapper
public interface mappers {
    public users select(users users);
    public List<student> selectStu();
    public List<gam> selectgam();
    public student selectsno(Integer sno);
    public void insert(student stu);
    public void delete(Integer sno);
    public void update(student stu);
}
