import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.*;


public class DatabaseService {

    private static final String CONNECTION_STRING =         "jdbc:mysql://mysql.agh.edu.pl/";

    // --------------------------------------------------------------------- //
    // --------- DB TABLE ------------------------------------------------- //

    // db table = results
    private static final String TABLE_NAME_RESULTS =        "results";
    private static final String COLUMN_NAME_USERNAME =      "username";
    private static final String COLUMN_NAME_RESULT  =       "result";

    // --------------------------------------------------------------------- //
    // --------------------------------------------------------------------- //


    private static Connection connection = null;
    private static Statement statement =   null;
    private static ResultSet resultSet =   null;

    private static String dbUser =      "dwrobel";
    private static String dbPassword =  "baza";

    private static DatabaseService databaseService = null;

    /**
     * singleton design pattern
     */
    private DatabaseService() {}
    public static synchronized  DatabaseService getInstance() {
        if(databaseService == null){
            databaseService = new DatabaseService();
        }
        return databaseService;
    }

    /**
     * connects to DB
     */
    public static void connect() {

        try {
            // registering jdbc driver
            // REDUNDANT ! Not necessary since JDBC 4.0 or above.
            // Class.forName("com.mysql.jdbc.Driver").newInstance();

            // getting connection
            String connectionURL = CONNECTION_STRING + dbUser;
            connection = DriverManager.getConnection(connectionURL, dbUser, dbPassword);
        } catch (SQLException ex) {
            // handle any errors
            System.out.println("SQLException: " + ex.getMessage());
            System.out.println("SQLState: " + ex.getSQLState());
            System.out.println("VendorError: " + ex.getErrorCode());
        } catch (Exception e) {
            e.printStackTrace();
        }
    }


    /**
     * Closes connection, statement and resultSet
     */
    public static void close() {
        if (resultSet != null) {
            try {
                resultSet.close();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            resultSet = null;
        }
        if (statement != null) {
            try {
                statement.close();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            statement = null;
        }
        if( connection != null ) {
            try{
                connection.close();
            } catch( SQLException ex ){
                ex.printStackTrace();
            }
            connection = null;
        }
    }


    public static boolean insertResults(String username, int result){
        connect();


        System.out.println("IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII");

        // create query for the user
        StringBuilder sb = new StringBuilder("INSERT INTO ");
        sb.append(TABLE_NAME_RESULTS);
        sb.append("(");
        sb.append(COLUMN_NAME_USERNAME);
        sb.append(", ");
        sb.append(COLUMN_NAME_RESULT);
        sb.append(")");
        sb.append(" VALUES (");
        sb.append(username);
        sb.append(", '");
        sb.append(result);
        sb.append("');");

        System.out.println(sb.toString());


        try{
            statement = connection.createStatement();
            // resultSet = statement.executeQuery(sb.toString());
            statement.execute(sb.toString());

        }
        catch(SQLException ex){
            // handle any errors
            System.out.println("SQLException: " + ex.getMessage());
            System.out.println("SQLState: " + ex.getSQLState());
            System.out.println("VendorError: " + ex.getErrorCode());
            return false;
        }

        close();

        return true;
    }



}
