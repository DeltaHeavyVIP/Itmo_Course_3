import java.util.ArrayList;
import java.util.Scanner;

public class Main6 {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        int n = scanner.nextInt();
        int h = scanner.nextInt();
        int m = scanner.nextInt();
        int k = scanner.nextInt();

        int offset;
        ArrayList<Pair> schedule = new ArrayList<>();
        int[] counter = new int[m];
        for (int i = 0; i < n; i++) {
            int hi = scanner.nextInt();
            int mi = scanner.nextInt();
            offset = mi;
            schedule.add(new Pair(offset, i + 1));
            counter[offset]++;
        }

        //solve
        int minimal;
        int time_st = 0;
        int time_end = k;
        int window_cnt = 0;
        int second_window_cnt = 0;
        for (int i = 1; i <= k - 1; i++) {
            window_cnt += counter[i];
            second_window_cnt += counter[i + m / 2];
        }

        minimal = window_cnt + second_window_cnt;
        for (int i = 1; i < m; i++) {
            window_cnt -= counter[i];
            second_window_cnt -= counter[(i + m / 2) % m];

            window_cnt += counter[(i + k - 1) % m];
            second_window_cnt += counter[(i + k + m / 2 - 1) % m];

            if (minimal > window_cnt + second_window_cnt) {
                minimal = window_cnt + second_window_cnt;
                time_st = i;
            } else if (minimal == window_cnt + second_window_cnt) {
                int time_st_2 = i;
                int time_end_2 = (time_st_2 + k) % m;
                if (time_end_2 < time_end) {
                    minimal = window_cnt + second_window_cnt;
                    time_st = i;
                    time_end = time_end_2;
                }
            }

        }

        time_end = (time_st + k) % m;
        System.out.println(minimal + " " + time_end);
        for (int i = 0; i < schedule.size(); i++) {
            if (time_st < time_end) {
                if ((schedule.get(i).getFirst() > time_st && schedule.get(i).getFirst() < time_end)) {
                    System.out.println(schedule.get(i).getSecond() + " ");
                }
            } else {
                if ((schedule.get(i).getFirst() > time_st && schedule.get(i).getFirst() > time_end)) {
                    System.out.println(schedule.get(i).getSecond() + " ");
                }
            }

            int sec_time_st = (time_st + m / 2) % m;
            int sec_time_end = (time_end + m / 2) % m;


            if (sec_time_st < sec_time_end) {
                if ((schedule.get(i).getFirst() > sec_time_st && schedule.get(i).getFirst() < sec_time_end)) {
                    System.out.println(schedule.get(i).getSecond() + " ");
                }
            } else {
                if ((schedule.get(i).getFirst() > sec_time_st && schedule.get(i).getFirst() > sec_time_end)) {
                    System.out.println(schedule.get(i).getSecond() + " ");
                }
            }
        }
    }
}

class Pair {
    private int first;
    private int second;

    Pair(int first, int second) {
        this.first = first;
        this.second = second;
    }

    public int getFirst() {
        return first;
    }

    public int getSecond() {
        return second;
    }
}
