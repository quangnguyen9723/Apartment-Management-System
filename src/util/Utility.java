package util;

import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.sql.*;

public class Utility {
    private static final Connection CONNECTION;
    private static final String BASE_QUERIES_URL = "./src/queries";

    static {
        String connectionUrl = "jdbc:sqlserver://database-csds341.ctqxa1jflteb.us-east-2.rds.amazonaws.com:1433;"
                + "database=tempDatabase;"
                + "user=team6;"
                + "password=csds341!;"
                + "encrypt=true;"
                + "trustServerCertificate=true;"
                + "loginTimeout=15;";
        try {
            CONNECTION = DriverManager.getConnection(connectionUrl);
        } catch (SQLException e) {
            System.err.println("cannot connect to database");
            throw new RuntimeException(e);
        }
    }

    // NOTE: files should be in the queries folder
    public static String readSqlFile(String fileName) {
        fileName = BASE_QUERIES_URL + fileName;
        StringBuilder sb = new StringBuilder();
        try (BufferedReader reader = new BufferedReader(new FileReader(fileName))) {
            String line;
            while ((line = reader.readLine()) != null) {
                sb.append(line);
            }
        } catch (FileNotFoundException e) {
            System.err.println("cannot find file");
        } catch (IOException e) {
            System.err.println("cannot read file");
        }
        return sb.toString();
    }

    public static Connection getConnection() {
        return CONNECTION;
    }

    public static void main(String[] args) {
        System.out.println(readSqlFile("test"));
    }
}
