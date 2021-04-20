package com.athwh.crud.test;

import com.athwh.crud.bean.Employee;
import com.athwh.crud.dao.DepartmentMapper;
import com.athwh.crud.dao.EmployeeMapper;
import org.apache.ibatis.session.SqlSession;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.UUID;

/**
 * @author: hwh@10671
 * @date: 2021/4/17 21:41
 * @description: 测试dao层的工作
 * 推荐Spring的项目直接使用Spring的单元测试,可以自动注入我们需要的组件
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationcontext.xml"})
public class MapperTest {
    @Autowired
    DepartmentMapper departmentMapper;

    @Autowired
    EmployeeMapper employeeMapper;

    @Autowired
    SqlSession sqlSession;

    /**
     * 测试DepartMentMapper
     */
    @Test
    public void testCRUD() {
        //1.创建SpringIOC容器
//        ApplicationContext context = new ClassPathXmlApplicationContext("applicationcontext.xml");
        //2.从容器里拿mapper
//        DepartmentMapper departmentMapper = context.getBean(DepartmentMapper.class);
//        System.out.println(departmentMapper);

        //插入几个部门
//        departmentMapper.insertSelective(new Department(null, "开发部"));
//        departmentMapper.insertSelective(new Department(null, "测试部"));
//        departmentMapper.insertSelective(new Department(null, "研发部"));
//        departmentMapper.insertSelective(new Department(null, "人事部"));

        //生成员工数据,测试员工插入

//        employeeMapper.insertSelective(new Employee(null,"Mary","M","Mary@qq.com", 4));

        //批量插入为了后面的页面显示
//        for (){
//              employeeMapper.insertSelective(new Employee(null,"Jerry","M","Jerry@163.com", 1));
//        }
        EmployeeMapper eMapper = sqlSession.getMapper(EmployeeMapper.class);
        for (int i = 0; i < 1000; i++) {
            String name = UUID.randomUUID().toString().substring(0, 6) + i;
            eMapper.insertSelective(new Employee(null, name, "M", name + "@qq.com", (i % 4) + 1));
        }

    }
}
