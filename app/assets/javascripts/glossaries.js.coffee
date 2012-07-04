jQuery ->
  $('#glossary_sentence_tokens').tokenInput '/sentences.json'
    propertyToSearch: 'japanese'
    prePopulate: $('#glossary_sentence_tokens').data('pre')
    preventDuplicates: true
