; The qualification of a top-level member: the relation it reads or derives
(rule
  (qual_expr
    pattern: (path_pattern
      path: (path [(identifier) (quoted_identifier)] @type))))

; Attributes inside records and sums, like the keys of JSON, YAML and Nix
(record
  (qual_expr
    pattern: (path_pattern
      path: (path [(identifier) (quoted_identifier)] @variable.other.member))
    value: (_)))
(sum
  (qual_expr
    pattern: (path_pattern
      path: (path [(identifier) (quoted_identifier)] @variable.other.member))
    value: (_)))

; The shorthand [a] is an attribute bound to a variable of the same name: it is highlighted as a variable, since that is
; what other members join on. Themes without variable.other show it as a plain variable.
(record
  (qual_expr
    pattern: (path_pattern
      path: (path [(identifier) (quoted_identifier)] @variable.other))
    !value))
(sum
  (qual_expr
    pattern: (path_pattern
      path: (path [(identifier) (quoted_identifier)] @variable.other))
    !value))

; Variables in value position
(variable
  (path [(identifier) (quoted_identifier)] @variable))

(call
  function: (identifier) @function.builtin)

(denominator
  homomorphism: (identifier) @type.builtin)

(string) @string
(escape_sequence) @constant.character.escape
(number) @constant.numeric
(comment) @comment

["=" "!=" "<" "<=" ">" ">="] @operator
"<-" @keyword.operator
["?" "*" "/"] @operator

["[" "]" "{" "}" "(" ")"] @punctuation.bracket
["," "." ":"] @punctuation.delimiter
(stratum_separator) @punctuation.special
