class Schedule < ActiveRecord::Base
  belongs_to :store
  has_and_belongs_to_many :products

  validates :initial, :final, :run_at, presence: true

  def self.able
    Time.use_zone('UTC') do
      time_start = (Time.current - 10.minutes).strftime("%H:%M:00")
      time_end   = (Time.current + 10.minutes).strftime("%H:%M:00")

      self.joins(:store)
        .where('stores.active = ?', true)
        .where('? BETWEEN DATE(initial) AND DATE(final)', Date.current)
        .where('pg_catalog.time(run_at) between ? AND ?', time_start, time_end )
    end
  end
end
