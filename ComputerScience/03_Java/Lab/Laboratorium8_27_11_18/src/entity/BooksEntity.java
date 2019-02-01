package entity;

import javafx.beans.property.SimpleIntegerProperty;
import javafx.beans.property.SimpleStringProperty;

/**
 * Entity for DB records
 */
public class BooksEntity {

    // using properties for data binding
    private SimpleStringProperty isbn;
    private SimpleStringProperty title;
    private SimpleStringProperty author;
    private SimpleIntegerProperty year;


    public BooksEntity() {

        this.isbn = new SimpleStringProperty();
        this.title = new SimpleStringProperty();
        this.author = new SimpleStringProperty();
        this.year = new SimpleIntegerProperty();

    }

    public BooksEntity(SimpleStringProperty isbn, SimpleStringProperty title,
                       SimpleStringProperty author, SimpleIntegerProperty year) {
        this.isbn = isbn;
        this.title = title;
        this.author = author;
        this.year = year;
    }

    public String getIsbn() {
        return isbn.get();
    }

    public String getTitle() {
        return title.get();
    }

    public String getAuthor() {
        return author.get();
    }

    public int getYear() {
        return year.get();
    }

    public void setIsbn(String isbn) {
        this.isbn.set(isbn);
    }

    public void setTitle(String title) {
        this.title.set(title);
    }

    public void setAuthor(String author) {
        this.author.set(author);
    }

    public void setYear(int year) {
        this.year.set(year);
    }
}
