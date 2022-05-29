package com.company.connection;

import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ResourceBundle;

public class HikariCPDataSource {
    private static HikariConfig config = new HikariConfig();
    private static HikariDataSource dataSource;

    static {
        ResourceBundle resource = ResourceBundle.getBundle("database");
        config.setJdbcUrl(resource.getString("db.url"));
        config.setUsername(resource.getString("db.user"));
        config.setPassword(resource.getString("db.password"));

        config.setMaximumPoolSize(Integer.parseInt(resource.getString("db.poolsize")));

        /* fixes the "driver not found exception".. */
        config.setDriverClassName(resource.getString("db.driver"));

        /* other options from example at: https://www.baeldung.com/java-connection-pooling*/
        config.addDataSourceProperty("cachePrepStmts", "true");
        config.addDataSourceProperty("prepStmtCacheSize", "250");
        config.addDataSourceProperty("prepStmtCacheSqlLimit", "2048");

        dataSource = new HikariDataSource(config);
        System.out.println("hikariCP established");
    }

    public static Connection getConnection() throws SQLException {
        try {
            return dataSource.getConnection();
        } catch (SQLException e) {
            e.printStackTrace();
            throw new SQLException();
            // TODO implement exception method
        }
    }

    private HikariCPDataSource() {
    }
}