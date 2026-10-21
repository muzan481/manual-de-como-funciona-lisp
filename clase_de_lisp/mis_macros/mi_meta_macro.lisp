(defmacro meta-macro (macro-generada)
 (list 'defmacro macro-generada ( list 'simbolo 'var)
  (list 'list
           ''progn
                 (list 'list ''print 'simbolo ''":" 'var)
                 (list 'list ''print 'simbolo ''":" 'var)
                 (list 'list ''print 'simbolo ''":" 'var))))

