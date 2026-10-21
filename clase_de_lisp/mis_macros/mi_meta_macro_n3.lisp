(defmacro define-simple-macro
          (macro-name
           parameters
           expansion)

  (list

   'defmacro

   macro-name

   parameters

   expansion))
