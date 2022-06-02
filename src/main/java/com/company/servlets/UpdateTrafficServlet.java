package com.company.servlets;

import com.company.dao.TrafficDao;
import com.company.model.Traffic;
import com.company.model.TrafficStatus;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.concurrent.atomic.AtomicReference;

@WebServlet("/updateTraffic")
public class UpdateTrafficServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int t_id = Integer.parseInt(req.getParameter("default-id"));
        String new_status = req.getParameter("change-status");
        /*int t_clientId = Integer.parseInt(req.getParameter("default-clientId"));*/

        @SuppressWarnings("unchecked")
        AtomicReference<TrafficDao> trafficDao = (AtomicReference<TrafficDao>) getServletContext().getAttribute("trafficDao");
        Traffic traffic = (Traffic) trafficDao.get().findEntityById(t_id);

        traffic.setStatus(TrafficStatus.valueOf(new_status));

        trafficDao.get().update(traffic);
        req.getRequestDispatcher("table").forward(req, resp);
        /*resp.sendRedirect("table_manager");*/
    }
}
