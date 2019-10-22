package com.sxt.sys.utils.tree;

import java.util.ArrayList;
import java.util.List;


/**
 * 和zTree的树型菜单要求的格式进行对应
 * @author Administrator
 *
 */
public class ComboTreeNode {
	private Integer id;
	private Integer pid;//目地，是去重构json数据时
	private String text;
	private List<ComboTreeNode> children=new ArrayList<>();
	public ComboTreeNode(Integer id, Integer pid, String text) {
		super();
		this.id = id;
		this.pid = pid;
		this.text = text;
	}
	public ComboTreeNode() {
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

	public String getText() {
		return text;
	}

	public void setText(String text) {
		this.text = text;
	}

	public List<ComboTreeNode> getChildren() {
		return children;
	}

	public void setChildren(List<ComboTreeNode> children) {
		this.children = children;
	}
	
	
	
}
