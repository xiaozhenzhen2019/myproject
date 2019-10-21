package com.my.entities;

public class student {
    private  Integer sno;
    private String sname;
    private String sex;
    private String grade;
    private Integer gid;
    private gam gam;
    public Integer getSno() {
        return sno;
    }

    public void setSno(Integer sno) {
        this.sno = sno;
    }

    public String getSname() {
        return sname;
    }

    public void setSname(String sname) {
        this.sname = sname;
    }

    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex;
    }

    public String getGrade() {
        return grade;
    }

    public void setGrade(String grade) {
        this.grade = grade;
    }

    public com.my.entities.gam getGam() {
        return gam;
    }

    public void setGam(com.my.entities.gam gam) {
        this.gam = gam;
    }

    public Integer getGid() {
        return gid;
    }

    public void setGid(Integer gid) {
        this.gid = gid;
    }

    @Override
    public String toString() {
        return "student{" +
                "sno=" + sno +
                ", sname='" + sname + '\'' +
                ", sex='" + sex + '\'' +
                ", grade='" + grade + '\'' +
                ", gid=" + gid +
                ", gam=" + gam +
                '}';
    }
}
