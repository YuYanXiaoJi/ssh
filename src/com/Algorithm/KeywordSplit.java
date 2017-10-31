package com.Algorithm;
/*
 * 分割关键词
 * 去前尾空格  再按中间空格取出关键词
 */
public class KeywordSplit {
	
	public String[]  getKeyWord(String str){
		str=str.trim();
		char kw[]=str.toCharArray();
		String wd="";
		String word[]=new String[100];
		int j=0;
		for(int i=0;i<kw.length;i++)
		{
			if(kw[i]!=' '){
				wd=wd+kw[i];
			}
			else if(!wd.equals("")){
				word[j]=""+wd;
				wd="";
				j++;
			}
		}
		if(!wd.equals(""))word[j]=wd;
		String word1[]=new String[j+1];
		System.arraycopy(word, 0, word1, 0, j+1);
		return word1;
	}
}
