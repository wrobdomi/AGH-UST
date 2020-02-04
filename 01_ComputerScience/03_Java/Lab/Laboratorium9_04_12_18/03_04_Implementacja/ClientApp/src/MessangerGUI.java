import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.IOException;

public class MessangerGUI extends JPanel implements MessageListener {

    private final Client client;
    private final String login;

    private DefaultListModel<String> listModel = new DefaultListModel<>();
    private JList<String> messagesList = new JList<>(listModel);
    private JTextField inputField = new JTextField();
    private Painting painting;
    private JButton pictureButton = new JButton("Send my picture");

    public MessangerGUI(Client client, String login) {

        this.client = client;
        this.login = login;

        client.addMessageListener(this);


        setLayout(new BorderLayout());
        add(new JScrollPane(messagesList), BorderLayout.CENTER);
        add(inputField, BorderLayout.SOUTH);
        add(pictureButton, BorderLayout.NORTH);

        pictureButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                System.out.println("Sending your picture");
                client.sendPicture(login, painting);
            }
        });


        painting = new Painting();
        painting.createPainting();
        painting.showPainting();


        inputField.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                System.out.println("I am in action listener !");
                String text = inputField.getText();
                try {
                    client.sendMessage(login, text);
                } catch (IOException e1) {
                    e1.printStackTrace();
                }
                listModel.addElement("You: " + text);
                inputField.setText("");
            }
        });
    }


    @Override
    public void onMessage(String from, String message) {

        if(login.equals(from)){
            String line = from + " : " + message;
            listModel.addElement(line);
        }


    }


}
