json.pagination do
  json.pages         @schedules.total_pages
  json.current_page  params[:page] || 1
  json.total_entries @schedules.total_count
end

json.schedules @schedules do |schedule|
  json.id     schedule.id
  json.intial schedule.initial
  json.final  schedule.final
  json.run_at schedule.run_at
  json.products_count schedule.products_count
end
