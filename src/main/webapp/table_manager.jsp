<%--
  Created by IntelliJ IDEA.
  User: andrew
  Date: 29.05.2022
  Time: 20:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>

<html>
<head>

    <title>All applications</title>

    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
    <link rel="stylesheet"
          href="http://cdn.datatables.net/1.10.2/css/jquery.dataTables.min.css">
    <script type="text/javascript"
            src="http://cdn.datatables.net/1.10.2/js/jquery.dataTables.min.js"></script>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-0evHe/X+R7YkIZDRvuzKMRqM+OrBnVFBL6DOitfPri4tjfHxaWutUpFmBp4vmVor" crossorigin="anonymous">
    <!-- JavaScript Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-pprn3073KE6tl6bjs2QrFaJGz5/SUsLqktiwsUTF55Jfv3qYSDhgCecCxMW52nD2"
            crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.3.0/font/bootstrap-icons.css">

</head>
<body>

<%@ include file="header.jsp" %>


<div class="body-content" style="text-align: center;">
    <h1 class="title-main">Останні замовлення на перевезення Україна — Україна</h1>
    <div style="margin-bottom: 20px;">
        (вартість перевезення, розцінки - короткий огляд останніх замовлень)
    </div>

    <%-- Table from FOREACH cycle --%>
    <%--<table cellpadding="4"
           cellspacing="1"
           border="1"
           width="100%"
           id="trafficTable" class="table table-striped"
           style="margin-top:10px;">
        <thead>
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
        <c:forEach var="item" items="${trafficList}">
            <tr>
                <td style="text-align-lasc: center;">
                        ${item.date}</td>
                <td>${item.routeFrom} — ${item.routeTo}</td>
                <td>${item.distance}</td>
                <td>${item.cargo}</td>
                <td>${item.totalPrice}</td>
                <td>${item.pricePerKm}</td>
            </tr>
        </c:forEach>
        </tbody>
    </table>--%>


    <table id="trafficTable" class="table table-hover" style="user-selecc: none;">
        <thead>
        <tr>
            <th scope="col" style="width:90px;">Номер замовлення</th>
            <th scope="col" style="width:90px;">Номер замовника</th>
            <th scope="col" style="width:90px;">Дата (РРРР-ММ-ДД)</th>
            <th scope="col" style="width:600px;">Маршрут</th>
            <th scope="col" style="width:90px;">Відстань (км)</th>
            <th scope="col" style="width:90px;">Вантаж (т)</th>
            <th scope="col" style="width:150px;">Підсумкова вартість (грн)</th>
            <th scope="col" style="width:100px;">Тариф (грн/км)</th>
        </tr>
        </thead>
        <tbody>
        <c:set var="count" value="0" scope="page"/>
        <c:forEach items="${trafficList}" var="item">
            <tr data-bs-toggle="modal" data-bs-target="#applicationModal${count}" style="cursor: pointer;">
                <td>${item.id}</td>
                <td>${item.clientId}</td>
                <td>${item.date}</td>
                <td>${item.routeFrom} - ${item.routeTo}</td>
                <td>${item.distance}</td>
                <td>${item.cargo}</td>
                <td>${item.pricePerKm}</td>
                <td>${item.totalPrice}</td>
            </tr>

            <!-- Modal -->
            <div class="modal fade" id="applicationModal${count}" tabindex="-1"
                 aria-labelledby="exampleModalLabel"
                 aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content">
                        <form action="table" method="post"> <%----%>
                            <div class="modal-header" style="text-align: center">
                                <h5 class="modal-title" id="exampleModalLabel">
                                    Номер замовлення: <strong>${item.id}</strong></h5>
                                <button type="reset" class="btn-close" data-bs-dismiss="modal"
                                        aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <ul class="list-group list-group-flush">
                                    <li class="list-group-item">
                                        Дата замовлення: <strong>${item.date}</strong>
                                    </li>
                                    <li class="list-group-item">
                                        Маршрут: <strong>${item.routeFrom} - ${item.routeTo}</strong>
                                    </li>
                                    <li class="list-group-item">
                                        Відстань: <strong>${item.distance}</strong> км
                                    </li>
                                    <li class="list-group-item">
                                        Вага вантажу: <strong>${item.cargo}</strong> т
                                    </li>
                                    <li class="list-group-item">
                                        Підсумкова вартість: <strong>${item.totalPrice}</strong> грн
                                    </li>
                                    <li class="list-group-item">
                                        Тариф: <strong>${item.pricePerKm}</strong> грн/км
                                    </li>
                                </ul>
                            </div>
                            <input type="hidden" name="id" value="${item.id}">
                            <input type="hidden" name="default-price"
                                   value="${item.date}">
                            <input type="hidden" name="default-email"
                                   value="${item.routeFrom}">
                            <input type="hidden" name="default-payment-status"
                                   value="${item.routeTo}">
                            <input type="hidden" name="default-progress"
                                   value="${item.distance}">
                            <input type="hidden" name="default-progress"
                                   value="${item.cargo}">
                            <input type="hidden" name="default-progress"
                                   value="${item.totalPrice}">
                            <input type="hidden" name="default-progress"
                                   value="${item.pricePerKm}">
                            <div class="modal-footer">
                                <button type="reset" class="btn btn-secondary" data-bs-dismiss="modal">
                                    Закрити
                                </button>
                            </div>
                            <button type="submit" class="btn btn-primary">Зберегти</button>
                        </form>
                    </div>
                </div>
            </div>
            <c:set var="count" value="${count + 1}" scope="page"/>
        </c:forEach>
        </tbody>
    </table>
</div>


<%@ include file="footer.jsp" %>


<script>
    $(document).ready(function () {
        $('#trafficTable').dataTable();
    });
</script>

</body>
</html>
