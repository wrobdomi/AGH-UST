import java.io.*;
import java.net.ServerSocket;
import java.net.Socket;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

public class ServerService extends Thread {

    // clientServer stores all Services
    // and access to them is needed in order to communicate
    // so every clients thread need its server to
    // have access to other clients
    private final Server clientsServer;
    private final Socket clientsSocket;
    private String clientsUsername = null;
    private Map<String, String> users = new HashMap<>();
    private BufferedWriter bufferedWriter;
    private BufferedReader bufferedReader;
    private ObjectInputStream objectInputStream;
    private ObjectOutputStream objectOutputStream;

    public ServerService(Server clientsServer, Socket clientsSocket) throws IOException {
        this.clientsServer = clientsServer;
        this.clientsSocket = clientsSocket;

        // for naive authentication ( main focus is on server IO handling )
        users.put("dominik", "dominik");
        users.put("tomek", "tomek");
        users.put("emilia", "emilia");
        users.put("marysia", "marysia");

        // bidirectional communication is needed so reader and writer are created
        bufferedReader = new BufferedReader(new InputStreamReader(clientsSocket.getInputStream()));
        bufferedWriter = new BufferedWriter(new OutputStreamWriter(clientsSocket.getOutputStream()));
//        objectInputStream = new ObjectInputStream(clientsSocket.getInputStream());
//        objectOutputStream = new ObjectOutputStream(clientsSocket.getOutputStream());
    }


    public String getClientsUsername() {
        return clientsUsername;
    }

    @Override
    public void run() {
        try {
            communicateWithClient();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }


    private void communicateWithClient() throws IOException {



        // waiting for clients message
        String clientsMessage;


        while( (clientsMessage = bufferedReader.readLine()) != null   )   {


            // first word is always command
            String command = getCommand(clientsMessage);
            // other words are parameters
            ArrayList<String> parameters = getCommandsParams(clientsMessage);


            System.out.println("Clients message is " + clientsMessage);
            System.out.println("Command is " + command);

            // only if user typed something
            if(command.length() > 0 && command != null){



                // if users wants to log off
                if(clientsMessage.equals("exit")){
                    logoutUser();
                    break;
                }
                else if(command.equals("login")) {
                    String username = parameters.get(0);
                    String pass = parameters.get(1);
                    logUser(username, pass, bufferedWriter);
                }
                else if(command.equals("send")){
                    String to = parameters.get(0);
                    StringBuilder sb = new StringBuilder();
                    for(String s : parameters){
                        sb.append(s);
                        sb.append(" ");
                    }
                    String text = sb.toString();
                    sendMessage(to, text);
                }



                else{
                    // if command not found
                    this.sendMessageToClient("Server: command not supported.\n" );
                }

            }
            else{
                this.sendMessageToClient("Server: command not supported.\n" );
            }


        }


    }

    private void sendMessage(String to, String text) throws IOException {

        ArrayList<ServerService> allClients = this.clientsServer.getServerServices();
        for(ServerService ss : allClients){
            if(to.equals(ss.getClientsUsername())){
                text = "send " + clientsUsername + " " + text + "\n";
                ss.sendMessageToClient(text);
            }
        }

    }

    private void sendObject(String to, Object object) throws IOException {

        ArrayList<ServerService> allClients = this.clientsServer.getServerServices();
        for(ServerService ss : allClients){
            if(to.equals(ss.getClientsUsername())){
                ss.sendObjectToClient(object);
            }
        }
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

    public boolean authenticateUser(String username, String pass){
        if(users.containsKey(username)){
            String dbPass = users.get(username);
            if(dbPass.equals(pass)){
                return true;
            }
        }
        return false;
    }

    private void logUser(String us, String pass, BufferedWriter bw) throws IOException {

        if(authenticateUser(us, pass)){

            clientsUsername = us;
            this.sendMessageToClient("Welcome, you are logged in.\n");
            System.out.println("Successfully logged in");

            // send to this.ServerService all online users
            ArrayList<ServerService> allClients = this.clientsServer.getServerServices();
            for(ServerService ss : allClients){
                    if(ss.getClientsUsername() != null) {
                        if (!clientsUsername.equals(ss.getClientsUsername())) {
                            sendMessageToClient("online " + ss.getClientsUsername() + "\n");
                            System.out.println("ONLINE IS " + ss.getClientsUsername());
                        }
                    }
            }
            // send to other ServerServices that this.ServerService is online
            for(ServerService ss : allClients){
                if(!clientsUsername.equals(ss.getClientsUsername())) {
                    System.out.println("I AM ONLINE !" + this.clientsUsername);
                    ss.sendMessageToClient("online " + this.clientsUsername + "\n");
                }
            }


        }
        else{
            this.sendMessageToClient("Login failed");
            System.out.println("Login failed");
        }

    }

    private void logoutUser() throws IOException {
        clientsServer.removeService(this);
        ArrayList<ServerService> allClients = this.clientsServer.getServerServices();
        // send to other ServerServices that this.ServerService is offline
        for(ServerService ss : allClients){
            if(!clientsUsername.equals(ss.getClientsUsername())) {
                ss.sendMessageToClient("offline " + this.clientsUsername + "\n");
            }
        }

        clientsSocket.close();
    }


    public boolean sendMessageToClient(String message) throws IOException {
        if(clientsUsername != null){
            System.out.println("am here");
            bufferedWriter.write(message);
            bufferedWriter.flush();
            return true;
        }
        return false;
    }

    private boolean sendObjectToClient(Object object) throws IOException {
        if(clientsUsername != null){
            System.out.println("am here");
            objectOutputStream.writeObject(object);
            return true;
        }
        return false;
    }


}
