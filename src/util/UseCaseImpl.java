package util;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Scanner;

public class UseCaseImpl {
    private final static Scanner scanner;
    static {
        scanner = new Scanner(System.in);
    }
    public static void addRequest() throws SQLException {
        Connection connection = Utility.getConnection();
        String query = "insert into Maintenance (apartment_id, category, status) values (?, ?, ?)";

        System.out.print("Apartment ID: ");
        int aptId = Integer.parseInt(scanner.next());
        System.out.print("Category ('Electricity', 'Water', 'Interior', 'Other'): ");
        String category = scanner.next();

        PreparedStatement preparedStatement = connection.prepareStatement(query);
        preparedStatement.setInt(1, aptId);
        preparedStatement.setString(2, category);
        preparedStatement.setString(3, "In Progress");

        boolean isSuccessful = preparedStatement.execute(query);
        System.out.println(isSuccessful);
        connection.commit();
        System.out.println();
    }

    public static void finishRequest() throws SQLException {
        Connection connection = Utility.getConnection();
        String query = "update Maintenance set status = ? where apartment_id = ?";

        System.out.print("Apartment ID: ");
        int aptId = Integer.parseInt(scanner.next());

        PreparedStatement preparedStatement = connection.prepareStatement(query);
        preparedStatement.setString(1, "Done");
        preparedStatement.setInt(2, aptId);

        preparedStatement.execute(query);
        connection.commit();
        System.out.println();
    }

    public static void showUnfinishedRequests() throws SQLException {
        Connection connection = Utility.getConnection();
        String query = "select m.apartment_id, m.category " +
                "from Building b " +
                "join Apartment a on b.id = a.building_id " +
                "join Maintenance m on a.id = m.apartment_id " +
                "where b.name = ? and m.status = ?";

        System.out.print("Building name: ");
        String buildingName = scanner.next();

        PreparedStatement preparedStatement = connection.prepareStatement(query);
        preparedStatement.setString(1, buildingName);
        preparedStatement.setString(2, "In Progress");

        ResultSet resultSet = preparedStatement.executeQuery();
        connection.commit();
        System.out.println();
        while (resultSet.next()) {
            System.out.println("apartment id: " + resultSet.getString(1)
                    + ", category: " + resultSet.getString(2));
        }
    }


}
