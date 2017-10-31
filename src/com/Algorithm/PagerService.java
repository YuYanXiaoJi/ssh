package com.Algorithm;

public class PagerService 
{
	public Pager getPager(String currentPage,String pagerMethod,int totalRows,int pageSize) 
	{
		/*
		 * 1.第一次进入页面  currentPage为空
		 * 2.通过跳转方式请求action
		 * 3.通过点击首页，前一页...方式
		 */
		Pager pager = new Pager(totalRows,pageSize);
		
		if(currentPage != null){
			pager.refresh(Integer.parseInt(currentPage));
		}
		
		if(pagerMethod != null) 
		{
			if (pagerMethod.equals("first")) 
			{
				pager.first();
			} 
			else if (pagerMethod.equals("previous")) 
			{
				pager.previous();
			} 
			else if (pagerMethod.equals("next")) 
			{
				pager.next();
			} 
			else if (pagerMethod.equals("last")) 
			{
				pager.last();
			}
		}
		//若第一次点击进入  直接返回
		return pager;
	}
}
