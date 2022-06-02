<%@ page import="com.company.model.Role" %><%--
  Created by IntelliJ IDEA.
  User: andrew
  Date: 27.05.2022
  Time: 22:02
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page isELIgnored="false" %>

<html>

<fmt:bundle basename="i18n_ua">
    <fmt:message key="header.calculate" var="h_calculate"/>
    <fmt:message key="header.orders" var="h_orders"/>
    <fmt:message key="header.about" var="h_about"/>
    <fmt:message key="header.lang.en" var="h_langEn"/>
    <fmt:message key="header.lang.ua" var="h_langUa"/>
    <fmt:message key="header.login" var="h_login"/>
    <fmt:message key="header.users" var="h_users"/>
    <fmt:message key="header.logout" var="h_logout"/>
</fmt:bundle>

<head>
    <title></title>
    <link rel="stylesheet" href="css/styles.css">

</head>
<body>

<% if (session.getAttribute("role") != null) {%>

<nav>
    <table class="header">
        <thead>
        <th class="logo">
            <a class="link" href="index.jsp">An_dELLO</a></th>

        <% if (session.getAttribute("role") == Role.MANAGER) {%>
        <th class="nav-wrapper_right">
            <a class="link" href="usersTable">${h_users}<%--Клієнти--%></a></th>
        <%} else {%>
        <th class="nav-wrapper_right">
            <a class="link" href="calculate.jsp">${h_calculate}<%--Розрахувати вартість послуг--%></a></th>
        <%}%>

        <th class="nav-wrapper_right">
            <a class="link" href="table">${h_orders}<%--Замовлення--%></a></th>

        <th class="nav-wrapper_right">
            <a class="link" href="about_us.jsp">${h_about}<%--Про нас--%></a></th>

        <th class="nav-wrapper_right">
            <a class="dropdown-item" href="?lang=en" style="text-decoration: none;">${h_langEn}</a>
            <a class="dropdown-item" href="?lang=ua" style="text-decoration: none;">${h_langUa}</a>

        <th class="nav-wrapper_right">
            <a class="link" href="logout">${h_logout}<br>(<%= session.getAttribute("login").toString() %>)<%--Вийти--%></a></th>
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
            <a class="link" href="calculate.jsp">${h_calculate}<%--Розрахувати вартість послуг--%></a></th>

        <th class="nav-wrapper_right">
            <a class="link" href="table">${h_orders}<%--Замовлення--%></a></th>

        <th class="nav-wrapper_right">
            <a class="link" href="about_us.jsp">${h_about}<%--Про нас--%></a></th>

        <th class="nav-wrapper_right">
            <a class="dropdown-item" href="?lang=en" style="text-decoration: none;">${h_langEn}</a>
            <a class="dropdown-item" href="?lang=ua" style="text-decoration: none;">${h_langUa}</a>

        <th class="nav-wrapper_right">
            <a class="link" href="login.jsp">${h_login}<%--Увійти--%></a></th>
        </thead>
    </table>
</nav>

<%}%>

</body>
</html>
