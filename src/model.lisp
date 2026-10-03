(defpackage :athenaeum.model
  (:use :cl)
  (:export
   ;; Author
   :author
   :make-author
   :author-id
   :author-name
   :author-bio

   ;; Image
   :image
   :make-image
   :image-src
   :image-alt
   :image-caption

   ;; Quote
   :literature-quote
   :make-literature-quote
   :literature-quote-text

   ;; Book
   :book
   :make-book
   :book-id
   :book-title
   :book-authors
   :book-subtitle
   :book-year
   :book-publisher
   :book-edition
   :book-description
   :book-url
   :book-cover
   :book-category
   :book-images
   :book-quotes

   ;; Category
   :category
   :make-category
   :category-id
   :category-title
   :category-icon
   :category-books

   ;; Library
   :library
   :make-library
   :library-title
   :library-categories))

(in-package :athenaeum.model)


(defstruct author
  id
  name
  bio)


(defstruct image
  src
  alt
  caption)


(defstruct literature-quote
  text)


(defstruct book
  id
  title
  authors
  subtitle
  year
  publisher
  edition
  description
  url
  cover
  category
  images
  quotes)


(defstruct category
  id
  title
  icon
  books)


(defstruct library
  title
  categories)