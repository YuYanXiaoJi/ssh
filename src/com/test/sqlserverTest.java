package com.test;



import javax.sql.DataSource;

import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.jdbc.core.JdbcTemplate;

public class sqlserverTest {
	
	private ApplicationContext ac = new ClassPathXmlApplicationContext("applicationContext.xml");
	
	
	@Test
	public void test() {
		// 检测数据源 是否配置成功
		DataSource ds = (DataSource) ac.getBean("sqlserver");
		System.out.println(ds);
		 
	}

}
