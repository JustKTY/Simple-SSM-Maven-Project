package com.athwh.crud.controller;

import com.athwh.crud.bean.Employee;
import com.athwh.crud.bean.Msg;
import com.athwh.crud.service.EmployeeService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author: hwh@10671
 * @date: 2021/4/17 22:12
 * @description:
 */
@Controller
public class EmployeeController {
    @Autowired
    EmployeeService employeeService;

    /**
     * 根据ID删除员工(单个批量删除二合一)
     * 批量删除 参数形式: 1-2-3...
     * 单个删除 参数形式  id
     * @param ids
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/emp/{ids}",method = RequestMethod.DELETE)
    public Msg deleteEmpById(@PathVariable("ids") String ids){
        if(ids.contains("-")){  //多个删除
            List<Integer> del_ids = new ArrayList<>();
            String[] str_ids = ids.split(("-"));
            //组装id集合
            for(String str : str_ids){
                del_ids.add(Integer.parseInt(str));
            }
            employeeService.deleteBatch(del_ids);
        }else {   //单个删除
            Integer id = Integer.parseInt(ids);
            employeeService.deleteEmp(id);
        }
        return  Msg.success();
    }

    /**
     * 更新员工
     * @param employee
     * @return
     */
    @RequestMapping(value = "/emp/{id}",method = RequestMethod.PUT)
    @ResponseBody
    public Msg saveEmp(Employee employee){
        employeeService.updateEmp(employee);
        return Msg.success();
    }

    /**
     * 根据id返回员工信息
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/emp/{id}",method = RequestMethod.GET)
    public Msg getEmp(@PathVariable("id") Integer id){
        Employee employee = employeeService.getEmp(id);
        return Msg.success().add("emp",employee);
    }

    /**
     * 检查用户名是否可用
     * @param empName
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/checkuser")
    public Msg checkUser(@RequestParam("empName") String empName) {
        //先判断用户名是否是合法的表达式
        String regx = "(^[a-zA-Z0-9_-]{3,16}$)|(^[\\u2E80-\\u99FFF]{2,5})";
        if(!empName.matches(regx)){
            return Msg.fail().add("va_msg","用户名要求是3-16位的字母和数字等字符组合,或者2-5位的中文!");
        }

        //数据库验证用户名重复性
        boolean flag = employeeService.checkUser(empName);
        if (flag) {
            return Msg.success();
        } else
            return Msg.fail().add("va_msg","用户名不可用");
    }

    /**
     * 员工保存方法
     * 1.支持JSR303校验
     * 2.导入Hibernate-Validator
     * 3.使用@Valid,BindingResult result保存校验结果
     * @return
     */
    @RequestMapping(value = "/emp", method = RequestMethod.POST)
    @ResponseBody
    public Msg saveEmp(@Valid Employee employee, BindingResult result) {
        Map<String,Object> map = new HashMap<>();
        if(result.hasErrors()){
            List<FieldError> fieldErrors = result.getFieldErrors();
            for(FieldError error : fieldErrors){
                System.out.println("错误的字段名: " + error.getField());
                System.out.println("错误信息: " + error.getDefaultMessage());
                map.put(error.getField(),error.getDefaultMessage());
            }
            //数据库验证用户名重复性
            boolean flag = employeeService.checkUser(employee.getEmpName());
            if (flag) {
                map.put("checkUser", "用户名可用!");
            } else
               map.put("checkUser","用户名不可用!");
            return Msg.fail().add("errorFields", map);
        }else {
            employeeService.saveEmp(employee);
            return Msg.success();
        }
    }

    /**
     * 导入jackson包
     *
     * @param pn
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/emps")
    public Msg getEmpWithJson(@RequestParam(value = "pn", defaultValue = "1") Integer pn) {
        //引入pageHelper插件实现分页查询 并且要在mybatis的全局配置文件中配置
        //在查询之前只需要调用,传入页码,以及每页的大小
        PageHelper.startPage(pn, 10);
        //接下来开始分页查询
        List<Employee> emps = employeeService.getAll();
        //PageInfo包装查询后的结果,只需要将PageInfo交给页面就可以了(第二个参数表示每次下面调整页数的选项的个数)
        PageInfo page = new PageInfo(emps, 5);
        return Msg.success().add("pageInfo", page);
    }

    /**
     * 查询员工数据（分页查询）
     *
     * @return
     */
    @RequestMapping(value = "/showEmps")
    public String getEmps(@RequestParam(value = "pn", defaultValue = "1") Integer pn, Model model) {  //从请求参数中拿页数,默认为1
        //引入pageHelper插件实现分页查询 并且要在mybatis的全局配置文件中配置
        //在查询之前只需要调用,传入页码,以及每页的大小
        PageHelper.startPage(pn, 10);
        //接下来开始分页查询
        List<Employee> emps = employeeService.getAll();
        //PageInfo包装查询后的结果,只需要将PageInfo交给页面就可以了(第二个参数表示每次下面调整页数的选项的个数)
        PageInfo page = new PageInfo(emps, 5);
        //测试PageInfo全部属性
        //PageInfo包含了非常全面的分页属性
//        assertEquals(1, page.getPageNum());
//        assertEquals(10, page.getPageSize());
//        assertEquals(1, page.getStartRow());
//        assertEquals(10, page.getEndRow());
//        assertEquals(183, page.getTotal());
//        assertEquals(19, page.getPages());
//        assertEquals(1, page.getFirstPage());
//        assertEquals(8, page.getLastPage());
//        assertEquals(true, page.isFirstPage());
//        assertEquals(false, page.isLastPage());
//        assertEquals(false, page.isHasPreviousPage());
//        assertEquals(true, page.isHasNextPage());
        model.addAttribute("pageInfo", page);
        return "list";
    }
}
