package com.sxt.sys.utils.tree;

import com.fasterxml.jackson.annotation.JsonProperty;

/**
 * 和zTree的树型菜单要求的格式进行对应
 * @author Administrator
 *
 */
public class TreeNode {
	private Integer id;
	@JsonProperty("pId")//生成json的时候把pid变成pId
	private Integer pid;
	private String name;
	private Boolean open;
	private Boolean isParent;
	private String href;
	private String icon;
	private String tabIcon;
	
	/**复选框使用
	 */
	private Boolean checked;
	
	
	/**构造方法
	 */
	public TreeNode(Integer id, Integer pid, String name, Boolean open,
			String icon, Boolean checked) {
		super();
		this.id = id;
		this.pid = pid;
		this.name = name;
		this.open = open;
		this.icon = icon;
		this.checked = checked;
	}
	
	
	public TreeNode(Integer id, Integer pid, String name, Boolean open,
			Boolean isParent, String href, String icon, String tabIcon) {
		super();
		this.id = id;
		this.pid = pid;
		this.name = name;
		this.open = open;
		this.isParent = isParent;
		this.href = href;
		this.icon = icon;
		this.tabIcon = tabIcon;
	}
	
	public TreeNode() {
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
		this.name = name;
	}
	public Boolean getOpen() {
		return open;
	}
	public void setOpen(Boolean open) {
		this.open = open;
	}
	public Boolean getIsParent() {
		return isParent;
	}
	public void setIsParent(Boolean isParent) {
		this.isParent = isParent;
	}
	public String getHref() {
		return href;
	}
	public void setHref(String href) {
		this.href = href;
	}
	public String getIcon() {
		return icon;
	}
	public void setIcon(String icon) {
		this.icon = icon;
	}
	public String getTabIcon() {
		return tabIcon;
	}
	public void setTabIcon(String tabIcon) {
		this.tabIcon = tabIcon;
	}

	public Boolean getChecked() {
		return checked;
	}

	public void setChecked(Boolean checked) {
		this.checked = checked;
	}
	
}
