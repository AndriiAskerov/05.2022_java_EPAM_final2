<%@ page import="com.company.model.Role" %><%--
  Created by IntelliJ IDEA.
  User: andrew
  Date: 27.05.2022
  Time: 11:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="t" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page isELIgnored="false" %>

<html>

<fmt:bundle basename="i18n_ua">
    <fmt:message key="index.head.title" var="i_h_title"/>
    <fmt:message key="index.body.title" var="i_b_title"/>
    <fmt:message key="index.body.shortInfo.title" var="i_b_sI_title"/>
    <fmt:message key="index.body.shortInfo.text" var="i_b_sI_text"/>
    <fmt:message key="index.body.shortInfo.unknown.title" var="i_b_sI_unk_title"/>
    <fmt:message key="index.body.shortInfo.unknown.text1" var="i_b_sI_unk_text1"/>
    <fmt:message key="index.body.shortInfo.unknown.text2" var="i_b_sI_unk_text2"/>
    <fmt:message key="index.body.shortInfo.auth.title" var="i_b_sI_auth_title"/>
    <fmt:message key="index.body.shortInfo.auth.text1" var="i_b_sI_auth_text1"/>
    <fmt:message key="index.body.shortInfo.auth.text2" var="i_b_sI_auth_text2"/>
    <fmt:message key="index.body.shortInfo.auth.text3" var="i_b_sI_auth_text3"/>
    <fmt:message key="index.body.slogan.main" var="i_b_slogan_main"/>
    <fmt:message key="index.body.slogan.emphasised" var="i_b_slogan_emphasised"/>
</fmt:bundle>

<head>
    <title>${h_title}</title>
    <link rel="stylesheet" href="css/styles.css">
</head>
<body>

<%@ include file="header.jsp" %>


<% if (session.getAttribute("role") == null) {%>
<%--session is new or invalidated (unknown user)--%>
<div class="body-content" style="text-align: center;">
    <h1 class="title-main">${i_b_title}</h1>
    <hr>
    <h3 style="text-align: center; margin: 20px 0;">
        ${i_b_sI_title}</h3>
    <div style="margin: 5px auto">
        ${i_b_sI_text}
    </div>
    <table style="width: 100%; padding: 20px 0;">
        <tbody>
        <tr>
            <td style="width: 50%; padding: 20px 40px; border-right: 1px solid;">
                <div>
                    <div style="text-align: center;">
                        <h4 style="padding: 8px 0">${i_b_sI_unk_title}</h4>

                    </div>
                    <div style="width: 380px; margin: 0 auto;">
                        <a href="calculate.jsp">${i_b_sI_unk_text1}</a><br>
                        <a href="table">${i_b_sI_unk_text2}</a><br>
                    </div>
                </div>
            </td>
            <td style="width: 50%; padding: 20px 40px;">
                <div>
                    <div style="text-align: center;">
                        <h4 style="padding: 8px 0">${i_b_sI_unk_title}:</h4>

                    </div>
                    <div style="width: 380px; margin: 0 auto;">
                        <a href="calculate.jsp">${i_b_sI_unk_text1}</a><br>
                        <a href="table">${i_b_sI_unk_text2}</a><br>
                        <a href="login.jsp">${i_b_sI_unk_text3}</a><br>
                    </div>
                </div>
            </td>
        </tr>
        </tbody>
    </table>
    <div style="padding: 10px 0 20px 0">
        <hr>
    </div>
    <div style="padding: 25px 10px 0">
        ${i_b_slogan_main}<strong>${i_b_slogan_emphasised}</strong>
    </div>
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
