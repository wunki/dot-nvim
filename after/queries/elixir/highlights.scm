; extends

; Module attributes like @impl, @doc, @spec should be highlighted as attributes
(unary_operator
  operator: "@"
  operand: (call
    target: (identifier) @attribute))

(unary_operator
  operator: "@"
  operand: (identifier) @attribute)
