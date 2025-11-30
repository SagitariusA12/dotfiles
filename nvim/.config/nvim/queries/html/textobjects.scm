;; ~/.config/nvim/queries/html/textobjects.scm
;; Define textobjects para HTML, otimizado para navegação e seleção

;; 1) Tag inteira (outer): inclui start_tag, conteúdo e end_tag
(element
  (start_tag) @tag.outer.start
  .
  (_)* @tag.inner
  .
  (end_tag)? @tag.outer.end) @tag.outer

;; 2) Conteúdo interno da tag (inner): apenas o conteúdo entre start_tag e end_tag
(element
  (start_tag)
  .
  (_) @tag.inner
  .
  (end_tag)?)

;; 3) Nome da tag (para seleção precisa do nome em start_tag ou end_tag)
(start_tag
  (tag_name) @tag.name)

(end_tag
  (tag_name) @tag.name)

;; 4) Self-closing tags (tratadas como outer e inner, já que não têm conteúdo)
(self_closing_tag) @tag.outer

;; 5) Atributos de tags (para navegação/seleção de atributos em start_tag)
(start_tag
  (attribute
    (attribute_name) @attribute.name
    (quoted_attribute_value)? @attribute.value)?)

;; 6) Texto dentro de elementos (útil para selecionar conteúdo textual)
(text) @text.inner
