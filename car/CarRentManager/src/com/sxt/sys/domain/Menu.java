package com.sxt.sys.domain;

public class Menu {
    private Integer id;

    private Integer pid;

    private String name;

    private String href;

    private Integer open;

    private Integer parent;

    private String target;

    private String icon;

    private String tabicon;

    private Integer available;

    public Menu() {
	}
    
    public Menu(Integer id, Integer pid, String name, String href,
			Integer open, Integer parent, String target, String icon,
			String tabicon, Integer available) {
		super();
		this.id = id;
		this.pid = pid;
		this.name = name;
		this.href = href;
		this.open = open;
		this.parent = parent;
		this.target = target;
		this.icon = icon;
		this.tabicon = tabicon;
		this.available = available;
	}

	public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getPid() {
        return pid;
    }

    public void setPid(Integer pid) {
        this.pid = pid;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name == null ? null : name.trim();
    }

    public String getHref() {
        return href;
    }

    public void setHref(String href) {
        this.href = href == null ? null : href.trim();
    }

    public Integer getOpen() {
        return open;
    }

    public void setOpen(Integer open) {
        this.open = open;
    }

    public Integer getParent() {
        return parent;
    }

    public void setParent(Integer parent) {
        this.parent = parent;
    }

    public String getTarget() {
        return target;
    }

    public void setTarget(String target) {
        this.target = target == null ? null : target.trim();
    }

    public String getIcon() {
        return icon;
    }

    public void setIcon(String icon) {
        this.icon = icon == null ? null : icon.trim();
    }

    public String getTabicon() {
        return tabicon;
    }

    public void setTabicon(String tabicon) {
        this.tabicon = tabicon == null ? null : tabicon.trim();
    }

    public Integer getAvailable() {
        return available;
    }

    public void setAvailable(Integer available) {
        this.available = available;
    }
}