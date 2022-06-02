package com.company.servlets;

import com.company.dao.TrafficDao;
import com.company.model.Traffic;
import com.company.model.TrafficStatus;
import com.company.utils.InputPatterns;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Date;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Objects;
import java.util.concurrent.atomic.AtomicReference;
import java.util.regex.Pattern;

@WebServlet("/createTraffic")
public class CreateTrafficServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");

        Date date = Date.valueOf(req.getParameter("nt_date"));
        String routeFrom = req.getParameter("nt_routeFrom");
        String routeTo = req.getParameter("nt_routeTo");
        int distance = Integer.parseInt(req.getParameter("nt_distance"));
        double cargo = Double.parseDouble(req.getParameter("nt_cargo"));
        double pricePerKm = Double.parseDouble(req.getParameter("nt_pricePerKm"));
        double totalPrice = ((double) distance) * pricePerKm;
        int clientId = (int) req.getSession().getAttribute("id");
        TrafficStatus status = TrafficStatus.PENDING;

        if (checkIfDataIsNotAppropriate(req, resp, date, routeFrom, routeTo, distance, cargo, pricePerKm)) return;

        @SuppressWarnings("unchecked")
        AtomicReference<TrafficDao> trafficDao = (AtomicReference<TrafficDao>) getServletContext().getAttribute("trafficDao");
        trafficDao.get().create(Traffic.newBuilder()
                .setDate(date)
                .setRouteFrom(routeFrom)
                .setRouteTo(routeTo)
                .setDistance(distance)
                .setCargo(cargo)
                .setPricePerKm(pricePerKm)
                .setTotalPrice(totalPrice)
                .setClientId(clientId)
                .setTrafficStatus(status)
                .build());

        req.getRequestDispatcher("table").forward(req, resp);
    }

    private boolean checkIfDataIsNotAppropriate(HttpServletRequest req, HttpServletResponse resp, Date date, String routeFrom, String routeTo, int distance, double cargo, double pricePerKm) throws ServletException, IOException {
        RequestDispatcher dispatcher;
        if (date == null || Objects.equals(date.toString(), "")) {
            req.setAttribute("status", "dateIsNotSpecified");
            dispatcher = req.getRequestDispatcher("table.jsp");
            dispatcher.forward(req, resp);
            return true;
        }
        if (routeFrom == null || routeFrom.equals("")) {
            /*if (!Pattern.matches(InputPatterns.city.getPattern(), routeFrom)) {
                req.setAttribute("status", "routeFromIsInvalid");
                dispatcher = req.getRequestDispatcher("table.jsp");
                dispatcher.forward(req, resp);
                return true;
            }*/
            req.setAttribute("status", "routeFromIsNotSpecified");
            dispatcher = req.getRequestDispatcher("table.jsp");
            dispatcher.forward(req, resp);
            return true;
        }
        if (routeTo == null || routeTo.equals("")) {
            /*if (!Pattern.matches(InputPatterns.city.getPattern(), routeTo)) {
                req.setAttribute("status", "routeToIsInvalid");
                dispatcher = req.getRequestDispatcher("table.jsp");
                dispatcher.forward(req, resp);
                return true;
            }*/
            req.setAttribute("status", "routeToIsNotSpecified");
            dispatcher = req.getRequestDispatcher("table.jsp");
            dispatcher.forward(req, resp);
            return true;
        }
        if (distance <= 9) {
            req.setAttribute("status", "distanceIsInvalid");
            dispatcher = req.getRequestDispatcher("table.jsp");
            dispatcher.forward(req, resp);
            return true;
        }
        if (cargo <= 0.00) {
            req.setAttribute("status", "cargoIsInvalid");
            dispatcher = req.getRequestDispatcher("table.jsp");
            dispatcher.forward(req, resp);
            return true;
        }
        if (pricePerKm <= 0.00) {
            req.setAttribute("status", "distanceIsInvalid");
            dispatcher = req.getRequestDispatcher("table.jsp");
            dispatcher.forward(req, resp);
            return true;
        }
        return false;
    }

    private boolean hasPassed(Date date) {
        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        java.util.Date test_date = new java.util.Date();

        Date currentDate = Date.valueOf(dateFormat.format(test_date));
        return currentDate.compareTo(date) <= 0 || currentDate.compareTo(date) != 0;
    }
}
