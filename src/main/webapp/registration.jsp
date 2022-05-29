<%@ page import="com.company.utils.InputPatterns" %><%--
  Created by IntelliJ IDEA.
  User: andrew
  Date: 27.05.2022
  Time: 14:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>registration</title>
    <link rel="stylesheet" href="css/styles.css">
</head>
<body>

<input type="hidden" id="status" value="<%= request.getAttribute("status")%>">

<div class="body-content" style="text-align: center;">
    <h1 class="title-main">
        Please, fill up these fields</h1>

    <form method="post" action="register">
        <input required class="input" type="text" name="login" placeholder="Username (login)"><br>
        <input required class="input" type="password" name="password" placeholder="Password"
               pattern="<%= InputPatterns.password.getPattern() %>"><br>
        <input required class="input" type="password" name="re-password" placeholder="Confirm your password"><br>
        <input required class="input" type="email" name="email" placeholder="Email"
               pattern="<%= InputPatterns.email.getPattern() %>"><br>
        <input required class="button" type="submit" value="Create an account">
    </form>
    <br>
    Go back to the <a href="index.jsp"><strong>main page</strong></a>
    <br><br>
    Have an account already? <a href="login.jsp">Log in</a>!
</div>

<%-- Sweet Alert --%>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<link rel="stylesheet" href="alert/dist/sweetalert.css">

<script type="text/javascript">

    var status = document.getElementById("status").value;
    switch (status) {
        case "success":
            swal("Congratulations!", "Account created successfully", "success");
            break;

        case "userIsSignedUp":
            swal("Oops!", "This combination of login and password might already been taken!", "error");
            break;

        case "serverRegUserError":
            swal("Wow!", "Server can't register the user right now!");
            break;

        case "invalidLogin":
            swal("Oops!", "Please, enter a proper login!", "error");
            break;

        case "invalidPassword":
            swal("Oops!", "Please, enter a proper password!", "error");
            break;

        case "invalidReenteredPassword":
            swal("Oops!", "Password and confirm password mismatch!", "error");
            break;

        case "invalidEmail":
            swal("Oops!", "Please, enter a proper email!", "error");
            break;
    }

</script>

</body>
</html>
