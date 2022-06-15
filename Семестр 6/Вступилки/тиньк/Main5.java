import java.time.LocalTime;
import java.util.Arrays;
import java.util.Scanner;

public class Main5 {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        int n = scanner.nextInt();
        int k = scanner.nextInt();
        long[] array = new long[n];
        for (int i = 0; i < n; i++) {
            array[i] = i + 1;
        }
        int coun = reshuffle(array, n);
        int answ = 0;
        while (coun != -1) {
            if (coun % k == 0)
                answ++;
            coun = reshuffle(array, n);
        }
        System.out.println(answ);
    }

    private static int reshuffle(long[] array, int size) {
        int number = 0;
        int i = size - 2;
        while (i != -1 && array[i] >= array[i + 1])
            i--;
        if (i == -1)
            return -1;
        int j = size - 1;
        while (array[i] >= array[j])
            j--;
        change(array, i, j);
        int l = i + 1;
        int r = size - 1;
        while (l < r)
            change(array, l++, r--);
        for (i = 1; i <= size; i++)
            number += array[i - 1] * i;
        return number;
    }

    private static void change(long[] array, int i, int j) {
        long fi = array[i];
        long fj = array[j];
        array[j] = fi;
        array[i] = fj;
    }
}