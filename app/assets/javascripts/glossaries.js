$(function(){
  var sentence_id = "#glossary_sentence_tokens";
  $(sentence_id).tokenInput($(sentence_id).data('url'), {
    propertyToSearch: 'japanese',
    preventDuplicates: true
  });
});
