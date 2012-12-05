$(function(){
  var sentence_id = "#glossary_sentence_tokens";
  $(sentence_id).tokenInput($(sentence_id).data('url'), {
    propertyToSearch: 'japanese',
    preventDuplicates: true
  });

  var synonym_id = "#glossary_synonym_tokens";
  $(synonym_id).tokenInput($(synonym_id).data('url'), {
    propertyToSearch: 'content',
    preventDuplicates: true
  });

  var similar_id = "#glossary_similar_tokens";
  $(similar_id).tokenInput($(similar_id).data('url'), {
    propertyToSearch: 'content',
    preventDuplicates: true
  });

  var antonym_id = "#glossary_antonym_tokens";
  $(antonym_id).tokenInput($(antonym_id).data('url'), {
    propertyToSearch: 'content',
    preventDuplicates: true
  });
});
