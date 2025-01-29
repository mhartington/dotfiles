;; extends
; (attribute
;   ((attribute_name) @_name
;    (#lua-match? @_name "[%[%(].*[%)%]]"))
;   (quoted_attribute_value
;     (attribute_value) @angular))
;
; (attribute
;   ((attribute_name) @_name
;    (#lua-match? @_name "^%*"))
;   (quoted_attribute_value
;     ((attribute_value) @angular)))
;
; (element
;   ((text) @angular
;    (#lua-match? @angular "%{%{.*%}%}")
;    (#offset! @angular 0 2 0 -2)))

; [state]="myState$ | async"
(attribute
  ((attribute_name) @_name
   (#lua-match? @_name "%[.*%]"))
  (quoted_attribute_value
    (attribute_value) @angular))

; (myEvent)="handle($event)"
(attribute
  ((attribute_name) @_name
   (#lua-match? @_name "%(.*%)"))
  (quoted_attribute_value
    ((attribute_value) @angular)))

; *ngIf="blorgy"
(attribute
  ((attribute_name) @_name
   (#lua-match? @_name "^%*.*"))
  (quoted_attribute_value
    ((attribute_value) @angular)))

; {{ someBinding }}
(element
  ((text) @angular
   (#lua-match? @angular "%{%{.*%}%}")
   (#offset! @angular 0 2 0 -2)))
