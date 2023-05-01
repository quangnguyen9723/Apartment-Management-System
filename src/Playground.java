import java.sql.*;

import static util.Utility.*;

public class Playground {

    /*
    1 file cho backend (JDBC) de ket noi voi database
    1 file cho frontend (JavaFX) de display data cua backend voi ket noi backend
     */
    public static void main(String args[]) {
        String file = readSqlFile("CreateMaintenance");
        System.out.println(file);
    }

    public static void test() {

        ResultSet resultSet = null;
        try (Connection connection = getConnection();
             Statement statement = connection.createStatement())
        {
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
}