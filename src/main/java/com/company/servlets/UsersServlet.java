package com.company.servlets;

import com.company.dao.UserDao;
import com.company.model.Role;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.concurrent.atomic.AtomicReference;

@WebServlet("/usersTable")
public class UsersServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        @SuppressWarnings("unchecked")
        AtomicReference<UserDao> userDao = (AtomicReference<UserDao>) getServletContext().getAttribute("userDao");
        List userList = userDao.get().getUsersByRole(Role.AUTHORIZED);

        if (userList.size() == 0) {
            req.setAttribute("status", "userListIsEmpty");
            // redirect to the home page + show failed popUP
            req.getRequestDispatcher("home").forward(req, resp);
        } else {
            // userList contains data:
            req.setAttribute("userList", userList);

            req.getRequestDispatcher("users-table_manager.jsp").forward(req, resp);
        }
    }
}
