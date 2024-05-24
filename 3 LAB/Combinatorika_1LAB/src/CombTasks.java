import java.util.Arrays;

public class CombTasks {

    /** Написать рекурсивную функцию, которая выводит на экран все размещения с
     повторениями из n по k для заданного алфавита. */
    public static void allPermutations(char[] alphabet, int k, int i, char[] perm) {
        if (k == i) {
            System.out.println(perm);
            return;
        }

        for (char  el : alphabet) {
            perm[i] = el;
            allPermutations(alphabet, k, i + 1, perm);
        }
    }


    /** Написать нерекурсивную функцию, которая выводит на экран все размещения с
     повторениями из n по k для заданного алфавита. */
    public static void allPermutations(char[] alphabet, int n, int k) {
        int[] permIndices = new int[k];
        Arrays.fill(permIndices, 0);
        int i = 0, counter = 1;
        while (true) {
            if (i == k - 1) {

                System.out.printf("%d: ", counter++);
                for (int j : permIndices) System.out.print(alphabet[j]);
                System.out.println();

                while (permIndices[i] == n - 1) {
                    if (i == 0) return;
                    permIndices[i] = 0;
                    i--;
                }

                permIndices[i] ++;

                i = 0;

            } else {
                i++;
            }
        }
    }


    /** Написать рекурсивную функцию, которая выводит на экран все сочетания без
     повторений из n по k для заданного алфавита. */
    public static void allCombinations(char[] alphabet, int n, int k, int alphLen, int combLen, char[] comb) {
        if (k == combLen) {
            System.out.println(comb);
            return;
        }

        for (int i = n - alphLen; i < n; i++) {
            comb[combLen] = alphabet[i];
            allCombinations(alphabet, n, k, alphLen - i - 1, combLen + 1, comb);
        }
    }


    /** Написать нерекурсивную функцию, которая выводит на экран все сочетания без
     повторений из n по k для заданного алфавита. */
    public static void allCombinations(char[] alphabet, int n, int k) {
        int[] combIndices = new int[k];

        for (int i = 0; i < k; i++) combIndices[i] = i;

        int i = 0, counter = 1;
        while (true) {
            if (i == k - 1) {

                System.out.printf("%d: ", counter++);
                for (int j : combIndices) System.out.print(alphabet[j]);
                System.out.println();

                while ( (n - 1 - (combIndices[i] + 1)) < (k - 1 - i) ) {
                    if (i == 0) return;
                    i--;
                }

                combIndices[i]++;

                int newEl = combIndices[i];
                for (int j = i+1; j < k; j++) combIndices[j] = ++newEl;

                i = 0;

            } else {
                i++;
            }
        }
    }


    /** Написать функцию, которая строит все слова длины k, содержащие 3 буквы a на
     заданном алфавите.*/
    public static void allWords3A(char[] alphabet, int n, int k) {

        char[] newAlphabet = new char[n];
        int newN = 0;
        for (int i = 0; i < n; i++) {
            if (alphabet[i] != 'a') {
                newAlphabet[newN] = alphabet[i];
                newN++;
            }
        }
        alphabet = newAlphabet;
        n = newN;

        int combK = 3;
        int permK = k - 3;

        int[] combIndices = new int[combK];
        int[] permIndices = new int[permK];

        for (int i = 0; i < combK; i++) combIndices[i] = i;

        int combI = 0, permI = 0, counter = 1;

        boolean permIsOver = false;

        while (true) {
            if (combI == combK - 1) {

                // start making permutations
                Arrays.fill(permIndices, 0);
                while (! permIsOver) {
                    if (permI == permK - 1) {

                        System.out.printf("%d: ", counter++);
                        for (int i = 0, c = 0, p = 0; i < k; i++) {
                            if (c < 3 && i == combIndices[c]) {
                                System.out.print('a');
                                c++;
                            } else {
                                System.out.print(alphabet[permIndices[p]]);
                                p++;
                            }
                        }
                        System.out.println();

                        while (permIndices[permI] == n - 1) {
                            if (permI == 0) {
                                permIsOver = true;
                                break;
                            };
                            permIndices[permI] = 0;
                            permI--;
                        }

                        permIndices[permI] ++;

                        permI = 0;

                    } else {
                        permI++;
                    }
                }
                // stop making permutations
                permIsOver = false;

                // new combination
                while ( (k - 1 - (combIndices[combI] + 1)) < (combK - 1 - combI) ) {
                    if (combI == 0) return;
                    combI--;
                }

                combIndices[combI]++;

                int newEl = combIndices[combI];
                for (int j = combI+1; j < combK; j++) combIndices[j] = ++newEl;

                combI = 0;

            } else {
                combI++;
            }
        }
    }
}

