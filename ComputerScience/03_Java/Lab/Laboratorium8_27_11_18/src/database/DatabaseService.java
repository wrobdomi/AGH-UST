package database;

import entity.BooksEntity;

import java.sql.*;
import java.util.ArrayList;

public class DatabaseService {

    private static final String CONNECTION_STRING = "jdbc:mysql://mysql.agh.edu.pl/";
    private static final String TABLE_NAME =        "books";
    private static final String COLUMN_ISBN =       "isbn";
    private static final String COLUMN_TITLE =      "title";
    private static final String COLUMN_AUTHOR =     "author";
    private static final String COLUMN_YEAR =       "year";

    private static final int connectionAttempts = 3;

    private static Connection connection = null;
    private static Statement statement =   null;
    private static ResultSet resultSet =   null;

    private static String dbUser;
    private static String dbPassword;

    public DatabaseService(String _dbUser, String _dbPassword) {
        dbUser = _dbUser;
        dbPassword = _dbPassword;
    }



    /**
     * initial try to connect to the db, if failed, tries another three times
     * if succeeded, breaks and returns true. The function is called after user logged to
     * the system
     * @return true if succeeded in connection in any attempt, false otherwise
     */
    public static boolean checkConnectionWithDatabase() {

        connect();

        if(connection != null){
                return true;
        }
        else{ // try another three times

                for(int i = 0; i < connectionAttempts; i++){

                    // (-) debugging
                    System.out.println("Trying to cennnect to db");
                    // (-)

                    connect();

                    if(connection != null){
                        return true;
                    }

                }
        }

        return false;
    }



    /**
     * creates connection to DB
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
     * Queries DB for all records in table
     * @return ArrayList of Objects related to records in DB
     */
    public static ArrayList<BooksEntity> queryAll(){

        // create query for all records
        StringBuilder sb = new StringBuilder("SELECT * FROM ");
        sb.append(TABLE_NAME);
        sb.append(";");

        // create container for entities
        ArrayList<BooksEntity> allBooks = new ArrayList<>();


        try{
            statement = connection.createStatement();
            resultSet = statement.executeQuery(sb.toString());
            while( resultSet.next() ){

                // (-) TO BE DELETED ! debugging ! :
                System.out.println("isbn: " + resultSet.getString("isbn") +
                                   "  title: " + resultSet.getString("title") +
                                   "  author: " + resultSet.getString("author") +
                                   "  year: " + resultSet.getInt("year"));
                // (-)

                BooksEntity singleBook = new BooksEntity();
                singleBook.setIsbn(resultSet.getString(COLUMN_ISBN));
                singleBook.setTitle(resultSet.getString(COLUMN_TITLE));
                singleBook.setAuthor(resultSet.getString(COLUMN_AUTHOR));
                singleBook.setYear(resultSet.getInt(COLUMN_YEAR));

                allBooks.add(singleBook);
            }
        }
        catch(SQLException ex){
            // handle any errors
            System.out.println("SQLException: " + ex.getMessage());
            System.out.println("SQLState: " + ex.getSQLState());
            System.out.println("VendorError: " + ex.getErrorCode());
        }

        close();

        return allBooks;
    }


    /**
     * queries DB for all books written by given author
     * @param surname Surname of the author
     * @return ArrayList of Objects related to records in DB
     */
    public static ArrayList<BooksEntity> queryByAuthorSurname(String surname) {

        // create query for all records for a specific author
        StringBuilder sb = new StringBuilder("SELECT * FROM ");
        sb.append(TABLE_NAME);
        sb.append(" WHERE ");
        sb.append(COLUMN_AUTHOR);
        sb.append(" LIKE \"%");
        sb.append(surname);
        sb.append("\"");
        sb.append(";");

        // create container for entities
        ArrayList<BooksEntity> authorsBooks = new ArrayList<>();


        try{
            statement = connection.createStatement();
            resultSet = statement.executeQuery(sb.toString());
            while( resultSet.next() ){

                // (-) TO BE DELETED ! debugging ! :
                System.out.println(" ");
                System.out.println("isbn: " + resultSet.getString("isbn") +
                        "  title: " + resultSet.getString("title") +
                        "  author: " + resultSet.getString("author") +
                        "  year: " + resultSet.getInt("year"));
                // (-)

                BooksEntity singleBook = new BooksEntity();
                singleBook.setIsbn(resultSet.getString(COLUMN_ISBN));
                singleBook.setTitle(resultSet.getString(COLUMN_TITLE));
                singleBook.setAuthor(resultSet.getString(COLUMN_AUTHOR));
                singleBook.setYear(resultSet.getInt(COLUMN_YEAR));

                authorsBooks.add(singleBook);
            }
        }
        catch(SQLException ex){
            // handle any errors
            System.out.println("SQLException: " + ex.getMessage());
            System.out.println("SQLState: " + ex.getSQLState());
            System.out.println("VendorError: " + ex.getErrorCode());
        }

        close();

        return authorsBooks;

    }


    /**
     * queries DB for a book with given isbn
     * @param isbn isbn of the book
     * @return ArrayList of Objects related to records in DB
     */
    public static ArrayList<BooksEntity> queryByIsbn(String isbn) {

        // create query for all records from table for a specific isbn
        StringBuilder sb = new StringBuilder("SELECT * FROM ");
        sb.append(TABLE_NAME);
        sb.append(" WHERE ");
        sb.append(COLUMN_ISBN);
        sb.append(" = ");
        sb.append(isbn);
        sb.append(";");

        // create container for entities
        ArrayList<BooksEntity> isbnBook = new ArrayList<>();


        try{
            statement = connection.createStatement();
            resultSet = statement.executeQuery(sb.toString());
            while( resultSet.next() ){

                // (-) TO BE DELETED ! debugging ! :
                System.out.println(" ");
                System.out.println("isbn: " + resultSet.getString("isbn") +
                        "  title: " + resultSet.getString("title") +
                        "  author: " + resultSet.getString("author") +
                        "  year: " + resultSet.getInt("year"));
                // (-)

                BooksEntity singleBook = new BooksEntity();
                singleBook.setIsbn(resultSet.getString(COLUMN_ISBN));
                singleBook.setTitle(resultSet.getString(COLUMN_TITLE));
                singleBook.setAuthor(resultSet.getString(COLUMN_AUTHOR));
                singleBook.setYear(resultSet.getInt(COLUMN_YEAR));

                isbnBook.add(singleBook);
            }
        }
        catch(SQLException ex){
            // handle any errors
            System.out.println("SQLException: " + ex.getMessage());
            System.out.println("SQLState: " + ex.getSQLState());
            System.out.println("VendorError: " + ex.getErrorCode());
        }

        close();

        return isbnBook;
    }


    /**
     * Add book to DB
     * @param newBook object representing book entity
     * @return true if adding succeed, false otherwise
     */
    public static boolean addBook(BooksEntity newBook) {

        // create query to insert a book into table
        StringBuilder sb = new StringBuilder("INSERT INTO ");
        sb.append(TABLE_NAME);
        sb.append(" (");
        sb.append(COLUMN_ISBN);
        sb.append(", ");
        sb.append(COLUMN_TITLE);
        sb.append(", ");
        sb.append(COLUMN_AUTHOR);
        sb.append(", ");
        sb.append(COLUMN_YEAR);
        sb.append(") ");
        sb.append("VALUES (\"");
        sb.append(newBook.getIsbn());
        sb.append("\", \"");
        sb.append(newBook.getTitle());
        sb.append("\", \"");
        sb.append(newBook.getAuthor());
        sb.append("\", ");
        sb.append(newBook.getYear());
        sb.append(");");


        try{
            statement = connection.createStatement();
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



}
