import java.util.ArrayList;

public class ShapesList {

    private ArrayList<Shape> shapesArrayList;


    public ShapesList() {
        this.shapesArrayList = new ArrayList<>();
    }

    public boolean addShapeToList(Shape myShape){
        shapesArrayList.add(myShape);
        return true;
    }

    public void printAllShapes(){
        for (Shape tempShape : shapesArrayList){
            tempShape.draw();
        }
    }

    public boolean printOneShape(int index){
        if(index < shapesArrayList.size()){
            shapesArrayList.get(index-1).draw();
            return true;
        }
        System.out.println("Index exceeds list dimension");
        return false;
    }




}
