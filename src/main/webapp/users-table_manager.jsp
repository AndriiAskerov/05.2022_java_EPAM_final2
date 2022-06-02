<%--
  Created by IntelliJ IDEA.
  User: andrew
  Date: 31.05.2022
  Time: 11:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>

<html>
<head>

    <title>users-table_manager</title>

    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
    <link rel="stylesheet"
          href="http://cdn.datatables.net/1.10.2/css/jquery.dataTables.min.css">
    <script type="text/javascript"
            src="http://cdn.datatables.net/1.10.2/js/jquery.dataTables.min.js"></script>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-0evHe/X+R7YkIZDRvuzKMRqM+OrBnVFBL6DOitfPri4tjfHxaWutUpFmBp4vmVor" crossorigin="anonymous">
    <!-- JavaScript Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-pprn3073KE6tl6bjs2QrFaJGz5/SUsLqktiwsUTF55Jfv3qYSDhgCecCxMW52nD2"
            crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.3.0/font/bootstrap-icons.css">

</head>
<body>

<%@ include file="header.jsp" %>


<div class="body-content" style="text-align: center;">
    <h1 class="title-main">Список користувачів</h1>
    <div style="margin-bottom: 20px;">
        (номер клієнта, логін, пароль та електронна адреса)
    </div>

    <%-- Table from FOREACH cycle --%>
    <table id="usersTable" class="table table-hover" style="user-select: none;">
        <thead style="text-align: center;">
        <tr>
            <th scope="col" style="width:50px;">Номер замовника</th>
            <th scope="col" style="width:400px;">Логін</th>
            <th scope="col" style="width:400px;">Пароль</th>
            <th scope="col" style="width:400px;">Електронна пошта</th>
            <th scope="col" style="width:400px;">Права</th>
        </tr>
        </thead>
        <tbody>
        <c:set var="count" value="0" scope="page"/>
        <c:forEach items="${userList}" var="item">
            <tr data-bs-toggle="modal" data-bs-target="#userModal${count}" style="cursor: pointer;">
                <td>${item.id}</td>
                <td>${item.login}</td>
                <td>${item.password}</td>
                <td>${item.email}</td>
                <td>${item.role}</td>
            </tr>

            <!-- User Modal -->
            <div class="modal fade" id="userModal${count}" tabindex="-1"
                 aria-labelledby="exampleModalLabel"
                 aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content">
                        <form action="usersTable" method="post"> <%----%>
                            <div class="modal-header" style="text-align: center">
                                <h5 class="modal-title" id="exampleModalLabel">
                                    Номер замовника: <strong>${item.id}</strong></h5>
                                <button type="reset" class="btn-close" data-bs-dismiss="modal" style="margin-right: 1px;"
                                        aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <ul class="list-group list-group-flush">
                                    <li class="list-group-item">
                                        Логін: <strong>${item.login}</strong>
                                        <%--<input type="text" name="clientId" value="${item.clientId}" disabled style="width: 70px; border: none; text-align: center;">--%>
                                            <%--<strong> ( <button type="submit" style="border: none; background: none; text-decoration: underline;">
                                                профіль
                                            </button> ) </strong>--%> <%-- TODO implement logic: check out client's profile --%>
                                    </li>
                                    <li class="list-group-item">
                                        Пароль: <strong>${item.password}</strong>
                                    </li>
                                    <li class="list-group-item">
                                        Е-адреса: <strong>${item.email}</strong>
                                    </li>
                                    <li class="list-group-item">
                                        Права: <strong>${item.role}</strong>
                                    </li>
                                </ul>
                            </div>

                            <%--Hidden--%>

                            <%--Hidden--%>

                            <button type="submit" class="btn btn-primary" style="margin: 0 15px 15px;">
                                Зберегти
                            </button>
                        </form>
                    </div>
                </div>
            </div>
            <c:set var="count" value="${count + 1}" scope="page"/>
        </c:forEach>
        </tbody>
    </table>

</body>
</html>


<%@ include file="footer.jsp" %>


<%-- Table script --%>
<script>
    $(document).ready(function () {
        $('#usersTable').dataTable();
    });
</script>

</body>
</html>
