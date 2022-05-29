package com.company.dao;

import com.company.connection.HikariCPDataSource;
import com.company.model.Role;
import com.company.model.User;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserDao implements Dao {

    private static final String SQL_ADD_USER = "INSERT INTO testindian.users (login, password, email, role) VALUES (?, ?, ?, ?)";
    private static final String SQL_GET_USER_BY_LOGIN_PAIR = "SELECT * FROM testIndian.users WHERE login=(?) AND password=(?)";
    /*private static final String SQL_GET_USER_BY_ID = "SELECT * FROM testIndian.users WHERE id=(?)";*/

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
        return null;
        /*User user;

        Connection connection = null;
        PreparedStatement pStatement = null;
        try {
            connection = HikariCPDataSource.getConnection();
            pStatement = connection.prepareStatement(SQL_GET_USER_BY_ID);

            pStatement.setInt(1, id);
            ResultSet resultSet = pStatement.executeQuery();

            resultSet.next();
            int resultId = resultSet.getInt("id");
            String first_name = resultSet.getString("first_name");
            String last_name = resultSet.getString("last_name");
            String login = resultSet.getString("login");
            String password = resultSet.getString("password");
            String role = resultSet.getString("role");

            // user was found => init him
            user = new User(resultId, first_name, last_name, login, password, User.ROLE.valueOf(role));

        } catch (SQLException e) {
            e.printStackTrace();
            user = new User(); // init user via blanc values
        } finally {
            close(pStatement);
            close(connection);
        }

        return user;*/
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
            String email = resultSet.getString("email");
            String role = resultSet.getString("role");

            // user was found => init him
            user = new User(login, password, email, Role.valueOf(role));

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
        List<User> users = new ArrayList<>();
        while (resultSet.next()) {
            String login = resultSet.getString("login");
            String password = resultSet.getString("password");
            String email = resultSet.getString("email");
            String role = resultSet.getString("role");

            // user was found => init him
            users.add(new User(login, password, email, Role.valueOf(role)));
        }
        return users;
    }
}
