;; extends
(attribute
  ((attribute_name) @_name
   (#lua-match? @_name "%[.*%]")) @keyword)

(attribute
  ((attribute_name) @_name
   (#lua-match? @_name "%(.*%)")) @keyword)

(attribute
  ((attribute_name) @_name
   (#lua-match? @_name "^%*.*")) @keyword)

