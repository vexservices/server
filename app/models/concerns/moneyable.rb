module Moneyable
  def normalize_money(value)
    value = value.to_s

    if value && value =~ /[,.]/
      value = value.gsub(/[,.]/, '').to_f / 100
    end

    value
  end

  def price=(value)
    value = normalize_money(value)
    write_attribute(:price, value)
  end

  def regular_price=(value)
    value = normalize_money(value)
    write_attribute(:regular_price, value)
  end
end
