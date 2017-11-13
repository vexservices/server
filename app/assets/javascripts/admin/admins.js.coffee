jQuery ->
  FormatResult = (data) ->
    if !data.id
      return data.text

    $state = $('<span>' + data.name + '</span>')
    $state

  FormatSelection = (data) ->
    if !data.id
      return data.text

    $state = $('<span>' + data.name + '</span>')
    $state

  $('[data-js=admin-select2]').select2
    theme: 'bootstrap'
    allowClear: true
    minimumInputLength: 3
    placeholder: 'Select an option'

    ajax:
      url: '/admin/corporates'
      dataType: 'json'
      delay: 1000

      data: (params) ->
        {
          search: params.term,
          page: params.page
        }

      processResults: (data, params) ->
        params.page = data.page or 1

        {
          results: data.corporates,
          pagination: more: (params.page * 10) < data.total_count
        }

      cache: true

    escapeMarkup: (markup) ->
      markup

    templateResult: FormatResult
    formatSelection: FormatSelection
