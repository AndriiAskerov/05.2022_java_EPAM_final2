<%--
  Created by IntelliJ IDEA.
  User: andrew
  Date: 29.05.2022
  Time: 1:45
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>menu_manager</title>
    <link rel="stylesheet" href="css/styles.css">
</head>
<body>

<nav>
    <table class="header">
        <thead>
        <th class="logo">
            <a class="link" href="home">An_dELLO</a></th>

        <th class="nav-wrapper_right">
            <a class="link" href="table">Orders<%--Замовлення--%></a></th>

        <th class="nav-wrapper_right">
            <a class="link" href="about_us.jsp">About<%--Про нас--%></a></th>

        <th class="nav-wrapper_right">
            <a class="link" href="login.jsp">Log out<br>(<%= session.getAttribute("login").toString() %>)<%--Вийти--%></a></th>
        </thead>
    </table>
</nav>

</body>
</html>
