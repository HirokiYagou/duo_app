json.array! @terms do |term|
  json.english term.english
  json.term_id term.id
end