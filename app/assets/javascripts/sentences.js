$(function(){
  var glossary_id = "#sentence_definition_tokens";
  $(glossary_id).tokenInput($(glossary_id).data('url'), {
    propertyToSearch: 'content',
    preventDuplicates: true
  });
});
