class Admins::UserPolicy < Admins::CorporatePolicy
  def initialize(admin, record)
    @admin = admin
    @record = record.store.corporate
  end

  def destroy?
    false
  end
end
