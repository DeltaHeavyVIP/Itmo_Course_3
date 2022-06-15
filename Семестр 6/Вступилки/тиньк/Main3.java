import java.util.Scanner;

public class Main3 {
    public static void main(String[] args) {
        int nill = 0;
        Scanner scanner = new Scanner(System.in);
        long number = Long.parseLong(scanner.nextLine());
        while (number % 10 == 0) {
            number = number / 10;
        }
        while (number != 0) {
            if (number % 10 == 0) {
                nill++;
            }
            number = number / 10;
        }
        System.out.println(nill);
    }
}