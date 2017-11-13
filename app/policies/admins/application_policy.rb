module Admins
  class ApplicationPolicy
    attr_reader :admin, :record

    def initialize(admin, record)
      @admin  = admin
      @record = record
    end

    def admin?
      admin.master_admin?
    end

    def index?
      admin?
    end

    def new?
      admin?
    end

    def create?
      new?
    end

    def show?
      admin?
    end

    def edit?
      admin?
    end

    def update?
      edit?
    end

    def destroy?
      admin?
    end
  end
end
