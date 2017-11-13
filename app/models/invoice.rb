class Invoice < ActiveRecord::Base
  belongs_to :store

  before_create :set_number, :set_plan_name

  scope :pendent, ->{ where(paid_at: nil) }
  scope :delayed, ->{ pendent.where('DATE(created_at) < ?', Date.current - 10.days) }

  def value_by_locale
    if I18n.locale == :'pt-BR' && value_real.present? && !value_real.zero?
      value_real
    else
      value
    end
  end

  def status_by_pagseguro(status_pagseguro)
    if status_pagseguro.to_s == '3' || status_pagseguro.to_s == '4'
      StatusTypes::PAID
    elsif status_pagseguro.to_s == '5'
      StatusTypes::IN_DISPUTE
    elsif status_pagseguro.to_s == '6'
      StatusTypes::REFUNDED
    elsif status_pagseguro.to_s == '7'
      StatusTypes::CANCELED
    else
      StatusTypes::WAIT_PAYMENT
    end
  end

  def paid?
    paid_at.present?
  end

  private

    def set_number
      self.number = loop do
        random_number = Digest::SHA1.hexdigest([Time.now, rand].join)[0..5].upcase
        break random_number unless Invoice.exists?(number: random_number)
      end
    end

    def set_plan_name
      self.plan_name = store.corporate_plan_name if store
    end
end
