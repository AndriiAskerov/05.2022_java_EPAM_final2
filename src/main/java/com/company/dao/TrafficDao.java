package com.company.dao;

import com.company.connection.HikariCPDataSource;
import com.company.model.Traffic;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class TrafficDao implements Dao{

    private static final String SQL_ADD_TRAFFIC = "INSERT INTO testindian.traffic (" +
            "id," +
            "date, " +
            "route_from, " +
            "route_to, " +
            "distance, " +
            "cargo, " +
            "price_per_km, " +
            "total_price) " +
            "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
    private static final String SQL_GET_ALL_TRAFFIC = "SELECT * FROM traffic";
    private static final String SQL_GET_TRAFFIC_BY_ID = "SELECT * FROM testIndian.users WHERE login=(?) AND password=(?)";
    private static final String SQL_UPDATE_TRAFFIC = "UPDATE traffic SET " +
            "date=(?), " +
            "route_from=(?), " +
            "route_to=(?), " +
            "distance=(?), " +
            "cargo=(?), " +
            "price_per_km=(?), " +
            "total_price=(?) " +
            "WHERE id=(?)";
    private static final String SQL_DELETE_TRAFFIC = "DELETE FROM traffic WHERE id=(?)";

    @Override
    public boolean create(Object entity) {
        boolean flag;
        Traffic traffic = (Traffic) entity;

        Connection connection = null;
        PreparedStatement pStatement = null;
        try {
            connection = HikariCPDataSource.getConnection();
            pStatement = connection.prepareStatement(SQL_ADD_TRAFFIC);

            pStatement.setInt(1, traffic.getId());
            pStatement.setDate(2, traffic.getDate());
            pStatement.setString(3, traffic.getRouteFrom());
            pStatement.setString(4, traffic.getRouteTo());
            pStatement.setInt(5, traffic.getDistance());
            pStatement.setDouble(6, traffic.getCargo());
            pStatement.setDouble(7, traffic.getPricePerKm());
            pStatement.setDouble(8, traffic.getTotalPrice());

            pStatement.execute();
            flag = true; // traffic added successfully

        } catch (SQLException e) {
            e.printStackTrace();
            flag = false;
        } finally {
            close(pStatement);
            close(connection);
        }
        return flag;
    }

    @Override
    public List findAll() {
        List<Traffic> output = new ArrayList<>();
        Connection connection = null;
        Statement statement = null;
        try {
            connection = HikariCPDataSource.getConnection();
            statement = connection.createStatement();

            ResultSet result = statement.executeQuery(SQL_GET_ALL_TRAFFIC);
            output = getTrafficListFromResult(result);

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            close(statement);
            close(connection);
        }
        return output;
    }

    @Override
    public Object findEntityById(Object id) {
        Traffic movie = new Traffic();

        Connection connection = null;
        PreparedStatement pStatement = null;
        try {
            connection = HikariCPDataSource.getConnection();
            pStatement = connection.prepareStatement(SQL_GET_TRAFFIC_BY_ID);
            pStatement.setInt(1, (Integer) id);

            ResultSet result = pStatement.executeQuery();
            movie = getTrafficListFromResult(result).remove(0);

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            close(pStatement);
            close(connection);
        }
        return movie;
    }

    @Override
    public Object update(Object entity) {
        Traffic newTraffic = (Traffic) entity;
        Traffic oldTraffic = new Traffic();

        Connection connection = null;
        PreparedStatement pStatement = null;
        try {
            connection = HikariCPDataSource.getConnection();

            // пошук елемента, що буде оновлено:
            pStatement = connection.prepareStatement(SQL_GET_TRAFFIC_BY_ID);
            pStatement.setInt(1, (newTraffic.getId()));
            ResultSet result = pStatement.executeQuery();
            oldTraffic = getTrafficListFromResult(result).remove(0);

            // оновлення:
            pStatement = connection.prepareStatement(SQL_UPDATE_TRAFFIC);
            pStatement.setDate(1, newTraffic.getDate());
            pStatement.setString(2, newTraffic.getRouteFrom());
            pStatement.setString(3, newTraffic.getRouteTo());
            pStatement.setInt(4, newTraffic.getDistance());
            pStatement.setDouble(5, newTraffic.getCargo());
            pStatement.setDouble(6, newTraffic.getPricePerKm());
            pStatement.setDouble(7, newTraffic.getTotalPrice());
            pStatement.setInt(8, newTraffic.getId());
            pStatement.executeQuery();

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            close(pStatement);
            close(connection);
        }
        // повернення старої інфорамаціїї елемента (до його оновлення)
        return oldTraffic;
    }

    @Override
    public boolean delete(Object id) {
        boolean flag;

        Connection connection = null;
        PreparedStatement pStatement = null;
        try {
            connection = HikariCPDataSource.getConnection();
            pStatement = connection.prepareStatement(SQL_DELETE_TRAFFIC);

            pStatement.setInt(1, (Integer) id);
            pStatement.executeQuery();
            flag = true;

        } catch (SQLException e) {
            e.printStackTrace();
            flag = false;
        } finally {
            close(pStatement);
            close(connection);
        }
        return flag;
    }

    /* additional method */
    private List<Traffic> getTrafficListFromResult(ResultSet resultSet) throws SQLException {
        List<Traffic> trafficList = new ArrayList<>();
        while (resultSet.next()) {
            int id = resultSet.getInt("id");
            Date date = resultSet.getDate("date");
            String route_from = resultSet.getString("route_from");
            String route_to = resultSet.getString("route_to");
            int distance = resultSet.getInt("distance");
            double cargo = resultSet.getDouble("cargo");
            double price_per_km = resultSet.getDouble("price_per_km");
            double total_price = resultSet.getDouble("total_price");

            // user was found => init him
            trafficList.add(new Traffic(id, date, route_from, route_to, distance, cargo, price_per_km, total_price));
        }
        return trafficList;
    }
}
