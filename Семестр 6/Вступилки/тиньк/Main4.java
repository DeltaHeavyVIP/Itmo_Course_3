import java.util.Scanner;

public class Main4 {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        int n = Integer.parseInt(scanner.nextLine());
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                char elem;
                if (!((j < n / 2 && i < n / 2) || !(j < n / 2 || i < n / 2))) {
                    elem = (char) ('a' + Math.abs(n - 1 - (i + j)));
                } else {
                    elem = (char) ('a' + Math.abs(i - j));
                }
                if (elem > 'z')
                    elem -= ('z' - 'a' + 1);
                System.out.print(elem);
            }
            System.out.println();
        }
    }
}
