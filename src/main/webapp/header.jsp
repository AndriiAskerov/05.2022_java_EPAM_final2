<%--
  Created by IntelliJ IDEA.
  User: andrew
  Date: 27.05.2022
  Time: 22:02
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>header</title>
    <link rel="stylesheet" href="css/styles.css">
</head>
<body>

<% if (session.getAttribute("role") != null) {%>

<nav>
    <table class="header">
        <thead>
        <th class="logo">
            <a class="link" href="index.jsp">An_dELLO</a></th>

        <th class="nav-wrapper_right">
            <a class="link" href="table">Orders<%--Замовлення--%></a></th>

        <th class="nav-wrapper_right">
            <a class="link" href="about_us.jsp">About<%--Про нас--%></a></th>

        <th class="nav-wrapper_right">
            <a class="link" href="logout">Log out<br>(<%= session.getAttribute("login").toString() %>)<%--Вийти--%></a></th>
        </thead>
    </table>
</nav>

<%} else {%>

<nav>
    <table class="header">
        <thead>
        <th class="logo">
            <a class="link" href="index.jsp">An_dELLO<%--Головна--%></a></th>

        <th class="nav-wrapper_right">
            <a class="link" href="table">Orders<%--Замовлення--%></a></th>

        <th class="nav-wrapper_right">
            <a class="link" href="about_us.jsp">About<%--Про нас--%></a></th>

        <th class="nav-wrapper_right">
            <a class="link" href="login.jsp">Log in<%--Увійти--%></a></th>
        </thead>
    </table>
</nav>

<%}%>

</body>
</html>
