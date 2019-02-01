import javax.swing.*;
import java.awt.*;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;
import java.awt.geom.Line2D;
import java.util.ArrayList;
import java.util.List;

public class UserGUI extends JPanel implements  AvailableUsersListener{


    private final Client client;
    private JList<String> usersAvailable;
    private DefaultListModel<String> userListModel;

    public UserGUI(Client client) {

        this.client = client;
        this.client.addAvailableUserListener(this);

        userListModel = new DefaultListModel<>();
        usersAvailable = new JList<>(userListModel);
        setLayout(new BorderLayout());
        add(new JScrollPane(usersAvailable), BorderLayout.CENTER);

        usersAvailable.addMouseListener(new MouseAdapter() {
            @Override
            public void mouseClicked(MouseEvent e) {
                if(e.getClickCount() > 1 ){
                    String login = usersAvailable.getSelectedValue();
                    MessangerGUI messangerGUI = new MessangerGUI(client, login);

                    JFrame f = new JFrame("Conversation with " + login );
                    f.setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
                    f.setSize(700,700);
                    f.getContentPane().add(messangerGUI, BorderLayout.CENTER);
                    f.setVisible(true);

                }
            }
        });

    }



    @Override
    public void online(String login) {
        if(login == null){
            System.out.println("login is null");
        }
        System.out.println("Inside online UserGUI login is " + login);
        userListModel.addElement(login);
    }

    @Override
    public void offline(String login) {
        userListModel.removeElement(login);
    }
}
