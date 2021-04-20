<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: 10671
  Date: 2021/4/17
  Time: 22:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>员工列表</title>
    <%-- web路径问题
    不以/开头的相对路径,找资源时以当前资源的路径为基准,很容易出问题
    以/开头的相对路径,找资源是是以服务器的路径为基准(http://localhost:8099);再加上项目名称即可ssm_crud
        即http://localhost:8099/ssm_crud/资源名

    --%>
    <%
        pageContext.setAttribute("APP_PATH", request.getContextPath());
    %>
    <!-- 引入JQuery -->
    <script type="text/javascript" src="${APP_PATH}/static/js/jquery-2.1.4.min.js"></script>
    <!-- Bootstrap -->
    <link href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- 加载 Bootstrap 的所有 JavaScript 插件。你也可以根据需要只加载单个插件。 -->
    <script src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>
<!-- Modal 员工修改 SpringMVC中表单name属性和bean属性名一致自动封装对象 -->
<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title">员工修改</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <p class="form-control-static" id="empName_update_static"></p>
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input name="email" type="text" class="form-control" id="email_update_input"
                                   placeholder="eg: Alibaba@***.com">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_update_input" value="M" checked="checked">
                                男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_update_input" value="F"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">deptName</label>
                        <div class="col-sm-4">
                            <%-- 根据部门id查询到部门名 --%>
                            <select class="form-control" name="dId" id="dept_update_select"></select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_update_btn">修改</button>
            </div>
        </div>
    </div>
</div>

<!-- Modal 员工添加 SpringMVC中表单name属性和bean属性名一致自动封装对象 -->
<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="myModalLabel">员工添加</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <input name="empName" type="text" class="form-control" id="empName_add_input"
                                   placeholder="empName">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input name="email" type="text" class="form-control" id="email_add_input"
                                   placeholder="eg: Alibaba@***.com">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_add_input" value="M" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_add_input" value="F"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">deptName</label>
                        <div class="col-sm-4">
                            <%-- 根据部门id查询到部门名 --%>
                            <select class="form-control" name="dId" id="dept_add_select">

                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
            </div>
        </div>
    </div>
</div>

<div class="container">
    <%--    标题行    --%>
    <div class="row">
        <div class="col-md-12">
            <h1 style="color: #f40">SSM-CRUD</h1>
        </div>
    </div>
    <%--    两个按钮   --%>
    <div class="row">
        <div class="col-md-4 col-md-offset-10" style="margin-bottom: 5px;">
            <button type="button" class="btn btn-success" id="emp_add_modal_btn">新增</button>
            <button type="button" class="btn btn-danger" id="emp_delete_all_btn">删除</button>
        </div>
    </div>
    <%--    显示表格数据   --%>
    <div class="row">
        <div class="col-md-12">
            <table class="table table-striped table-bordered table-hover" id="emps_table">
                <thead>
                <tr>
                    <th>
                        <input type="checkbox" id="check_all">
                    </th>
                    <th>#</th>
                    <th>empName</th>
                    <th>gender</th>
                    <th>email</th>
                    <th>deptName</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody></tbody>
            </table>
        </div>
    </div>
    <%--    显示分页信息    --%>
    <div class="row">
        <%--      分页的文字信息      --%>
        <div class="col-md-6" id="page_info_area"></div>
        <%--      分页条信息      --%>
        <div class="col-md-6" id="page_nav_area"></div>
    </div>
</div>
</div>
<script type="text/javascript">
    var totalRecord;
    var currentPage;
    var pageSize;

    //1.页面加载完成后,直接去发送一个ajax请求,得到分页数据
    $(function () {
        to_page(1);
    });

    //解析显示员工数据
    function build_emps_table(result) {
        //每次展示之前要把前一次的数据清空,因为ajax不会刷新页面
        $("#emps_table tbody").empty();

        var emps = result.extend.pageInfo.list;
        $.each(emps, function (index, item) {
            // alert((item.empName));
            var checkBoxTd = $("<td><input type='checkbox' class='check_item'/></td>");
            var empIdTd = $("<td></td>").append(item.id);
            var empNameTd = $("<td></td>").append(item.empName);
            var gender = item.gender == "M" ? "男" : "女";
            var genderTd = $("<td></td>").append(item.gender);
            var emailTd = $("<td></td>").append(item.email);
            var deptNameTd = $("<td></td>").append(item.department.deptName);
            var editBtn = $("<button></button>").addClass("btn btn-info btn-sm edit_btn")
                .append("<span></span>").addClass("glyphicon glyphicon-pencil").append("编辑");
            var deleteBtn = $("<button></button>").addClass("btn btn-danger btn-sm delete_btn")
                .append("<span></span>").addClass("glyphicon glyphicon-trash").append("删除");

            //给edit按钮赋一个自定义属性代表员工id
            editBtn.attr("edit-id", item.id);

            //同理给delete按钮页加一个delete-id属性
            deleteBtn.attr("delete-id", item.id);

            //将两个按钮写在一个单元格中
            var btnTd = $("<td></td>").append(editBtn).append(" ").append(deleteBtn);
            //可以这么写的原因是append方法执行完后,还是返回原来的元素
            $("<tr></tr>").append(checkBoxTd)
                .append(empIdTd)
                .append(empNameTd)
                .append(genderTd)
                .append(emailTd)
                .append(deptNameTd)
                .append(btnTd)
                .appendTo("#emps_table tbody");
        })
    }

    //查询指定页码的员工数据并展示到页面
    function to_page(pn) {
        $.ajax({
            url: "${APP_PATH}/emps",
            data: "pn=" + pn,
            type: "GET",
            success: function (result) {
                // console.log(result);
                //1.得到数据后,解析并显示员工数据
                build_emps_table(result)
                //2.解析显示分页数据
                build_page_info(result);
                bulid_page_nav(result);
            }
        });
    }

    //解析显示分页信息
    function build_page_info(result) {
        //每次展示之前要把前一次的数据清空,因为ajax不会刷新页面
        $("#page_info_area").empty();

        $("#page_info_area").append("当前第 " + result.extend.pageInfo.pageNum + " 页,总 " +
            result.extend.pageInfo.pages + " 页,总 " + result.extend.pageInfo.total + " 条记录");
        totalRecord = result.extend.pageInfo.total;
        currentPage = result.extend.pageInfo.pageNum;
        pageSize = result.extend.pageInfo.pageSize;
    }

    //解析显示分页条的信息
    function bulid_page_nav(result) {
        //每次展示之前要把前一次的数据清空,因为ajax不会刷新页面
        $("#page_nav_area").empty();

        var ul = $("<ul></ul>").addClass("pagination");

        var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href", "#"));
        var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;"));
        if (result.extend.pageInfo.hasPreviousPage == false) {
            firstPageLi.addClass("disabled");
            prePageLi.addClass("disabled");
        } else {  //如果没有上一页就不绑定相应单击事件
            //为元素添加点击翻页的事件
            firstPageLi.click(function () {
                to_page(1);
            });
            prePageLi.click(function () {
                to_page(result.extend.pageInfo.pageNum - 1);
            });
        }

        var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;"));
        var lastPageLi = $("<li></li>").append($("<a></a>").append("末页").attr("href", "#"));
        if (result.extend.pageInfo.hasNextPage == false) {
            nextPageLi.addClass("disabled");
            lastPageLi.addClass("disabled");
        } else {  //如果没有下一页就不绑定相应单击事件
            //为元素添加点击翻页的事件
            lastPageLi.click(function () {
                to_page(result.extend.pageInfo.pages);
            });
            nextPageLi.click(function () {
                to_page(result.extend.pageInfo.pageNum + 1);
            });
        }

        //添加首页和前一页的li
        ul.append(firstPageLi).append(prePageLi);

        $.each(result.extend.pageInfo.navigatepageNums, function (index, item) {
            var numLi = $("<li></li>").append($("<a></a>").append(item));
            if (result.extend.pageInfo.pageNum == item) {
                numLi.addClass("active");
            }
            numLi.click(function () {
                to_page(item);
            })
            //添加页面显示的连续页码号的li
            ul.append(numLi);
        })
        //添加末页和后一页的li
        ul.append(nextPageLi).append(lastPageLi);

        //把ul加入到nav
        var navElement = $("<nav></nav>").append(ul);
        //把导航栏加入到页面展示的div中
        navElement.appendTo("#page_nav_area");
    }

    function reset_form(element) {
        $(element)[0].reset();
        $(element).find("*").removeClass("has-error has-success");
        $(element).find(".help-block").text("");
    }

    //点击新增按钮弹出模态框
    $("#emp_add_modal_btn").click(function () {
        //表单重置(数据,和样式),因为是ajax,不刷新页面
        reset_form($("#empAddModal form"));
        $("#empAddModal form")[0].reset();

        //发送ajax请求,查出下拉列表的部门名
        getDeptName("#dept_add_select");

        $("#empAddModal").modal({
            backdrop: "static"
        })
    })

    //查出所有的部门信息
    function getDeptName(element) {
        //每次查询前清空前一次查询的结果,因为是ajax
        $(element).empty();

        $.ajax({
            url: "${APP_PATH}/depts",
            type: "get",
            success: function (result) {
                // console.log(result);
                //显示部门信息在下拉列表
                $.each(result.extend.depts, function () {
                    var optionElm = $("<option></option>").append(this.deptName).attr("value", this.deptId);
                    optionElm.appendTo(element);
                })
            }
        })
    }

    //数据校验
    function validata_add_form() {
        //拿到要校验的数据,使用正则来校验
        let empName = $("#empName_add_input").val();
        var regName = /(^[a-zA-Z0-9_-]{3,16}$)|(^[\u2E80-\u99FFF]{2,5})/;
        if (!regName.test(empName)) {
            // alert("用户名要求是3-16位的英文字符,或者2-5位的中文!");
            show_validate_msg("#empName_add_input", "error", "用户名要求是3-16位的英文字符,或者2-5位的中文!");
            return false;
        } else {
            show_validate_msg("#empName_add_input", "success", "");
        }

        let email = $("#email_add_input").val();
        var regEmail = /^[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+(\.[a-zA-Z0-9_-]+)+$/;
        if (!regEmail.test(email)) {
            // alert("邮箱格式不正确!");
            show_validate_msg("#email_add_input", "error", "邮箱格式不正确");
            return false;
        } else {
            show_validate_msg("#email_add_input", "success", "");
        }

        return true;
    }

    function show_validate_msg(element, status, msg) {
        //每次显示之前清空之前的样式
        $(element).parent().removeClass("has-success has-error");
        $(element).next("span").text("");

        if ("success" == status) {
            $(element).parent().addClass("has-success");
            $(element).next("span").text(msg);
        } else if ("error") {
            $(element).parent().addClass("has-error");
            $(element).next("span").text(msg);
        }
    }

    $("#empName_add_input").change(function () {
        //发送ajax请求校验用户名是否可用
        var empName = this.value;
        $.ajax({
            url: "${APP_PATH}/checkuser",
            data: "empName=" + empName,
            type: "POST",
            success: function (result) {
                if (result.code == 100) {
                    show_validate_msg("#empName_add_input", "success", "用户名可用");
                    $("#emp_save_btn").attr("ajax-va", "success");
                } else {
                    show_validate_msg("#empName_add_input", "error", result.extend.va_msg);
                    $("#emp_save_btn").attr("ajax-va", "error");
                }
            }
        });
    })

    $("#emp_save_btn").click(function () {
        //1.将模态框填写的表单数据提交给服务器进行保存
        //首先进行数据校验
        if ($(this).attr("ajax-va") == "error") {
            return false;
        }

        if (!validata_add_form()) {
            return false;
        }
        ;

        //发送Ajax请求保存员工
        $.ajax({
            url: "${APP_PATH}/emp",
            type: "POST",
            //序列化表单数据(serialize())
            data: $("#empAddModal form").serialize(),
            success: function (result) {
                if (result.code == 100) {
                    // alert(result.msg);
                    //员工保存成功后的操作
                    //1.关闭模态框
                    $("#empAddModal").modal('hide');
                    //2.来到最后一页,显示新添的员工
                    //关键在于如何确定新加入的员工在哪一页(如果没加之前最后一页数据刚好是最大,则新加员工在最后一页)
                    //发送ajax请求,总是展示最后一页数据即可(totalRecord总记录数一定不小于总页数,因为每页至少展示一个数据,
                    // 而pageHelper配置了reasonable之后,大于最大页码的全部都是展示最后一页)
                    to_page(totalRecord);
                } else { //显示错误信息
                    // console.log(result);
                    //邮箱格式有问题
                    if (result.extend.errorFields.email != undefined) {
                        show_validate_msg("#email_add_input", "error", result.extend.errorFields.email);
                    }
                    //员工姓名格式有问题
                    if (result.extend.errorFields.empName != undefined) {
                        show_validate_msg("#empName_add_input", "error", result.extend.errorFields.empName);
                    }

                    // //员工姓名是否可用
                    // if(result.extend.errorFields.checkUser != undefined){
                    //     show_validate_msg("#empName_add_input","error",result.extend.errorFields.checkUser);
                    // }
                }
            }
        })
    })

    function getEmp(id) {
        $.ajax({
            url: "${APP_PATH}/emp/" + id,
            type: "GET",
            success: function (result) {
                // console.log(result);
                var empData = result.extend.emp;
                $("#empName_update_static").text(empData.empName);
                $("#email_update_input").val(empData.email);
                $("#empUpdateModal input[name=gender]").val([empData.gender]);
                $("#empUpdateModal select").val([empData.dId]);
            }
        })
    }

    //按钮创建时在ajax请求时创建的,而绑定事件在这之前所以绑定不上
    //我们可以创建按钮就绑定事件 使用on方法(新版jquery使用on替代live)
    $(document).on("click", ".edit_btn", function () {
        // alert("~~~~");
        //1.查出员工信息,并显示
        //在创建编辑按钮时,给按钮赋一个属性代表员工id
        getEmp($(this).attr("edit-id"));

        //2.查出部门信息.并显示部门列表
        getDeptName("#empUpdateModal select");

        //3,弹出模态框,并把员工的id传递给模态框的更新按钮,方便后续修改
        $("#emp_update_btn").attr("edit-id", $(this).attr("edit-id"));
        $("#empUpdateModal").modal({
            backdrop: "static"
        })
    });

    //点击更新按钮,更新员工信息
    $("#emp_update_btn").click(function () {
        //验证要修改的email是否合法
        let email = $("#email_update_input").val();
        var regEmail = /^[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+(\.[a-zA-Z0-9_-]+)+$/;
        if (!regEmail.test(email)) {
            // alert("邮箱格式不正确!");
            show_validate_msg("#email_update_input", "error", "邮箱格式不正确");
            return false;
        } else {
            show_validate_msg("#email_update_input", "success", "");
        }

        //2.发送ajax请求更新员工
        $.ajax({
            url: "${APP_PATH}/emp/" + $(this).attr("edit-id"),
            type: "PUT",
            /*
             * &_method=PUT让post转为put方法
             * 当然ajax可以直接发送put方法
             * Employee对象封装不上,导致控制台报错
             * 封装不上原因: Tomcat将请求体中的数据,封装一个map,request.getParameter("employee")会从这个map里拿
             * ,但是Tomcat看是put请求就不会封装数据,只有post会
             * springmvc封装对象时,会把对象每个属性的值,通过request.getParameter("employee")得到.
             * 所以不能直接发起put请求,如果要直接发起,在web.xml里配置一个FormContentFilter
             */
            // data: $("#empUpdateModal form").serialize() + "&_method=PUT",
            data: $("#empUpdateModal form").serialize(),
            success: function (result) {
                // alert(result.msg);
                //1.关闭模态框
                $("#empUpdateModal").modal("hide");

                //2.回到当前页面(当前页码存在全局变量currentPage里)
                to_page(currentPage);
            }
        })
    })

    //同理绑定删除按钮
    $(document).on("click", ".delete_btn", function () {
        //1.弹出是否删除的确认框
        var empName = $(this).parents("tr").find("td:eq(2)").text();
        if (confirm("确认删除【" + empName + "】吗?")) {
            $.ajax({
                url: "${APP_PATH}/emp/" + $(this).attr("delete-id"),
                type: "DELETE",
                success: function (result) {
                    alert(result.msg);
                    to_page(currentPage);
                }
            })
        }
    });

    //完成全选全不选功能
    $("#check_all").click(function () {
        //attr用来获取自定义属性的值,prop来获取原生的属性(如果标签内没有显式声明属性,attr获取到的会是undefined)
        //所有员工的checked属性和全选按钮一致
        $(".check_item").prop("checked", $(this).prop("checked"));
    })

    $(document).on("click", ".check_item", function () {
        //判断本页中的全部员工是不是都选了
        var flag = $(".check_item:checked").length == pageSize;
        $("#check_all").prop("checked", flag);
    });

    //批量删除 emp_delete_all_btn
    $("#emp_delete_all_btn").click(function () {
        // $(".check_item:checked")
        var empNames = "";
        var del_ids = "";
        $.each($(".check_item:checked"), function () {
            empNames += ($(this).parents("tr").find("td:eq(2)").text() + ",");
            //组装员工id字符串
            del_ids += ($(this).parents("tr").find("td:eq(1)").text() + "-");
        });
        empNames = empNames.substring(0, empNames.length - 1);
        del_ids = del_ids.substring(0, del_ids.length - 1);
        if (confirm("确认删除这些员工【" + empNames + "】吗?")) {
            //发送ajax删除员工
            $.ajax({
                url: "${APP_PATH}/emp/" + del_ids,
                type: "DELETE",
                success: function (result) {
                    alert(result.msg);
                    to_page(currentPage);
                }
            })
        }
    })

</script>
</body>
</html>
