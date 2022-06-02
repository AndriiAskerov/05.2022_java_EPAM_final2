<%@ page import="com.company.utils.InputPatterns" %><%--
  Created by IntelliJ IDEA.
  User: andrew
  Date: 01.06.2022
  Time: 14:21
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>

<html>
<head>

    <title>table_user-orders</title>

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

<div style="margin-bottom: 40px;">
    <h1 class="title-main">Ваші останні замовлення:</h1>
    <div style="margin-bottom: 20px;">
        (короткий огляд останніх замовлень клієнта <strong><%= session.getAttribute("login") %>
    </strong>, ID: <strong><%= session.getAttribute("id") %>
    </strong>)
    </div>

    <%-- Table from FOREACH cycle --%>
    <table id="userOrderTable" class="table table-hover table-striped" style="user-select: none;" width="100%">
        <thead style="text-align: center; vertical-align: middle;">
        <tr>
            <th scope="col" style="width:50px;">Номер замовлення</th>
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
        <c:forEach items="${userOrderList}" var="item">

            <tr data-bs-toggle="modal" data-bs-target="#userOrderModal${count}" style="cursor: pointer;">
                <td>${item.id}</td>
                <td>${item.date}</td>
                <td>${item.routeFrom} - ${item.routeTo}</td>
                <td>${item.distance}</td>
                <td>${item.cargo}</td>
                <td>${item.totalPrice}</td>
                <td>${item.pricePerKm}</td>
                <td>${item.status}</td>
            </tr>

            <c:set var="count" value="${count + 1}" scope="page"/>
        </c:forEach>
        </tbody>
    </table>

    <div style="margin: 20px 0 50px; text-align: left;">
        <div>
            <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#createNewModal">
                <i class="bi bi-clipboard-plus"></i><span style="padding: 5px 10px">
                Create new
            </span>
            </button>

            <!-- NewOrder Modal -->
            <div class="modal fade" id="createNewModal" tabindex="-1"
                 aria-labelledby="createNewModalLabel"
                 aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content">

                        <form action="createTraffic" method="post"> <%-- FORM --%>
                            <div class="modal-header" style="text-align: center">
                                <h5 class="modal-title" id="createNewModalLabel">Create new order</h5>
                                <button type="reset" class="btn-close" data-bs-dismiss="modal"
                                        style="margin-right: 1px;"
                                        aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <ul class="list-group list-group-flush">
                                    <li class="list-group-item" style="padding-bottom: 20px;">
                                        <h5 style="text-align: left; margin: 0 0 10px 0;">
                                            Дата замовлення:</h5>

                                        <div style="display: flex; justify-content: left">
                                            <input name="nt_date" type="left" required placeholder="Date (YYYY-MM-DD)"
                                                   pattern="<%= InputPatterns.date.getPattern() %>"><br>
                                        </div>
                                    </li>
                                    <li class="list-group-item" style="padding-bottom: 20px;">
                                        <h5 style="text-align: left; margin: 10px 0 10px 0;">
                                            Маршрут:</h5>

                                        <div style="display: flex; justify-content: left">
                                            <input name="nt_routeFrom" type="text" required placeholder="Route From ( name_city )"
                                                   pattern="<%= InputPatterns.city.getPattern() %>">
                                            <span style="margin: 0 20px;">-</span>
                                            <input name="nt_routeTo" type="text" required placeholder="Route To ( name_city )"
                                                   pattern="<%= InputPatterns.city.getPattern() %>">
                                        </div>
                                    </li>
                                    <li class="list-group-item" style="padding-bottom: 20px;">
                                        <h5 style="text-align: left; margin: 10px 0 10px 0;">
                                            Відстань:</h5>

                                        <div style="display: flex; justify-content: left">
                                            <input name="nt_distance" type="text" required placeholder="Distance ( km )"
                                                   pattern="<%= InputPatterns.distance.getPattern() %>"><br>
                                        </div>
                                    </li>
                                    <li class="list-group-item" style="padding-bottom: 20px;">
                                        <h5 style="text-align: left; margin: 10px 0 10px 0;">
                                            Вага вантажу:</h5>

                                        <div style="display: flex; justify-content: left">
                                            <input name="nt_cargo" type="text" required placeholder="Cargo ( t )"
                                                   pattern="<%= InputPatterns.cargo.getPattern() %>"><br>
                                        </div>
                                    </li>
                                    <li class="list-group-item" style="padding-bottom: 20px;">
                                        <h5 style="text-align: left; margin: 10px 0 10px 0;">
                                            Тариф:</h5>

                                        <div style="display: flex; justify-content: left">
                                            <input name="nt_pricePerKm" type="text" required placeholder="Price Per Km ( 00.00 UAH )"
                                                   pattern="<%= InputPatterns.price_per_km.getPattern() %>"><br>
                                        </div>
                                    </li>
                                </ul>
                            </div>
                            <div class="modal-footer" style="justify-content: center;">
                                <%--<button type="reset" class="btn-close" data-bs-dismiss="modal"
                                        style="margin-right: 1px;"
                                        aria-label="Close"></button>--%>
                                <button type="reset" class="btn btn-secondary" data-bs-dismiss="modal"
                                        style="margin: 15px; width: 400px;">
                                    Відхилити
                                </button>
                                <br>
                                <button type="submit" class="btn btn-primary" style="margin: 15px; width: 400px;">
                                    Створити
                                </button>
                            </div>
                        </form>

                    </div>
                </div>
            </div>
        </div>
    </div>

</div>

<%-- Table script --%>
<script>
    $(document).ready(function () {
        $('#userOrderTable').dataTable();
    });
</script>

</body>
</html>
