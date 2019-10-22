package com.sxt.sys.utils.tree;

import java.util.ArrayList;
import java.util.List;

/**
 * 把普通的List<ComboTreeNode>转成有层级结构的json集合
 * @Title: TreeBuilder
 * @author 老雷
 * 
 * @date 2018年4月28日 下午3:30:35
 */
public class ComboTreeBuilder {
	 /** 
     * 两层循环实现建树 
     * @param treeNodes 传入的树节点列表 
     * @param topNodeId  屏蔽顶层节点
     * @return 
     */  
    public static List<ComboTreeNode> bulid(List<ComboTreeNode> treeNodes,Integer topNodeId) {  
        List<ComboTreeNode> trees = new ArrayList<ComboTreeNode>();  
        for (ComboTreeNode treeNode : treeNodes) {  
        	//处理顶层节点
            if (topNodeId==treeNode.getPid()) {  
                trees.add(treeNode);  
            }  
            for (ComboTreeNode it : treeNodes) {  
                if (it.getPid() == treeNode.getId()) { 
                	/*if(treeNode.getChildren()==null){
                		treeNode.setChildren(new ArrayList<ComboTreeNode>());
                	}*/
                    treeNode.getChildren().add(it);  
                }  
            }  
        }  
        return trees;  
    }  
  
  
}
