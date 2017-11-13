class Order < ActiveRecord::Base
  CREDIT_CARDS = [
    ["Visa", "visa"],
    ["MasterCard", "master"],
    ["Discover", "discover"],
    ["American Express", "american_express"]
  ]

  belongs_to :store

  attr_accessor :card_number, :card_verification, :plan

  validate :validate_card

  def make_recurring
    response = PaypalRecurring.new(store).create(credit_card)

    self.update_attribute(:log, response.inspect)

    response.success?
  end

  private

      def validate_card
        unless credit_card.valid?

          credit_card.errors.each do |message|
            field = message[0]
            msg = message[1].first

            error_field = if field == 'brand'
              :card_brand
            elsif field == 'number'
              :card_number
            elsif field == 'verification_value'
              :card_verification
            elsif field == 'year' || field == 'month'
              :card_expires_on
            elsif field == 'brand'
              :card_brand
            elsif field == 'first_name'
              :first_name
            elsif field == 'last_name'
              :last_name
            end

            errors.add error_field, msg
          end
        end
      end

      def credit_card
        @credit_card ||= ActiveMerchant::Billing::CreditCard.new(
          :brand              => card_brand,
          :number             => card_number,
          :verification_value => card_verification,
          :month              => card_expires_on.month,
          :year               => card_expires_on.year,
          :first_name         => first_name,
          :last_name          => last_name
        )
      end
end
