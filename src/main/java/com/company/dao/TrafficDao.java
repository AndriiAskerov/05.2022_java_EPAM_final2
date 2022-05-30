package com.company.dao;

import com.company.connection.HikariCPDataSource;
import com.company.model.Traffic;
import com.company.model.TrafficStatus;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class TrafficDao implements Dao {

    private static final String SQL_ADD_TRAFFIC = "INSERT INTO testindian.traffic (" +
            "date, " +
            "route_from, " +
            "route_to, " +
            "distance, " +
            "cargo, " +
            "price_per_km, " +
            "total_price, " +
            "client_id, " +
            "status) " +
            "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
    private static final String SQL_GET_ALL_TRAFFIC = "SELECT * FROM traffic";
    private static final String SQL_GET_TRAFFIC_BY_ID = "SELECT * FROM testIndian.users WHERE login=(?) AND password=(?)";
    private static final String SQL_UPDATE_TRAFFIC = "UPDATE traffic SET " +
            "date=(?), " +
            "route_from=(?), " +
            "route_to=(?), " +
            "distance=(?), " +
            "cargo=(?), " +
            "price_per_km=(?), " +
            "total_price=(?), " +
            "client_id=(?), " +
            "status=(?) " +
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

            pStatement.setDate(1, traffic.getDate());
            pStatement.setString(2, traffic.getRouteFrom());
            pStatement.setString(3, traffic.getRouteTo());
            pStatement.setInt(4, traffic.getDistance());
            pStatement.setDouble(5, traffic.getCargo());
            pStatement.setDouble(6, traffic.getPricePerKm());
            pStatement.setDouble(7, traffic.getTotalPrice());
            pStatement.setDouble(8, traffic.getClientId());
            pStatement.setString(9, traffic.getStatus().name());

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
            pStatement.setDouble(8, newTraffic.getClientId());
            pStatement.setString(9, newTraffic.getStatus().name());
            pStatement.setInt(10, newTraffic.getId());
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
            // user was found => init him
            trafficList.add(new Traffic().newBuilder()
                    .setId(resultSet.getInt("id"))
                    .setDate(resultSet.getDate("date"))
                    .setRouteFrom(resultSet.getString("route_from"))
                    .setRouteTo(resultSet.getString("route_to"))
                    .setDistance(resultSet.getInt("distance"))
                    .setCargo(resultSet.getDouble("cargo"))
                    .setPricePerKm(resultSet.getDouble("price_per_km"))
                    .setTotalPrice(resultSet.getDouble("total_price"))
                    .setClientId(resultSet.getInt("client_id"))
                    .setTrafficStatus(TrafficStatus.valueOf(resultSet.getString("status")))
                    .build());
        }
        return trafficList;
    }
}
