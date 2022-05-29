<%--
  Created by IntelliJ IDEA.
  User: andrew
  Date: 27.05.2022
  Time: 12:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>menu_user</title>
</head>
<body>

<%@ include file="header.jsp" %>

<div class="body-content">
    <h1>Welcome, user <%= session.getAttribute("login").toString() %>!</h1>
    <a href="logout">Log out</a>
</div>

<%@ include file="footer.jsp" %>

</body>
</html>
