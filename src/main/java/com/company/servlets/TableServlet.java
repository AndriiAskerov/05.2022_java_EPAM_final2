package com.company.servlets;

import com.company.dao.TrafficDao;
import com.company.dao.UserDao;
import com.company.model.Role;
import com.company.model.User;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.atomic.AtomicReference;

public class TableServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        HttpSession session = req.getSession();
        Role role = (Role) session.getAttribute("role");

        @SuppressWarnings("unchecked")
        AtomicReference<TrafficDao> trafficDao = (AtomicReference<TrafficDao>) getServletContext().getAttribute("trafficDao");
        List trafficList = trafficDao.get().findAllExceptPending();
        /*trafficList = new ArrayList();*/

        if (trafficList.size() == 0) {
            // list is empty

            req.setAttribute("status", "trafficListIsEmpty");
            // redirect to the home page + show failed popUP
            req.getRequestDispatcher("home").forward(req, resp);
            return;

        } else {
            // trafficList contains data:
            req.setAttribute("trafficList", trafficList);

            if (role == null) {
                req.getRequestDispatcher("table.jsp").forward(req, resp);
                return;

            } else if (role.equals(Role.AUTHORIZED)) {
                String uLogin = (String) req.getSession().getAttribute("login");
                String uPassword = (String) req.getSession().getAttribute("password");

                @SuppressWarnings("unchecked")
                AtomicReference<UserDao> userDao = (AtomicReference<UserDao>) getServletContext().getAttribute("userDao");
                User user = userDao.get().getUserByLoginPassword(uLogin, uPassword);

                List userOrderList = (List) trafficDao.get().findEntityListByClientId(user.getId());
                req.setAttribute("userOrderList", userOrderList);

                req.getRequestDispatcher("table.jsp").forward(req, resp);
                return;

            } else if (role.equals(Role.MANAGER)) {
                trafficList = trafficDao.get().findAll();
                req.setAttribute("trafficList", trafficList);
                req.getRequestDispatcher("table_manager.jsp").forward(req, resp);
                return;
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        this.doGet(req, resp);
    }
}
