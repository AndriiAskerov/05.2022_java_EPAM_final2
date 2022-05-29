package com.company;

import com.company.dao.TrafficDao;
import com.company.dao.UserDao;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;
import java.util.concurrent.atomic.AtomicReference;

@WebListener
public class ContextListener implements ServletContextListener {
    private AtomicReference<UserDao> userDao;
    private AtomicReference<TrafficDao> trafficDao;

    @Override
    public void contextInitialized(ServletContextEvent servletContextEvent) {
        System.out.println("contextListener init");

        final ServletContext servletContext = servletContextEvent
                .getServletContext();

        userDao = new AtomicReference<>(new UserDao());
        trafficDao = new AtomicReference<>(new TrafficDao());

        servletContext.setAttribute("userDao", userDao);
        servletContext.setAttribute("trafficDao", trafficDao);
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        userDao = null;
        System.out.println("contextListener destroy");
    }
}