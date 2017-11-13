namespace :schedules do
  task :run => :environment do
    schedules = Schedule.able
    ScheduleService.new(schedules).publish
  end
end
