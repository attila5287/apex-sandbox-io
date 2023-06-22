@isTest
public class CalculatorTest {
    @isTest
    public static void addTest() {
        Integer result = Calculator.add(1,2,3);
        System.assertEquals(6, result);
    }
    @isTest
    public static void substractTest() {
        Integer result = Calculator.substract(10,2);
        System.assertEquals(8, result);
    }
    
    @isTest
    public static void multiplyTest() {
        Integer result = Calculator.multiply(2,3,4);
        System.assert(result == 24);
    }
    
    @isTest
    public static void multiply2Test() {
        Integer result = Calculator.multiply(2,3);
        System.assert(result == 6);
    }
    
    @isTest
    public static void divideTest() {
        Integer result = Calculator.divide(21,3);
        System.assertEquals(7, result);

    }
    @isTest
    public static void calculateTest() {
        Integer result = Calculator.calculate(2,3);
        System.assertEquals(6, result);
    }
    @isTest
    public static void calculateTest2() {
        Integer result = Calculator.calculate(2,3,5);
        System.assertEquals(30, result);
    }

    @isTest
    public static void strDemoTest() {
        String result = Calculator.strDemo('2','3');
        System.assertEquals('2 3', result);
    }
}
