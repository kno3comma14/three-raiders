(fn incf [value ?by]
  `(set ,value (+ ,value (or ,?by 1))))

(fn decf [value ?by]
  `(set ,value (+ ,value (or ,?by 1))))

(fn with [t keys ?body]
  `(let [,keys ,t]
     (if ,?body
         ,?body
         ,keys)))

{: incf : decf : with}
