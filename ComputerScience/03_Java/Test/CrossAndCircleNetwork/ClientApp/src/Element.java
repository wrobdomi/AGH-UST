import javax.swing.*;
import java.awt.*;

public class Element extends JButton {

    int stan=0;
    public Element() {
    }

    @Override
    public void paint(Graphics g) {
        super.paint(g);
        if(stan == 1)
        {
            g.drawLine(0, 0, 160, 150);
            g.drawLine(130, 0, 0, 120);
        }
        else if(stan==2)
        {
            g.drawOval(10, 10, 110, 110);
        }
    }


}