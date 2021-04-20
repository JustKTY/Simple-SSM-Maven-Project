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
        pageContext.setAttribute("APP_PATH",request.getContextPath());
    %>
    <!-- 引入JQuery -->
    <script type="text/javascript" src="${APP_PATH}/static/js/jquery-2.1.4.min.js"></script>
    <!-- Bootstrap -->
    <link href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- 加载 Bootstrap 的所有 JavaScript 插件。你也可以根据需要只加载单个插件。 -->
    <script src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>
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
                <button type="button" class="btn btn-success">新增</button>
                <button type="button" class="btn btn-danger">删除</button>
            </div>
        </div>
<%--    显示表格数据   --%>
        <div class="row">
            <div class="col-md-12">
                <table class="table table-striped table-bordered table-hover">
                    <tr>
                        <th>#</th>
                        <th>empName</th>
                        <th>gender</th>
                        <th>email</th>
                        <th>deptName</th>
                        <th>操作</th>
                    </tr>

                    <c:forEach items="${pageInfo.list}" var="emp">
                        <tr>
                            <td>${emp.id}</td>
                            <td>${emp.empName}</td>
                            <td>${emp.gender == "M" ? "男" : "女"}</td>
                            <td>${emp.email}</td>
                            <td>${emp.department.deptName}</td>
                            <td>
                                <button type="button" class="btn btn-info btn-sm">
                                    <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
                                    编辑
                                </button>
                                <button type="button" class="btn btn-danger btn-sm">
                                    <span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
                                    删除
                                </button>
                            </td>
                        </tr>
                    </c:forEach>
                </table>
            </div>
        </div>
<%--    显示分页信息    --%>
        <div class="row">
<%--      分页的文字信息      --%>
            <div class="col-md-6">
                    当前第${pageInfo.pageNum}页,总${pageInfo.pages}页,总${pageInfo.total}条记录
            </div>
<%--      分页条信息      --%>
            <div class="col-md-6">
                <nav aria-label="Page navigation">
                    <ul class="pagination">
                        <c:if test="${pageInfo.hasPreviousPage}">
                            <li>
                                <a href="${APP_PATH}/emps?pn=${pageInfo.pageNum - 1}" aria-label="Previous">
                                    <span aria-hidden="true">&laquo;</span>
                                </a>
                            </li>
                        </c:if>
                        <li><a href="${APP_PATH}/emps?pn=1">首页</a></li>

                        <c:forEach items="${pageInfo.navigatepageNums}" var="pageNum">
                            <c:if test="${pageNum == pageInfo.pageNum}">
                                <li class="active"><a href="${APP_PATH}/emps?pn=${pageNum}">${pageNum}</a></li>
                            </c:if>
                            <c:if test="${pageNum != pageInfo.pageNum}">
                                <li><a href="${APP_PATH}/emps?pn=${pageNum}">${pageNum}</a></li>
                            </c:if>
                        </c:forEach>

                        <c:if test="${pageInfo.hasNextPage}">
                            <li>
                                <a href="${APP_PATH}/emps?pn=${pageInfo.pageNum + 1}" aria-label="Next">
                                    <span aria-hidden="true">&raquo;</span>
                                </a>
                            </li>
                        </c:if>

                        <li><a href="${APP_PATH}/emps?pn=${pageInfo.pages}">末页</a></li>
                    </ul>
                </nav>
            </div>
        </div>
    </div>
</body>
</html>
