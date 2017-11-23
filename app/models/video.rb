class Video < ActiveRecord::Base
  scope :master, -> { where(franchise_id: nil) }

  belongs_to :franchise, touch: true

  before_validation :setup_html

  validates :html, :locale, presence: true

  delegate :name, to: :franchise, prefix: true, allow_nil: true

  private

    def setup_html
      if external_link_changed?
        self.html = %Q(
          <iframe src="#{external_link}" width="500" height="280" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen>
          </iframe>
        )
      end
    end
end
