<%@ page import="com.company.utils.InputPatterns" %><%--
  Created by IntelliJ IDEA.
  User: andrew
  Date: 29.05.2022
  Time: 19:28
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>calculate</title>
    <link rel="stylesheet" href="css/styles.css">
</head>
<body>

<input type="hidden" id="result" value="<%= request.getAttribute("result")%>">


<%@ include file="header.jsp" %>


<div class="body-content" style="text-align: center;">
    <h1 class="title-main">Calculate the cost of the service:</h1>
    <hr>
    <table style="width: 100%; padding: 20px 0;">
        <tbody style="text-align: center;">
        <tr>
            <td style="padding: 5px 10px">
                <form method="post" action="calculatePrice">

                    <input required class="input" type="text" name="distance" placeholder="Distance"
                           pattern="<%= InputPatterns.distance.getPattern() %>"
                           style="margin: 0 5px; padding: 4px 2px">

                    <input required class="input" type="text" name="pricePerKm" placeholder="Price per km (UAH)"
                           pattern="<%= InputPatterns.price_per_km.getPattern() %>"
                           style="margin: 0 5px; padding: 4px 2px">
                    <br>
                    <input class="button" type="submit" value="Calculate"
                           style="padding: 4px 2px;">
                </form>
            </td>
        </tr>
        </tbody>
    </table>
</div>

<%-- Sweet Alert --%>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<link rel="stylesheet" href="alert/dist/sweetalert.css">

<script type="text/javascript">

    var y = document.getElementById("result").value;
    var result = Math.round(y * 100) / 100;
    if (isNaN(result)) {
        /* do nothing */
    } else if (result != null) {
        swal("Congrats!", "Total cost of the service is " + result + " UAH", "success");
    } else {
        swal("Oops!", "Something went wrong!", "error");
    }

</script>


<%@ include file="footer.jsp" %>

</body>
</html>
