$(function(){
  var sentence_id = "#glossary_sentence_tokens";
  $(sentence_id).tokenInput($(sentence_id).data('url'), {
    propertyToSearch: 'japanese',
    preventDuplicates: true
  });

  var glossary_id = "#glossary_similar_glossary_tokens";
  $(glossary_id).tokenInput($(glossary_id).data('url'), {
    propertyToSearch: 'content',
    preventDuplicates: true
  });
});
