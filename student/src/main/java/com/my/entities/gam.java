package com.my.entities;

public class gam {
  private Integer id;
  private String gname;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getGname() {
        return gname;
    }

    public void setGname(String gname) {
        this.gname = gname;
    }

    @Override
    public String toString() {
        return "gam{" +
                "id=" + id +
                ", gname='" + gname + '\'' +
                '}';
    }
}
