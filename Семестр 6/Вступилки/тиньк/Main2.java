import java.util.Scanner;

public class Main2 {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        String x = scanner.nextLine().trim();
        String y = scanner.nextLine().trim();
        String z = scanner.nextLine().trim();

        if(x.equals(">") && y.equals("=") && z.equals("<") ) {
            System.out.println("bac");
            System.out.println("bca");
        }

        if(x.equals(">") && y.equals(">") && z.equals("<") ) {
            System.out.println("bca");
        }

        if(x.equals("<") && y.equals("<") && z.equals("=") ) {
            System.out.println("abc");
            System.out.println("acb");
        }

        if(x.equals("<") && y.equals("<") && z.equals("<")) {
            System.out.println("abc");
        }

        if(x.equals("=") && y.equals("<") && z.equals("<") ) {
            System.out.println("abc");
            System.out.println("bac");
        }

        if(x.equals(">") && y.equals("<") && z.equals("<") ) {
            System.out.println("bac");
        }

        if(x.equals(">") && y.equals(">") && z.equals("=") ) {
            System.out.println("bca");
            System.out.println("cba");
        }

        if(x.equals("<") && y.equals("<") && z.equals(">") ) {
            System.out.println("acb");
        }

        if(x.equals("<") && y.equals("=") && z.equals(">") ) {
            System.out.println("acb");
            System.out.println("cab");
        }

        if(x.equals("<") && y.equals(">") && z.equals(">") ) {
            System.out.println("cab");
        }

        if(x.equals("=") && y.equals("=") && z.equals("=") ) {
            System.out.println("abc");
            System.out.println("acb");
            System.out.println("bac");
            System.out.println("bca");
            System.out.println("cab");
            System.out.println("cba");
        }

        if(x.equals(">") && y.equals(">") && z.equals(">") ) {
            System.out.println("cba");
        }

        if(x.equals("=") && y.equals(">") && z.equals(">") ) {
            System.out.println("cab");
            System.out.println("cba");
        }
    }
}
