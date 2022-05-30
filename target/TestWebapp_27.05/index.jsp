<%@ page import="com.company.model.Role" %><%--
  Created by IntelliJ IDEA.
  User: andrew
  Date: 27.05.2022
  Time: 11:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="t" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>index</title>
    <link rel="stylesheet" href="css/styles.css">
</head>
<body>

<%@ include file="header.jsp" %>


<% if (session.getAttribute("role") == null) {%>
<%--session is new or invalidated (unknown user)--%>
<div class="body-content" style="text-align: center;">
    <h1 class="title-main">Hello unknown user!</h1>
    <hr>
    <table style="width: 100%; padding: 20px 0;">
        <thead>
        <tr>
            <th>
                <h3 style="text-align: center; margin: 20px 0;">
                    Short info:</h3>
            </th>
        </tr>
        </thead>
        <tbody style="text-align: center;">
        <tr>
            <td style="padding: 5px 10px">
                An_dELLO - це зручний інформаційний сервіс!
                <br>
                <div style="width: 40%; margin: auto; text-align: left; padding: 20px 0;">
                    <h4 style="text-align: center; padding: 8px 0">Можливості користувача:</h4>
                    <ul>
                        <li><a href="calculate.jsp">Обчислювати вартість сервісу</a></li>
                        <li><a href="table">Продивитись останні замовлення</a></li>
                    </ul>
                    <div style="padding: 10px 0 20px 0">
                        <hr>
                    </div>
                </div>
                <div style="width: 40%; margin: auto; text-align: left; padding: 20px 0;">
                    <h4 style="text-align: center; padding: 8px 0">Можливості авторизаваного <br> користувача:</h4>
                    <ul>
                        <li><a href="calculate.jsp">Обчислювати вартість сервісу</a></li>
                        <li><a href="table">Продивитись останні замовлення</a></li>
                        <li><a href="login.jsp">Подати заявку на замовлення</a></li>
                    </ul>
                    <div style="padding: 10px 0 20px 0">
                        <hr>
                    </div>
                </div>
                <br>
                Основний пріоритет у нашій роботі — <strong>актуальність інформації</strong>.
                <br>
                <br>
            </td>
        </tr>
        </tbody>
    </table>
</div>
<%
} else { // session is registered:
    if (session.getAttribute("role") == Role.AUTHORIZED) {
%>
<%-- this is a default user (client) --%>
<div class="body-content" style="text-align: center;">
    <h1 class="title-main">Welcome back, user <%= session.getAttribute("login") %>!</h1>
    <hr>
</div>
<%} else if ((session.getAttribute("role") == Role.MANAGER)) {%>
<%-- this is a VIP (manager) --%>
<div class="body-content" style="text-align: center;">
    <h1 class="title-main">Welcome back, manager <%= session.getAttribute("login") %>!</h1>
    <hr>
</div>
<%
        }
    }
%>


<%@ include file="footer.jsp" %>


<%-- Sweet Alert --%>
<input type="hidden" id="status" value="<%= request.getAttribute("status")%>">

<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<link rel="stylesheet" href="alert/dist/sweetalert.css">

<script type="text/javascript">

    var status = document.getElementById("status").value;
    switch (status) {
        case "trafficListIsEmpty":
            swal("Oops!", "The traffic list is empty!", "error");
            break;

        case "userListIsEmpty":
            swal("Oops!", "The user list is empty!", "error");
            break;
    }

</script>

</body>
</html>
