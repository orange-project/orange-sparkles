class Bar < Orange::Carton
  id
  front do
    text :foo
    text :bar
    markdown :banana
  end
  admin do
    
    text :baz
    fulltext :qux
  end
  as_sparkles_resource
end