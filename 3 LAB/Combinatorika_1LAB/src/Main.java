public class Main {

    public static void main(String[] args) {
        char[] alphabet = {'a', 'b', 'c', 'd'};
        int k;

        System.out.println("Все размещения с повторениями (рекурсивно):");
        k = 2;
        CombTasks.allPermutations(alphabet, k, 0, new char[k]);

        System.out.println("\nВсе размещения с повторениями (не рекурсивно):");
        CombTasks.allPermutations(alphabet, alphabet.length, k);

        System.out.println("\nВсе сочетания без повторений (рекурсивно):");
        k = 2;
        CombTasks.allCombinations(alphabet, alphabet.length, k, alphabet.length, 0, new char[k]);

        System.out.println("\nВсе сочетания без повторений (не рекурсивно):");
        CombTasks.allCombinations(alphabet, alphabet.length, k);

        System.out.println("\n Все слова длины k, содержащие 3 буквы a на заданном алфавите:");
        k = 5;
        CombTasks.allWords3A(alphabet, alphabet.length, k);
    }
}