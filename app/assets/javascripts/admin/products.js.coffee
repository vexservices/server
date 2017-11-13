jQuery ->
  $("input[data-select=true]").click (event) ->
    if $(this).is(':checked')
      $(":checkbox").each ->
        @checked = true
    else
      $(":checkbox").each ->
        @checked = ""

  $("input[data-check=checkbox]").click (event) ->
    if $('.checkbox:checked').length > 0
      $($(this).data('target')).show()
    else
      $($(this).data('target')).hide()

  $("a[data-toggle=true]").click (e) ->
    element = $($(this).data('target'))
    element.toggle()