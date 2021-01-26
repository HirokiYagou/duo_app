json.array! @exercises do |exercise|
  json.term_id exercise.term_id
  json.score exercise.score
end