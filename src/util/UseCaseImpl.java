package util;

import java.sql.*;
import java.text.ParseException;
import java.util.Scanner;

public class UseCaseImpl {
    private final static Scanner scanner;
    static {
        scanner = new Scanner(System.in);
    }

    // --------------------------------------------------- QUANG ----------------------------------------------------
    public static void addRequest() throws SQLException {
        Connection connection = Utility.getConnection();
        String query = "insert into Maintenance (apartment_id, category, status) values (?, ?, ?)";

        System.out.print("Apartment ID: ");
        int aptId = scanner.nextInt();
        System.out.print("Category ('Electricity', 'Water', 'Interior', 'Other'): ");
        String category = scanner.next();

        PreparedStatement preparedStatement = connection.prepareStatement(query);
        preparedStatement.setInt(1, aptId);
        preparedStatement.setString(2, category);
        preparedStatement.setString(3, "In Progress");

        preparedStatement.executeUpdate();
        connection.commit();
        System.out.println();
    }

    public static void finishRequest() throws SQLException {
        Connection connection = Utility.getConnection();
        String query = "update Maintenance set status = ? where id = ?";

        System.out.print("Apartment ID: ");
        int requestId = scanner.nextInt();

        PreparedStatement preparedStatement = connection.prepareStatement(query);
        preparedStatement.setString(1, "Done");
        preparedStatement.setInt(2, requestId);

        preparedStatement.executeUpdate();
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

    // --------------------------------------------------- MINH ----------------------------------------------------

    public static void topPriceApt() throws SQLException {
        System.out.print("Highest(desc) or lowest(asc)? Answer asc/desc: ");
        String order = scanner.next();
        System.out.print("How many apartments? ");
        int number = scanner.nextInt();

        Connection connection = Utility.getConnection();
        String query = "SELECT TOP (?) b.Name, a.price, a.id\n" +
                "FROM Apartment a\n" +
                "JOIN Building b ON a.building_id = b.id\n" +
                "WHERE a.availability = 'vacant'\n" +
                "ORDER BY a.price " + order;

        PreparedStatement preparedStatement = connection.prepareStatement(query);
        preparedStatement.setInt(1, number);

        ResultSet resultSet = preparedStatement.executeQuery();
        connection.commit();
        System.out.println();
        System.out.println("Top " + number + " apartments: ");
        while (resultSet.next()) {
            System.out.println("Building name: " + resultSet.getString(1)
                    + ", price: " + resultSet.getString(2)
                    + ", apartment id: " + resultSet.getString(3));
        }
    }

    public static void raisePriceApt() throws SQLException {
        System.out.print("Building name: ");
        String buildingName = scanner.next();
        System.out.print("Raise Percentage: ");
        int percentage = scanner.nextInt();

        Connection connection = Utility.getConnection();
        String query = "UPDATE Apartment\n" +
                "SET price = price * ?\n" +
                "WHERE building_id = (SELECT id FROM Building WHERE Name = ?)";

        PreparedStatement preparedStatement = connection.prepareStatement(query);
        preparedStatement.setDouble(1, 1 + percentage / 100.0);
        preparedStatement.setString(2, buildingName);

        preparedStatement.executeUpdate();
        connection.commit();
        System.out.println();
    }

    // --------------------------------------------------- AIDEN ----------------------------------------------------

    public static void insertRent() throws ParseException, SQLException {
        System.out.print("Tenant's first name: ");
        String firstName = scanner.next();
        System.out.print("Tenant's last name: ");
        String lastName = scanner.next();
        System.out.print("Apartment ID: ");
        int aptID = scanner.nextInt();
        System.out.print("Start date (YYYY-MM-DD): ");
        String startDate = scanner.next();
        System.out.print("End date (YYYY-MM-DD): ");
        String endDate = scanner.next();

        Connection connection = Utility.getConnection();
        String query = "INSERT INTO Rents (apartment_id, tenant_id, start_date, end_date) \n" +
                "VALUES (?, \n" +
                "(SELECT t.id \n" +
                "FROM Tenant t\n" +
                "WHERE t.FirstName = ? AND t.LastName = ?)\n" +
                ", ?, ?)";

        PreparedStatement preparedStatement = connection.prepareStatement(query);
        preparedStatement.setInt(1, aptID);
        preparedStatement.setString(2, firstName);
        preparedStatement.setString(3, lastName);
        preparedStatement.setDate(4, Date.valueOf(startDate));
        preparedStatement.setDate(5, Date.valueOf(endDate));

        preparedStatement.executeUpdate();
        connection.commit();
        System.out.println();
    }

    public static void removeTenant() throws SQLException {
        System.out.print("Tenant ID: ");
        int tenantId = scanner.nextInt();

        String query = "DELETE FROM Tenant WHERE id = ?";
        Connection connection = Utility.getConnection();
        PreparedStatement preparedStatement = connection.prepareStatement(query);

        preparedStatement.setInt(1, tenantId);

        preparedStatement.executeUpdate();
        connection.commit();
        System.out.println();
    }

    public static void showAmountTenantOwe() throws SQLException {
        System.out.print("Tenant's first name: ");
        String firstName = scanner.next();
        System.out.print("Tenant's last name: ");
        String lastName = scanner.next();

        String query = "SELECT SUM(Payment.amount) AS total\n" +
                "FROM Payment\n" +
                "JOIN Tenant ON Payment.tenant_id = Tenant.id\n" +
                "JOIN Owner ON Payment.owner_id = Owner.id\n" +
                "WHERE Tenant.FirstName = ?\n" +
                "AND Tenant.LastName = ?";
        Connection connection = Utility.getConnection();
        PreparedStatement preparedStatement = connection.prepareStatement(query);
        preparedStatement.setString(1, firstName);
        preparedStatement.setString(2, lastName);

        ResultSet resultSet = preparedStatement.executeQuery();
        connection.commit();
        resultSet.next();
        System.out.println("Amount owed: " + resultSet.getString(1));
    }

    public static void showAllOverdueTenants() throws SQLException {
        String query = "SELECT concat(Tenant.FirstName, ' ', Tenant.LastName) as TenantName, concat(Owner.FirstName, ' ', Owner.LastName) as OwnerName, Payment.amount, Payment.due_date,  Payment.status\n" +
                "FROM Payment\n" +
                "JOIN Tenant ON Payment.tenant_id = Tenant.id\n" +
                "JOIN Owner ON Payment.owner_id = Owner.id\n" +
                "WHERE Payment.due_date < GETDATE()\n" +
                "AND Payment.status = 'unpaid';";

        Connection connection = Utility.getConnection();
        PreparedStatement preparedStatement = connection.prepareStatement(query);
        ResultSet resultSet = preparedStatement.executeQuery();

        while (resultSet.next()) {
            System.out.println("Tenant's name: " + resultSet.getString(1) +
                    ", owner's name: " + resultSet.getString(2) +
                    ", amount owed: " + resultSet.getString(3) +
                    ", due date: " + resultSet.getString(4));
        }
    }
}

