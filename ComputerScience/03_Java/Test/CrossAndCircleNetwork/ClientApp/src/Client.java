import java.io.*;
import java.net.Socket;
import java.util.ArrayList;

public class Client {

    private final String hostName;
    private final int port;
    private Socket socket;
    private OutputStream toServer;
    private BufferedReader bufferedReader;
    private InputStream fromServer;
    private ObjectOutputStream objectOutputStream;
    private ObjectInputStream objectInputStream;
    private ArrayList<AvailableUsersListener> availableUsersListeners = new ArrayList<>();
    private ArrayList<MessageListener> messageListeners = new ArrayList<>();

    public Client(String hostName, int port) {
        this.hostName = hostName;
        this.port = port;
    }


    public void sendMessage(String to, String message) throws IOException {
        String command = "send " + to + " " + message + "\n";
        toServer.write(command.getBytes());
    }


    public void sendPicture(String login, CrossAndCircleGame crossAndCircleGame) {
        try {
            objectOutputStream.writeObject(crossAndCircleGame);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }


    public void logoff() throws IOException{
        String sendToHost = "exit\n";
        toServer.write(sendToHost.getBytes());
    }

    private void closeSocket() throws IOException {
        socket.close();
    }


    public boolean login(String login, String pass) throws IOException {
        String sendToHost = "login " + login + " " + pass + "\n";
        toServer.write(sendToHost.getBytes());

        String response = bufferedReader.readLine();
        System.out.println("Response from server: " + response);

        String welcome = "Welcome, you are logged in.";


        // after successfully loged in, start reading server messages in a loop
        if(response.equals(welcome)){
            startHostReading();
            return true;
        } else {
            return false;
        }
    }



    private void startHostReading() {
        Thread thread = new Thread(){
            @Override
            public void run() {
                readMessageLoop();
            }
        };
        thread.start();
    }

    private void readMessageLoop() {
        try{
            String serversMessage;
            while( (serversMessage = bufferedReader.readLine()) != null ){


                // first word is always command
                String command = getCommand(serversMessage);
                // other words are parameters
                ArrayList<String> parameters = getCommandsParams(serversMessage);

                System.out.println("Server message is " + serversMessage);
                System.out.println("Command is " + command);


                if(command.equals("online")){
                    invokeOnlineListeners(parameters.get(0));
                } else if( command.equals("offline")){
                    invokeOfflineListeners(parameters.get(0));
                } else if( command.equals("send")){

                    invokeOnMessageListener(parameters.get(0), parameters);
                }



            }
        }catch(Exception ex){
            ex.printStackTrace();
            try {
                socket.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }


    }

    public void invokeOnMessageListener(String log, ArrayList<String> parameters) {

        StringBuilder sb = new StringBuilder();
        for(String s : parameters){
            sb.append(s);
            sb.append(" ");
        }
        String mes = sb.toString();

        System.out.println("Receiving message !!! ");

        String login = log;
        String message = mes + "\n";

        System.out.println("Inside send Client method");
        for(MessageListener listener : messageListeners){
            listener.onMessage(login, message);
        }

    }

    private void invokeOfflineListeners(String offlineUser) {
        String login = offlineUser;
        for(AvailableUsersListener aul : availableUsersListeners){
            aul.offline(login);
        }
    }

    private void invokeOnlineListeners(String onlineUser) {
        System.out.println("Inside invokeOnlineListeners client");
        String login = onlineUser;
        System.out.println(availableUsersListeners.size());
        for(AvailableUsersListener aul : availableUsersListeners){
            aul.online(login);
        }
    }


    public boolean connectToHost(){
        try{
            this.socket = new Socket(hostName, port);
            this.toServer = socket.getOutputStream();
            this.fromServer = socket.getInputStream();
            this.bufferedReader = new BufferedReader(new InputStreamReader(fromServer));
            // this.objectOutputStream = new ObjectOutputStream(socket.getOutputStream());
            return true;
        } catch(IOException e){
            e.printStackTrace();
        }
        return false;
    }

    public void addAvailableUserListener(AvailableUsersListener al){
        System.out.println("Inside add available");
        availableUsersListeners.add(al);
    }

    public void removeAvailableUserListener(AvailableUsersListener al){
        availableUsersListeners.remove(al);
    }

    public void addMessageListener(MessageListener ml){
        messageListeners.add(ml);
    }

    public void removeMessageListener(MessageListener ml){
        messageListeners.remove(ml);
    }

    public String getCommand(String clientsMessage) {
        String[] words = clientsMessage.split("\\s+");
        return words[0];
    }

    public ArrayList<String> getCommandsParams(String clientsMessage) {
        ArrayList<String> params = new ArrayList<String>();
        String[] words = clientsMessage.split("\\s+");
        for(int i = 1; i<words.length ; i++){
            params.add(words[i]);
        }
        return params;
    }


}
