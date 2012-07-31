$(function(){
  var translation_id = "#translation_locale_token";
  $(translation_id).tokenInput($(translation_id).data('url'), {
    propertyToSearch: 'name',
    preventDuplicates: true
  });
});
