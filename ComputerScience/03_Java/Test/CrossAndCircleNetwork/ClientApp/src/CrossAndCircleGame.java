import javax.swing.*;
import java.awt.*;
import java.io.Serializable;

public class CrossAndCircleGame implements Serializable {


    private JFrame paint;

    // --------------------------------------------------- //

    public void createPainting(){


        paint = new JFrame ();

        paint.setTitle("Cross and Circle Game");
        JPanel plansza = new JPanel();
        plansza.setLayout(new GridLayout(3,3));
        Element a[][]= new Element[3][3];
        int wyniki[][]= new int[3][3];
        for(int i=0;i<3;i++)
        {
            for(int j=0;j<3;j++)
            {
                a[i][j]= new Element();
                wyniki[i][j]=0;
            }
        }
        for(int i=0;i<3;i++)
        {
            for(int j=0;j<3;j++)
            {
                a[i][j].addActionListener(new ElementsListener(a, wyniki, plansza));
                plansza.add(a[i][j]);
            }
        }

        paint.add(plansza);
        paint.setVisible(true);
    }

//        paint.add ( new JComponent ()
//        {
//            private List<Shape> shapes = new ArrayList<Shape>();
//            private Shape currentShape = null;
//
//            {
//                MouseAdapter mouseAdapter = new MouseAdapter ()
//                {
//                    public void mousePressed ( MouseEvent e )
//                    {
//                        currentShape = new Line2D.Double ( e.getPoint (), e.getPoint () );
//                        shapes.add ( currentShape );
//                        repaint ();
//                    }
//
//                    public void mouseDragged ( MouseEvent e )
//                    {
//                        Line2D shape = ( Line2D ) currentShape;
//                        shape.setLine ( shape.getP1 (), e.getPoint () );
//                        repaint ();
//                    }
//
//                    public void mouseReleased ( MouseEvent e )
//                    {
//                        currentShape = null;
//                        repaint ();
//                    }
//                };
//                addMouseListener ( mouseAdapter );
//                addMouseMotionListener ( mouseAdapter );
//            }
//
//            protected void paintComponent ( Graphics g )
//            {
//                Graphics2D g2d = ( Graphics2D ) g;
//                g2d.setPaint ( Color.BLACK );
//                for ( Shape shape : shapes )
//                {
//                    g2d.draw ( shape );
//                }
//            }
//        } );

//    }



    public void showPainting(){

        paint.setSize ( 500, 500 );
        paint.setLocationRelativeTo ( null );
        paint.setVisible ( true );

    }



}
