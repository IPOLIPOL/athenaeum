;;;; athenaeum.asd

(asdf:defsystem "athenaeum"
  :description "Personal literature library"
  :version "0.1.0"
  :serial t
  :components
  ((:file "src/model")
   (:file "src/html")
   (:file "src/build")))
