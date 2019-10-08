const HTML_boolean_attributes = Set([
    :async
    :autofocus
    :autoplay
    :checked
    :contenteditable
    :controls
    :default
    :defer
    :disabled
    :formNoValidate
    :frameborder
    :hidden
    :ismap
    :itemscope
    :loop
    :multiple
    :muted
    :nomodule
    :novalidate
    :open
    :readonly
    :required
    :reversed
    :scoped
    :selected
    :typemustmatch
  ])

HTML_boolean = Dict{Symbol, Tuple{Vararg{N,Symbol}}}(
    :disabled => (:button , :fieldset, :input, :optgroup, :option, :select, :textarea),
    :checked => (:checkbox,)
  )
  
    
