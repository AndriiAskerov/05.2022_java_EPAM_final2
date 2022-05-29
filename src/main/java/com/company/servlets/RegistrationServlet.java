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
import java.io.IOException;
import java.util.concurrent.atomic.AtomicReference;
import java.util.regex.Pattern;

public class RegistrationServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String login = req.getParameter("login");
        String password = req.getParameter("password");
        String rePassword = req.getParameter("re-password");
        String email = req.getParameter("email");

        RequestDispatcher dispatcher;

        if (login == null || login.equals("")) {
            req.setAttribute("status", "invalidLogin");
            dispatcher = req.getRequestDispatcher("registration.jsp");
            dispatcher.forward(req, resp);
        }
        if (!Pattern.matches(InputPatterns.password.getPattern(), password)) {
            req.setAttribute("status", "invalidPassword");
            dispatcher = req.getRequestDispatcher("registration.jsp");
            dispatcher.forward(req, resp);
        } else if (!password.equals(rePassword)) {
            req.setAttribute("status", "invalidReenteredPassword");
            dispatcher = req.getRequestDispatcher("registration.jsp");
            dispatcher.forward(req, resp);
        }
        if (!Pattern.matches(InputPatterns.email.getPattern(), email)) {
            req.setAttribute("status", "invalidEmail");
            dispatcher = req.getRequestDispatcher("registration.jsp");
            dispatcher.forward(req, resp);
        }

        @SuppressWarnings("unchecked")
        AtomicReference<UserDao> userDao = (AtomicReference<UserDao>) getServletContext().getAttribute("userDao");

        try {
            dispatcher = req.getRequestDispatcher("registration.jsp");

            if (!userDao.get().isUserExist(login, password)) {
                // ... user has not been created yet
                if (userDao.get().create(new User(login, password, email, Role.AUTHORIZED))) {
                    // ... user created
                    req.setAttribute("status", "success");
                } else {
                    // ... user wasnt created
                    req.setAttribute("status", "serverRegUserError");
                }
            } else { // ... user has already been created
                req.setAttribute("status", "userIsSignedUp");
            }

            dispatcher.forward(req, resp);
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }
}
