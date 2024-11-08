package com.dockerators.bookapp.entity;

import jakarta.persistence.*;

import java.util.Objects;

@Entity
@Table(name = "book")
public class Book {
    @Column(name = "code", nullable = false)
    @Id
    private String code; // Book Code -> Primary Key
    @Column(name = "title", nullable = false)
    private String title; // Title of Book
    @Column(name = "author", nullable = false)
    private String author; // Author of Book
    @Column(name = "description", nullable = false)
    private String description; // Description of Book


    // No Argument Constructor
    public Book() {
    }
    // All Argument Constructor
    public Book(String title, String author, String description, String code) {
        this.title = title;
        this.author = author;
        this.description = description;
        this.code = code;
    }
    // Getters and Setters for all fields
    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    // Overridden toString() function to return in JSON {} format
    @Override
    public String toString() {
        return "Book{" +
                "title='" + title + '\'' +
                ", author='" + author + '\'' +
                ", description='" + description + '\'' +
                ", code='" + code + '\'' +
                '}';
    }

    // Overridden equals function : for controller level tests to mock service functionality
    // Returns true if two objects have the same value for all fields
    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Book student = (Book) o;
        return Objects.equals(title, student.getTitle()) &&
                Objects.equals(author, student.getAuthor()) &&
                Objects.equals(description, student.getDescription()) &&
                Objects.equals(code, student.getCode());
    }

    // Used in the equals function
    // Overridden to provide a consistent hash code for objects with equal field values.
    @Override
    public int hashCode() {
        return Objects.hash(title, author, description, code);
    }
}
