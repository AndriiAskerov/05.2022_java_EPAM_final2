<%--
  Created by IntelliJ IDEA.
  User: andrew
  Date: 27.05.2022
  Time: 13:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>menu_manager</title>
</head>
<body>

<%@ include file="header_manager.jsp" %>


<div class="body-content">
    <h1>Welcome, manager <%= session.getAttribute("login").toString() %>!</h1>
</div>


<%@ include file="footer.jsp" %>

</body>
</html>
