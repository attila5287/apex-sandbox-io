public class Calculator {
    public static Integer add(Integer num1,Integer num2, Integer num3 ) {
        Integer result = num1 + num2 + num3;
        return result;
    }
    public static Integer substract(Integer num1,Integer num2) {
        Integer result = num1 - num2;
        return result;
    }
    public static Integer multiply(Integer num1,Integer num2,Integer num3) {
        Integer result = num1 * num2 * num3;
        return result;
    }
    public static Integer multiply(Integer num1,Integer num2) {
        Integer result = num1 * num2;
        return result;
    }
    public static Integer divide(Integer num1,Integer num2) {
        Integer result = num1 / num2;
        return result;
    }
    public static String strDemo(String num1,String num2) {
        String result = num1 + ' ' + num2;
        return result;
    }
    // method overwrite
    public static Integer calculate(Integer num1,Integer num2,Integer num3) {
        Integer result = num1 * num2 * num3;
        return result;
    }
    // method overwrite
    public static Integer calculate(Integer num1,Integer num2) {
        Integer result = num1 * num2;
        return result;
    }
}
