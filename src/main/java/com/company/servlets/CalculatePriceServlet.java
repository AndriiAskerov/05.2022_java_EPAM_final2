package com.company.servlets;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/calculatePrice")
public class CalculatePriceServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doGet(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String distance = req.getParameter("distance");
        String price_per_km = req.getParameter("pricePerKm");

        RequestDispatcher dispatcher;

        double result = Double.parseDouble(distance) * Double.parseDouble(price_per_km);

        req.setAttribute("result", result);
        req.getRequestDispatcher("calculate.jsp").forward(req, resp);
    }
}
