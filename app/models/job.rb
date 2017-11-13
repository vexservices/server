class Job < ActiveRecord::Base
  belongs_to :store
  mount_uploader :file, ExcelUploader

  validates :name, :file, :import_type, presence: true

  after_create :set_worker

  enum import_type: { product: 0, branch_store: 1, department: 2 }

  def set_worker
    ImportWorker.perform_at(10.seconds.from_now,self.id)
  end
end
