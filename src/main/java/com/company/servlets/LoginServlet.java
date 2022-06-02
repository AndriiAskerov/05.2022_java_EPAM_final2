package com.company.servlets;

import com.company.dao.UserDao;
import com.company.model.Role;
import com.company.model.User;
import com.company.utils.InputPatterns;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.concurrent.atomic.AtomicReference;
import java.util.regex.Pattern;

public class LoginServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String login = req.getParameter("login");
        String password = req.getParameter("password");

        HttpSession session = req.getSession();
        RequestDispatcher dispatcher;

        if (login == null || login.equals("")) {
            req.setAttribute("status", "invalidLogin");
            dispatcher = req.getRequestDispatcher("login.jsp");
            dispatcher.forward(req, resp);
            return;
        }
        if (!Pattern.matches(InputPatterns.password.getPattern(), password)) {
            req.setAttribute("status", "invalidPassword");
            dispatcher = req.getRequestDispatcher("login.jsp");
            dispatcher.forward(req, resp);
            return;
        }

        @SuppressWarnings("unchecked")
        AtomicReference<UserDao> userDao = (AtomicReference<UserDao>) getServletContext().getAttribute("userDao");

        try {
            if (userDao.get().isUserExist(login, password)) {
                // if user is already in the database:
                User user = userDao.get().getUserByLoginPassword(login, password);
                session.setAttribute("id", user.getId());
                session.setAttribute("login", user.getLogin());
                session.setAttribute("password", user.getPassword());
                session.setAttribute("email", user.getEmail());
                session.setAttribute("role", user.getRole());

                dispatcher = req.getRequestDispatcher("index.jsp");
            } else {
                // there is no such user at the database:
                req.setAttribute("status", "noSuchUser");

                dispatcher = req.getRequestDispatcher("login.jsp");
            }

            dispatcher.forward(req, resp);
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }
}
