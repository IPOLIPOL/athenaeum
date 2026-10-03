(in-package :cl-user)

(format t "~&Running Athenaeum smoke tests...~%")

(defun check (condition description)
  (if condition
      (format t "  PASS: ~A~%" description)
      (error "FAIL: ~A" description)))

(check (find-package :athenaeum.model)
       "ATHENAEUM.MODEL package exists")

(check (fboundp 'athenaeum.model:make-book)
       "BOOK constructor exists")

(check (fboundp 'athenaeum.model:make-author)
       "AUTHOR constructor exists")

(check (fboundp 'athenaeum.model:make-literature-quote)
       "LITERATURE-QUOTE constructor exists")

(let* ((author
         (athenaeum.model:make-author
          :id "test-author"
          :name "Test Author"
          :bio "Test biography"))
       (book
         (athenaeum.model:make-book
          :id "test-book"
          :title "Test Book"
          :authors (list author)
          :year 2026
          :category nil
          :description "Test description"
          :cover nil
          :quotes
          (list
           (athenaeum.model:make-literature-quote
            :text "Test quotation.")))))

  (check (string= (athenaeum.model:author-name author)
                  "Test Author")
         "Author can be constructed")

  (check (string= (athenaeum.model:book-title book)
                  "Test Book")
         "Book can be constructed")

  (check (= (length (athenaeum.model:book-authors book))
            1)
         "Book authors are stored correctly")

  (check (string= (athenaeum.model:author-name
                   (first (athenaeum.model:book-authors book)))
                  "Test Author")
         "Book author can be retrieved correctly")

  (check (= (athenaeum.model:book-year book)
            2026)
         "Book year is stored correctly")

  (check (= (length (athenaeum.model:book-quotes book))
            1)
         "Book quotations are stored correctly")

  (check (string= (athenaeum.model:literature-quote-text
                   (first (athenaeum.model:book-quotes book)))
                  "Test quotation.")
         "Book quotation text can be retrieved correctly"))

(format t "~&All smoke tests passed.~%")