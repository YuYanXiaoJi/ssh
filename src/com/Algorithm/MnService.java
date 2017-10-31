package com.Algorithm;

import java.util.LinkedList;
import java.util.List;

public class MnService {
	
	
	@SuppressWarnings("unused")
	private String []back;
	private Mn mn=new Mn();
	private List<String[]> re=new LinkedList<String[]>();

	public  List<String[]> getCombine(String str[],int count){
		
		mn.Combine(str, count, 0," ");//完成取数操作
		
		/* 
		 * 将List<String>例如  list(0)=[1 3 4]
		 * 变成List<String[]> list(0)= [ [1] [3] [4] ]  方便取出1,3,4
		 * 
		 */
		
		List<String> temp=mn.getTemp();
		
		String s[]=new String[temp.size()];
		
		for(int i=0;i<temp.size();i++){
			s[i]=temp.get(i).toString();
		}
		
		back = new String[temp.size()];
	
		for(int z=0;z<s.length;z++){
			String u=s[z].toString().trim();
			String back[]=u.split("\\s+");
			re.add(back);
		}
		
		return re;
	}
}
