<%--
  Created by IntelliJ IDEA.
  User: andrew
  Date: 28.05.2022
  Time: 14:27
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="t" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>

<html>
<head>
    <title>table</title>

    <%--<link href="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet">--%>
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
    <link rel="stylesheet"
          href="http://cdn.datatables.net/1.10.2/css/jquery.dataTables.min.css">
    </style>
    <script type="text/javascript"
            src="http://cdn.datatables.net/1.10.2/js/jquery.dataTables.min.js"></script>
    <script type="text/javascript"
            src="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>

</head>
<body>

<%@ include file="header.jsp" %>


<div class="body-content" style="text-align: center;">

    <% if (session.getAttribute("role") != null) {
        if (session.getAttribute("role") == Role.AUTHORIZED) {%>
    <%@ include file="table_user-orders.jsp" %>
    <%
            }
        }
    %>

    <h1 class="title-main">Останні замовлення на перевезення Україна — Україна</h1>
    <div style="margin-bottom: 20px;">
        (вартість перевезення, розцінки - короткий огляд останніх замовлень)
    </div>

    <%-- Table from FOREACH cycle --%>
    <table cellpadding="4"
           cellspacing="1"
           width="100%"
           id="myTable" class="table table-hover table-striped"
           style="margin-top:10px; user-select: none;">
        <thead style="text-align: center; vertical-align: middle;">
        <tr>
            <th style="width:90px;">Дата (РРРР-ММ-ДД)</th>
            <th style="width:600px;">Маршрут</th>
            <th style="width:90px;">Відстань (км)</th>
            <th style="width:90px;">Вантаж (т)</th>
            <th style="width:150px;">Підсумкова вартість (грн)</th>
            <th style="width:100px;">Тариф (грн/км)</th>
        </tr>
        </thead>
        <tbody>

        <jsp:useBean id="trafficList" scope="request" type="java.util.List"/>
        <t:forEach var="item" items="${trafficList}">
            <tr>
                <td style="text-align-last: center;">
                        ${item.date}</td>
                <td>${item.routeFrom} — ${item.routeTo}</td>
                <td>${item.distance}</td>
                <td>${item.cargo}</td>
                <td>${item.totalPrice}</td>
                <td>${item.pricePerKm}</td>
            </tr>
        </t:forEach>
        </tbody>
    </table>

</div>


<%@ include file="footer.jsp" %>


<script>
    $(document).ready(function () {
        $('#myTable').dataTable();
    });
</script>

</body>
</html>
