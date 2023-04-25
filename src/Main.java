import java.sql.*;

public class Main {

    /*
    1 file cho backend (JDBC) de ket noi voi database
    1 file cho frontend (JavaFX) de display data cua backend voi ket noi backend
     */

    private final static String IP = "database-csds341.ctqxa1jflteb.us-east-2.rds.amazonaws.com";
    private final static int PORT = 1433;
    private final static String DB_NAME = "tempDatabase";
    private final static String username = "team6";
    private final static String password = "csds341!";


    public static void main(String args[]) throws ClassNotFoundException {
//        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        // Create a variable for the connection string.
//        String connectionUrl = String.format("jdbc:sqlserver//%s:%d;databaseName=%s;user=%s,password=%s", IP, PORT, DB_NAME, username, password);
        String connectionUrl = "jdbc:sqlserver://database-csds341.ctqxa1jflteb.us-east-2.rds.amazonaws.com:1433;"
                + "database=tempDatabase;"
                + "user=team6;"
                + "password=csds341!;"
                + "encrypt=true;"
                + "trustServerCertificate=true;"
                + "loginTimeout=15;";

        ResultSet resultSet = null;

        try (
                Connection connection = DriverManager.getConnection(connectionUrl);
                Statement statement = connection.createStatement();
        ) {
            System.out.println("connected");

//            String insertStatement = "insert into Owner (FirstName, LastName, Gender, DOB)\n" +
//                    "values ('Quang', 'Nguyen', 'Male', '2003-07-09');";
//            statement.execute(insertStatement);

            String queryStatement = "select * from Owner";
            resultSet = statement.executeQuery(queryStatement);


            while (resultSet.next()) {
                System.out.println(resultSet.getString(1) + ", " +
                        resultSet.getString(2) + ", " +
                        resultSet.getString(3) + ", " +
                        resultSet.getString(4) + ", " +
                        resultSet.getString(5));
            }
        }
        // Handle any errors that may have occurred.
        catch (SQLException e) {
            e.printStackTrace();
        }
    }

//    private void displayResult(ResultSet resultSet) {
//        try {
//            while (resultSet.next()) {
//
//            }
//        } catch (SQLException e) {
//            throw new RuntimeException(e);
//        }
//    }
}