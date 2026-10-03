(defpackage :athenaeum.html
  (:use :cl)
  (:import-from :athenaeum.model
                :book
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
                :book-images
                :book-quotes

                :author-name

                :image-src
                :image-alt
                :image-caption

                :literature-quote
                :literature-quote-text

                :category
                :category-id
                :category-title
                :category-icon
                :category-books

                :library-title
                :library-categories)
  (:export
   :write-library-html
   :write-book))


(in-package :athenaeum.html)


(defun html-escape (value)
  "Escape a value for safe insertion into HTML text or attributes."
  (let ((text (princ-to-string value)))
    (with-output-to-string (out)
      (loop for char across text
            do (case char
                 (#\& (write-string "&amp;" out))
                 (#\< (write-string "&lt;" out))
                 (#\> (write-string "&gt;" out))
                 (#\" (write-string "&quot;" out))
                 (#\' (write-string "&#39;" out))
                 (otherwise
                  (write-char char out)))))))


(defun write-authors (stream authors)
  (when authors
    (format stream "~%        <p class=\"authors\">")
    (loop for author in authors
          for first = t then nil
          do
             (unless first
               (write-string ", " stream))
             (write-string
              (html-escape (author-name author))
              stream))
    (write-string "</p>" stream)))


(defun write-images (stream images)
  (when images
    (format stream "~%        <section class=\"images\">")
    (dolist (image images)
      (format stream
              "~%          <figure>"
              )

      (format stream
              "~%            <img src=\"~A\" alt=\"~A\">"
              (html-escape (image-src image))
              (html-escape (or (image-alt image) "")))

      (when (image-caption image)
        (format stream
                "~%            <figcaption>~A</figcaption>"
                (html-escape (image-caption image))))

      (format stream "~%          </figure>"))
    (format stream "~%        </section>")))


(defun write-quotes (stream quotes)
  (when quotes
    (format stream "~%        <section class=\"quotes\">")
    (format stream "~%          <h3>Quotes</h3>")

    (dolist (quote quotes)
      (when (typep quote 'literature-quote)
        (format stream
                "~%          <blockquote>~A</blockquote>"
                (html-escape
                 (literature-quote-text quote)))))

    (format stream "~%        </section>")))


(defun write-book (stream book)
  (format stream "~%      <article class=\"book\" id=\"~A\">"
          (html-escape (book-id book)))

  (format stream "~%        <h3>~A</h3>"
          (html-escape (book-title book)))

  (write-authors stream
                 (book-authors book))

  (when (book-subtitle book)
    (format stream
            "~%        <p class=\"subtitle\">~A</p>"
            (html-escape (book-subtitle book))))

  (when (book-year book)
    (format stream
            "~%        <p class=\"year\">~A</p>"
            (html-escape (book-year book))))

  (when (book-publisher book)
    (format stream
            "~%        <p class=\"publisher\">~A</p>"
            (html-escape (book-publisher book))))

  (when (book-edition book)
    (format stream
            "~%        <p class=\"edition\">~A</p>"
            (html-escape (book-edition book))))

  (when (book-cover book)
    (format stream
            "~%        <img class=\"book-cover\" src=\"~A\" alt=\"Cover of ~A\">"
            (html-escape (book-cover book))
            (html-escape (book-title book))))

  (when (book-description book)
    (format stream
            "~%        <p class=\"description\">~A</p>"
            (html-escape (book-description book))))

  (when (book-url book)
    (format stream
            "~%        <p class=\"source\"><a href=\"~A\">Source / book</a></p>"
            (html-escape (book-url book))))

  (write-images stream
                (book-images book))

  (write-quotes stream
                (book-quotes book))

  (format stream "~%      </article>~%"))


(defun write-category (stream category)
  (format stream "~%    <section class=\"category\" id=\"~A\">"
          (html-escape (category-id category)))

  (format stream
          "~%      <h2>~A ~A</h2>"
          (html-escape (category-icon category))
          (html-escape (category-title category)))

  (dolist (book (category-books category))
    (write-book stream book))

  (format stream "~%    </section>~%"))


(defun write-library-html (stream library)
  (format stream "<!DOCTYPE html>~%")
  (format stream "<html lang=\"en\">~%")

  (format stream "<head>~%")
  (format stream "  <meta charset=\"utf-8\">~%")
  (format stream "  <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">~%")
  (format stream "  <title>~A</title>~%"
          (html-escape (library-title library)))
  (format stream "  <link rel=\"stylesheet\" href=\"styles.css\">~%")
  (format stream "</head>~%")

  (format stream "<body>~%")
  (format stream "  <main>~%")

  (format stream "    <header>~%")
  (format stream "      <h1>~A</h1>~%"
          (html-escape (library-title library)))
  (format stream "    </header>~%")

  (dolist (category (library-categories library))
    (write-category stream category))

  (format stream "  </main>~%")
  (format stream "</body>~%")
  (format stream "</html>~%"))