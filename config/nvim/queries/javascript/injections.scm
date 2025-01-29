;; extends
((decorator
  (call_expression
    function: ((identifier) @_name
               (#eq? @_name "Component"))
    arguments: (arguments
                 (object
                   (pair
                     key: ((property_identifier) @_prop
                           (#eq? @_prop "template"))
                     value: ((template_string) @html (#offset! @html 0 1 0 -1))
                   )
               ))
  )
))

((decorator
  (call_expression
    function: ((identifier) @_name
               (#eq? @_name "Component"))
    arguments: (arguments
                 (object
                   (pair
                     key: ((property_identifier) @_prop
                           (#eq? @_prop "styles"))
                     value: (array
                              ((template_string) @css (#offset! @css 0 1 0 -1)))
                   )
               ))
  )
))
