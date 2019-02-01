import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.IOException;

public class LoginView extends JFrame {

    private final Client client;
    JTextField loginField = new JTextField();
    JPasswordField passwordField = new JPasswordField();
    JButton loginButton = new JButton("Login 'dominik' or 'tomek' password same as login");

    public LoginView() {

        super("Login View");

        this.client = new Client("localhost", 8819);
        client.addAvailableUserListener(new AvailableUsersListener() {
            @Override
            public void online(String login) {
                System.out.println(login + " is online");
            }

            @Override
            public void offline(String login) {
                System.out.println(login + " is offline");
            }
        });
        client.connectToHost();

        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);

        JPanel jPanel = new JPanel();

        jPanel.setLayout(new BoxLayout(jPanel, BoxLayout.Y_AXIS));
        jPanel.add(loginField);
        jPanel.add(passwordField);
        jPanel.add(loginButton);

        loginButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                doLogin();
            }
        });


        getContentPane().add(jPanel, BorderLayout.CENTER);

        pack();

        setVisible(true);
    }

    private void doLogin() {
        String login = loginField.getText();
        String password = passwordField.getText();

        try {
            if(client.login(login, password)){

                UserGUI userGUI = new UserGUI(client);
                JFrame jFrame = new JFrame("Start at least 2 to clients " +
                                    " and choose a player. Start playing. Then save to DB. ");
                jFrame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
                jFrame.setSize(800,800);

                jFrame.getContentPane().add(userGUI, BorderLayout.CENTER);
                jFrame.setVisible(true);

                setVisible(false);
            } else{
                JOptionPane.showMessageDialog(this, "Invalid credentials");
            }
        } catch (IOException e) {
            e.printStackTrace();
        }

    }

    public static void main(String[] args) {
        LoginView loginView = new LoginView();
        loginView.setVisible(true);
    }

}
