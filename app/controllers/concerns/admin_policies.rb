module AdminPolicies
  extend ActiveSupport::Concern

  included do
    before_action :validate_admin_policies
  end

  private

    def validate_admin_policies
      admin_authorize default_policy.index?
    end

    def default_policy
      Admins::GeneralPolicy.new(current_admin)
    end
end
