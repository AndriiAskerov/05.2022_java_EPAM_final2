package com.company.servlets;

import com.company.dao.TrafficDao;
import com.company.model.Role;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import java.util.concurrent.atomic.AtomicReference;

public class TableServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        HttpSession session = req.getSession();
        Role role = (Role) session.getAttribute("role");

        @SuppressWarnings("unchecked")
        AtomicReference<TrafficDao> trafficDao = (AtomicReference<TrafficDao>) getServletContext().getAttribute("trafficDao");

        @SuppressWarnings("unchecked")
        List trafficList = (List) trafficDao.get().findAll();

        if (trafficList.size() == 0) {
            req.setAttribute("status", "trafficListIsEmpty");
            // TODO redirect to the seme page + show failed popUP
            req.getRequestDispatcher("index.jsp").forward(req, resp);
        } else {
            // trafficList contains data:
            req.setAttribute("trafficList", trafficList);

            if (role == null) {
                req.getRequestDispatcher("table.jsp").forward(req, resp);
            } else if (role.equals(Role.AUTHORIZED)) {
                req.getRequestDispatcher("table.jsp").forward(req, resp);
            } else if (role.equals(Role.MANAGER)) {
                req.getRequestDispatcher("table_manager.jsp").forward(req, resp);
            }
        }
    }
}
