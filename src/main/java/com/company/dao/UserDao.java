package com.company.dao;

import com.company.connection.HikariCPDataSource;
import com.company.model.Role;
import com.company.model.User;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserDao implements Dao {

    private static final String SQL_ADD_USER = "INSERT INTO users (login, password, email, role) VALUES (?, ?, ?, ?)";
    private static final String SQL_GET_USER_BY_LOGIN_PAIR = "SELECT * FROM users WHERE login=(?) AND password=(?)";
    private static final String SQL_GET_USER_BY_ID = "SELECT * FROM users WHERE id=(?)";

    @Override
    public boolean create(Object entity) {
        boolean flag;
        User person = (User) entity;

        Connection connection = null;
        PreparedStatement pStatement = null;
        try {
            connection = HikariCPDataSource.getConnection();
            pStatement = connection.prepareStatement(SQL_ADD_USER);

            pStatement.setString(1, person.getLogin());
            pStatement.setString(2, person.getPassword());
            pStatement.setString(3, person.getEmail());
            pStatement.setString(4, String.valueOf(person.getRole()));
            // TODO role

            pStatement.execute();
            flag = true; // user added successfully

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
        return null;
    }

    @Override
    public Object findEntityById(Object id) {
        User user;

        Connection connection = null;
        PreparedStatement pStatement = null;
        try {
            connection = HikariCPDataSource.getConnection();
            pStatement = connection.prepareStatement(SQL_GET_USER_BY_ID);

            pStatement.setInt(1, (Integer) id);
            ResultSet resultSet = pStatement.executeQuery();

            resultSet.next();

            // user was found => init him
            user = new User().newBuilder()
                    .setId(resultSet.getInt("id"))
                    .setLogin(resultSet.getString("login"))
                    .setEmail(resultSet.getString("email"))
                    .setRole(Role.valueOf(resultSet.getString("role")))
                    .build();

        } catch (SQLException e) {
            e.printStackTrace();
            user = new User(); // init user via blanc values
        } finally {
            close(pStatement);
            close(connection);
        }

        return user;
    }

    @Override
    public Object update(Object entity) {
        return null;
    }

    @Override
    public boolean delete(Object id) {
        return false;
    }

    public boolean isUserExist(final String login, final String password) {
        boolean flag = false;

        Connection connection = null;
        PreparedStatement pStatement = null;
        try {
            connection = HikariCPDataSource.getConnection();
            pStatement = connection.prepareStatement(SQL_GET_USER_BY_LOGIN_PAIR);


            pStatement.setString(1, login);
            pStatement.setString(2, password);
            ResultSet resultSet = pStatement.executeQuery();

            if (getListOfUsersFromResult(resultSet).size() != 0) {
                flag = true; // user was found
            }

        } catch (SQLException e) {
            e.printStackTrace();
            flag = false;
        } finally {
            close(pStatement);
            close(connection);
        }
        return flag;
    }

    public User getUserByLoginPassword(final String login, final String password) {
        User user;

        Connection connection = null;
        PreparedStatement pStatement = null;
        try {
            connection = HikariCPDataSource.getConnection();
            pStatement = connection.prepareStatement(SQL_GET_USER_BY_LOGIN_PAIR);

            pStatement.setString(1, login);
            pStatement.setString(2, password);
            ResultSet resultSet = pStatement.executeQuery();

            resultSet.next();
            // user was found => init him
            user = new User().newBuilder()
                    .setLogin(resultSet.getString("login"))
                    .setPassword(resultSet.getString("password"))
                    .setEmail(resultSet.getString("email"))
                    .setRole(Role.valueOf(resultSet.getString("role")))
                    .build();

        } catch (SQLException e) {
            e.printStackTrace();
            user = new User(); // init user via blanc values
        } finally {
            close(pStatement);
            close(connection);
        }

        return user;
    }

    private List<User> getListOfUsersFromResult(ResultSet resultSet) throws SQLException {
        List<User> userList = new ArrayList<>();
        while (resultSet.next()) {
            // user was found => init him;
            userList.add(new User().newBuilder()
                    .setLogin(resultSet.getString("login"))
                    .setPassword(resultSet.getString("password"))
                    .setEmail(resultSet.getString("email"))
                    .setRole(Role.valueOf(resultSet.getString("role")))
                    .build());
        }
        return userList;
    }
}
