namespace :images do
  task :recreate => :environment do
    Image.all.find_each do |image|
      image.skip_extension_with_list = true
      image.process_file_upload = true
      image.file.recreate_versions!
    end
  end

  task :dimensions => :environment do
    Image.all.find_each do |image|
      image.save
    end
  end
end
