import java.util.Scanner;

/**
 * Class to provide Command Line Interface
 */
public class Driver {
    private static final int EXIT = 3;

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        int choice = -1;
        while (choice != EXIT) {
            printMenu();
            System.out.print("What operation do you want: ");
            choice = scanner.nextInt();
            handleChoice(choice);
            System.out.println();
        }
        System.out.println("Exit successfully");
    }

    private static void printMenu() {
        System.out.println("====== Menu ======");
        System.out.println("1. View data");
        System.out.println("2. Edit data");
        System.out.println("3. Exit");
    }

    private static void handleChoice(int choice) {
        // Echo the input back to the console
        if (choice<= 0 || choice > EXIT) {
            System.out.println("Invalid choice, choose between 1 and " + EXIT);
            return;
        }

        switch (choice) {
            case 1 : System.out.println(1);
            case 2 : System.out.println(2);
            case 3 : System.out.println(3);
        }
    }
}
