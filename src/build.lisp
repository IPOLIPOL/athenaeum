(defpackage :athenaeum.build
  (:use :cl)
  (:import-from :athenaeum.model
                :library
                :library-categories)
  (:import-from :athenaeum.html
                :write-library-html)
  (:export
   :build-site))


(in-package :athenaeum.build)


(defun ensure-directory (pathname)
  (ensure-directories-exist pathname))


(defun load-library-data ()
  "Load the authored catalogue and construct the library model."

  (let ((data-file "data/library.lisp"))

    (unless (probe-file data-file)
      (error "Literature data file not found: ~A" data-file))

    (load data-file)

    ;; MAKE-LIBRARY-DATA is defined by data/library.lisp.
    (let ((function
            (symbol-function
             (find-symbol "MAKE-LIBRARY-DATA"
                          :athenaeum.model))))

      (let ((library (funcall function)))

        (unless (typep library 'library)
          (error
           "DATA/LIBRARY.LISP did not return an ATHENAEUM.MODEL:LIBRARY."))

        library))))


(defun write-index (library pathname)
  (with-open-file (stream pathname
                          :direction :output
                          :if-exists :supersede
                          :if-does-not-exist :create
                          :external-format :utf-8)

    (write-library-html stream library)))


(defun build-site ()
  (let* ((site-directory "site/")
         (index-file "site/index.html")
         (library (load-library-data)))

    (ensure-directory site-directory)

    (write-index library index-file)

    (format t "~&Built ~A~%" index-file)
    (format t "Categories: ~D~%"
            (length (library-categories library)))

    index-file))