$(function(){
  var similar_id = "#kanji_similar_tokens";
  $(similar_id).tokenInput($(similar_id).data('url'), {
    propertyToSearch: 'symbol',
    preventDuplicates: true
  });
});
