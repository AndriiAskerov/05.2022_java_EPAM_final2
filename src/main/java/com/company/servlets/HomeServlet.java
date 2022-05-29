package com.company.servlets;

import com.company.model.Role;
import com.company.utils.InputPatterns;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.regex.Pattern;

@WebServlet("/home")
public class HomeServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();

        Role role = (Role) session.getAttribute("role");
        RequestDispatcher dispatcher;

        if (role == null) {
            dispatcher = req.getRequestDispatcher("index.jsp");
            dispatcher.forward(req, resp);
        }
        if (role.equals(Role.MANAGER)) {
            dispatcher = req.getRequestDispatcher("menu_manager.jsp");
            dispatcher.forward(req, resp);
        } else if (role.equals(Role.AUTHORIZED)) {
            dispatcher = req.getRequestDispatcher("menu_user.jsp");
            dispatcher.forward(req, resp);
        }
    }
}
