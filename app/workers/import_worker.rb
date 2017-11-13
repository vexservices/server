require 'uri'

class ImportWorker
  include Sidekiq::Worker

  def perform(job_id)
    if job = Job.find(job_id)
      Importer.new(job).import
    end
  end
end
