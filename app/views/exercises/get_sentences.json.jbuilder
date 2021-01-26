json.array! @questions do |question|
  json.term_id question.term_id
  json.sentence_id question.sentence_id
  json.word_id question.word_id
  json.lesson question.lesson
  json.english question.english
  json.japanese question.japanese
end