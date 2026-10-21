(defmacro generar-macro (mi-macro)
  (list
   'defmacro

   mi-macro

   (list 'simbolo 'var)

   (list
    'list

    ''progn

    (list
     'list
     (list 'quote 'print)
     'simbolo)

    (list
     'list
     (list 'quote 'print)
     'var)

    (list
     'list
     (list 'quote 'print)
     'simbolo)

    (list
     'list
     (list 'quote 'print)
     'var)

    (list
     'list
     (list 'quote 'print)
     'simbolo)

    (list
     'list
     (list 'quote 'print)
     'var))))