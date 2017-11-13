module DepartmentsHelper
  def sub_departments_collection
    Department.sub.map { |d| [ d.title, d.id, { :'data-show' => d.department_id.to_s } ] }
  end
end
