import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        int a = Integer.parseInt(scanner.nextLine());
        int b = Integer.parseInt(scanner.nextLine());
        int n = Integer.parseInt(scanner.nextLine());
        if (a > (b / n))
            System.out.println("Yes");
        else
            System.out.println("No");
    }
}
