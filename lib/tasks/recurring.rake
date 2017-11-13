namespace :recurring do
  task :check => :environment do
    date = Date.current

    if %w(10 15 20 25 30).include? date.day.to_s
      recurrings = Recurring.actives

      recurrings.find_each do |recurring|
        RecurringService.new(recurring).check
        sleep(5)
      end
    end
  end

  task :create_invoice => :environment do
    date = Date.current

    if date.day == 1
      generator = InvoiceGeneratorService.new
      generator.create
    end
  end

  task :manual_invoice => :environment do
    date = Date.current

    if date.day == 1
      generator = InvoiceService.new
      generator.create
    end
  end
end
