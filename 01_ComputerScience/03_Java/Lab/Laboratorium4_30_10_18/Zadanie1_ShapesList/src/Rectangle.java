public class Rectangle extends Shape{

    private double sideOneLength;
    private double sideTwoLength;

    public Rectangle(double sideOneLength, double sideTwoLength) {
        this.sideOneLength = sideOneLength;
        this.sideTwoLength = sideTwoLength;
    }


    @Override
    public void draw() {
        System.out.println("Drawing rectangle");
    }

    @Override
    public double area() {
        return sideOneLength * sideTwoLength;
    }
}
