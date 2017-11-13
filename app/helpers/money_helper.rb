module MoneyHelper
  def money_collection
    @currencies ||= Money::Currency::table.inject([]) do |array, (id, currency)|
      array << [ "#{currency[:name]} (#{currency[:symbol]}) - #{currency[:iso_code]}", currency[:iso_code] ]
    end.sort_by { |currency| currency.first }
  end

  def number_to_currency_by_store_currency(value)
    number_to_currency value,
      unit: current_store.money_unit,
      separator: current_store.money_separator,
      delimiter: current_store.money_delimiter
  end
end
