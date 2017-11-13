jQuery ->
  $('#stores_tree').on('changed.jstree', (e, data) ->
    $('#client_store_ids').val(data.selected)
  ).jstree
    'core': 'data': 'url': (node) ->
      client_id = $('#stores_tree').data('client')
      path = '/en/stores/trees.json'

      return path + '?client_id=' + client_id

    'checkbox': 'keep_selected_style': false
    'plugins': [ 'checkbox', 'changed' ]
