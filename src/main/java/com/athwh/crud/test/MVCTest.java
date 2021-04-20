package com.athwh.crud.test;

import com.athwh.crud.bean.Employee;
import com.github.pagehelper.PageInfo;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import java.util.List;

/**
 * @author: hwh@10671
 * @date: 2021/4/18 10:06
 * @description:
 */
//让SpringMVC的ioc可以自动注入
@WebAppConfiguration
@ContextConfiguration(locations = {"classpath:applicationcontext.xml","file:src/main/webapp/WEB-INF/dispatcherServlet-servlet.xml"})
@RunWith(SpringJUnit4ClassRunner.class)
public class MVCTest {
    //传入SpringMVC的ioc
    @Autowired
    WebApplicationContext context;
    //虚拟MVC请求,获取到处理的结果
    MockMvc mockMvc;

    @Before
    public void initMVC(){
        //初始化mockMvc
        mockMvc = MockMvcBuilders.webAppContextSetup(context).build();
    }

    @Test
    public void testPage() throws Exception {
        //模拟发送请求 并拿到返回值
        MvcResult result = mockMvc.perform(MockMvcRequestBuilders.get("/emps").param("pn", "5")).andReturn();

        //请求成功后,请求域中会有pageInfo;我们可以取出pageInfo进行验证
        MockHttpServletRequest request = result.getRequest();
        PageInfo pageInfo = (PageInfo) request.getAttribute("pageInfo");
        System.out.println("当前页码: " + pageInfo.getPageNum());
        System.out.println("总页码: " + pageInfo.getPages());
        System.out.println("总记录数: " + pageInfo.getTotal());
        System.out.println("在页面需要连续显示的页码");
        int[] navigatepageNums = pageInfo.getNavigatepageNums();
        for(int i : navigatepageNums){
            System.out.print(" " + i);
        }
        System.out.println();

        //获取员工数据
        List<Employee> list = pageInfo.getList();
        for(Employee e : list){
            System.out.println("ID: " + e.getId() + "===> Name: " + e.getEmpName() + "===> dept: " + e.getDepartment());
        }
    }
}
