package com.my.entities;

public class users {
    private Integer id;
    private String uname;
    private Integer pwd;

    public String getUname() {
        return uname;
    }

    public void setUname(String uname) {
        this.uname = uname;
    }

    public Integer getPwd() {
        return pwd;
    }

    public void setPwd(Integer pwd) {
        this.pwd = pwd;
    }

    @Override
    public String toString() {
        return "users{" +
                "uname='" + uname + '\'' +
                ", pwd=" + pwd +
                '}';
    }
}
