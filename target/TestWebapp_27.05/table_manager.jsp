<%@ page import="com.company.model.User" %><%--
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
    <table id="trafficTable" class="table table-hover" style="user-select: none;">
        <thead>
        <tr>
            <th scope="col" style="width:50px;">Номер замовлення</th>
            <th scope="col" style="width:50px;">Номер замовника</th>
            <th scope="col" style="width:90px;">Дата (РРРР-ММ-ДД)</th>
            <th scope="col" style="width:600px;">Маршрут</th>
            <th scope="col" style="width:90px;">Відстань (км)</th>
            <th scope="col" style="width:90px;">Вантаж (т)</th>
            <th scope="col" style="width:150px;">Підсумкова вартість (грн)</th>
            <th scope="col" style="width:100px;">Тариф (грн/км)</th>
            <th scope="col" style="width:100px;">Статус</th>
        </tr>
        </thead>
        <tbody>
        <c:set var="count" value="0" scope="page"/>
        <c:forEach items="${trafficList}" var="item">
            <tr data-bs-toggle="modal" data-bs-target="#trafficModal${count}" style="cursor: pointer;">
                <td>${item.id}</td>
                <td>${item.clientId}</td>
                <td>${item.date}</td>
                <td>${item.routeFrom} - ${item.routeTo}</td>
                <td>${item.distance}</td>
                <td>${item.cargo}</td>
                <td>${item.pricePerKm}</td>
                <td>${item.totalPrice}</td>
                <td>${item.status}</td>
            </tr>

            <!-- Traffic Modal -->
            <div class="modal fade" id="trafficModal${count}" tabindex="-1"
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
                                        Номер замовника:
                                        <input type="text" name="clientId" value="${item.clientId}" disabled style="width: 70px; border: none; text-align: center;">
                                            <%--<strong> ( <button type="submit" style="border: none; background: none; text-decoration: underline;">
                                                профіль
                                            </button> ) </strong>--%> <%-- TODO implement logic: check out client's profile --%>
                                    </li>
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
                                        <c:if test="${item.status.equals('PENDING')}">
                                            <input type="number" name="set-price" step="0.10"
                                                   min="${item.pricePerKm}" value="${item.pricePerKm}">
                                        </c:if>
                                    </li>
                                    <li class="list-group-item">
                                        Статус: <strong>${item.status}</strong>
                                        <select name="change-status">
                                            <c:forTokens items="COMPLETED,PENDING,DECLINED" delims=","
                                                         var="status">
                                                <c:if test="${!item.status.equals(status)}">
                                                    <option>${status}</option>
                                                </c:if>
                                            </c:forTokens>
                                        </select>
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
                            <button type="submit" class="btn btn-primary" style="margin: 0 15px 15px;">
                                Зберегти
                            </button>
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

<%-- Table script --%>
<script>
    $(document).ready(function () {
        $('#trafficTable').dataTable();
    });
</script>

</body>
</html>
