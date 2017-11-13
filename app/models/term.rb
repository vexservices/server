class Term < ActiveRecord::Base
  translates :text

  def self.version
    first ? first.version : 0
  end

  def with_franchise_name(name = 'Virtual Exchange')
    text.gsub('%{name}', name) if text.present?
  end
end
