import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

public class MainServer {

    public static void main(String[] args) {


        ExecutorService executorService = Executors.newFixedThreadPool(10);


        Server server = new Server(8819);


        // without using thread pool:
        // server.start();

        // using thread pool:
        executorService.submit(server);

    }



}
