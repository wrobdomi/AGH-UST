import java.io.IOException;
import java.net.ServerSocket;
import java.net.Socket;
import java.util.ArrayList;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

public class Server extends Thread{

    // storing services is any container is necessary in order to enable communication
    // between two instances of clients
    private ArrayList<ServerService> serverServices = new ArrayList<>();
    private int serverPort;

    public Server(int port) {
        this.serverPort = port;
    }

    public ArrayList<ServerService> getServerServices() {
        return serverServices;
    }

    @Override
    public void run() {

        try{

            // This app is a server and listens on port 8819
            ServerSocket serverSocket = new ServerSocket(serverPort);

            // Server should be running 24/7 so infinite loop is here
            while(true){

                // using thread pool:
                ExecutorService executorService = Executors.newFixedThreadPool(10);

                // accept any connection from any client
                Socket clientsSocket = serverSocket.accept();

                // create another thread to handle new client
                ServerService serverService = new ServerService(this, clientsSocket);
                serverServices.add(serverService);

                // kick off new clients thread
                // without using threadpool:
                // serverService.start();

                // using threadpool:
                executorService.submit(serverService);

            }



        }catch(IOException e){
            System.out.println("Creating server socket failed");
            e.printStackTrace();
        }

    }


    public void removeService(ServerService serverService) {
        serverServices.remove(serverService);
    }
}
