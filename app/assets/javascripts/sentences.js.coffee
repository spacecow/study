jQuery ->
  $('#sentence_glossary_tokens').tokenInput '/glossaries.json'
    propertyToSearch: 'japanese'
    prePopulate: $('#sentence_glossary_tokens').data('pre')
    preventDuplicates: true
