<%@ page import="com.company.utils.InputPatterns" %><%--
  Created by IntelliJ IDEA.
  User: andrew
  Date: 27.05.2022
  Time: 11:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <title>login</title>
    <link rel="stylesheet" href="css/styles.css">
</head>
<body>

<input type="hidden" id="status" value="<%= request.getAttribute("status")%>">

<div class="body-content" style="text-align: center;">
    <h1 class="title-main">
        Please, enter login and password</h1>

    <form method="post" action="login">
        <input required class="input" type="text" name="login" placeholder="Login">
        <br>
        <input required class="input" type="password" name="password" placeholder="Password"
               pattern="<%= InputPatterns.password.getPattern() %>">
        <br>
        <input class="button" type="submit" value="Log in">
    </form>
    <br>
    Go back to the <a href="index.jsp"><strong>main page</strong>.</a>
    <br><br>
    Create a <a href="registration.jsp">new account</a>!
</div>

<%-- Sweet Alert --%>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<link rel="stylesheet" href="alert/dist/sweetalert.css">

<script type="text/javascript">

    var status = document.getElementById("status").value;
    switch (status) {
        case "noSuchUser":
            swal("Oops!", "There is no user with a pair of username and password like this!", "error");
            break;

        case "invalidLogin":
            swal("Oops!", "Please, enter a proper login!", "error");
            break;

        case "invalidPassword":
            swal("Oops!", "Please, enter a proper password!", "error");
            break;
    }

</script>

</body>
</html>
