module ChangesHelper
  def link_to_close(change, html_options={})
    params = { :change => { checked: true } }
    html_options.reverse_merge!(class:'btn btn-sm btn-success', method: "put")

    link_to "<i class='fa fa-check'></i>".html_safe, admin_report_change_path(change, params), html_options
  end
end
