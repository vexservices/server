class Admins::GeneralPolicy < Admins::ApplicationPolicy
  attr_reader :admin

  def initialize(admin)
    @admin  = admin
  end
end
