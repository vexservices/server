jQuery ->
   $("[data-js=options-toggle]").change ->
      id = $(this).val()

      $($(this).data('target')).val('')
      $($(this).data('target') + ' option').hide()
      $($(this).data('target') + ' option[data-show=' + id + ']').show()
