package com.athwh.crud.controller;

import com.athwh.crud.bean.Department;
import com.athwh.crud.bean.Msg;
import com.athwh.crud.service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * @author: hwh@10671
 * @date: 2021/4/18 19:12
 * @description:
 */
@Controller
public class DepartmentController {
    @Autowired
    private DepartmentService departmentService;

    /**
     * 返回所有的部门信息
     */
    @ResponseBody
    @RequestMapping(value = "/depts")
    public Msg getDepts(){
        List<Department> depts = departmentService.getDepts();
        return Msg.success().add("depts",depts);
    }
}
