<%--
  Created by IntelliJ IDEA.
  User: andrew
  Date: 27.05.2022
  Time: 13:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>menu_manager</title>
</head>
<body>

<%@ include file="header.jsp" %>


<div class="body-content">
    <h1>Welcome, manager <%= session.getAttribute("login").toString() %>!</h1>
</div>


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
