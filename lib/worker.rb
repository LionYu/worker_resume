class Worker
  RESUMES_PATH = "#{Rails.public_path}/resumes"

  @@index = {}

  def self.index
    @@index
  end

  def self.refresh_index
    puts "+++++ refresh_index +++++"
    t1 = Time.now
    resume_counts = Dir["#{RESUMES_PATH}/*.txt"].count

    resume_counts.times do |t_index|
      t_index += 1
      filename = "#{t_index.to_s.rjust(5, '0')}.txt"

      printf "##{t_index} - filename: #{filename} \r"
      
      update_index_by_file(filename)
    rescue
      puts "Error Index File: #{filename}"
      next
    end

    t2 = Time.now
    puts "+++++ refresh_index finish: cost #{(t2 - t1).to_i} seconds +++++"
  end

  def self.resume_upload(resume_file)
    resume_filename = filename_for_new_upload
    FileUtils.mv resume_file.tempfile, "#{RESUMES_PATH}/#{resume_filename}"
    update_index_by_file(resume_filename)
  end

  private
    def self.filename_for_new_upload
      resume_counts = Dir["#{RESUMES_PATH}/*.txt"].count
      return "#{(resume_counts + 1).to_s.rjust(5, '0')}.txt"
    end

    def self.update_index_by_file(filename)
      file_id = filename.split(".").first.to_i
      words = File.read("#{RESUMES_PATH}/#{filename}", :encoding => "ASCII-8BIT")
                  .downcase.gsub(/\W/, ' ')
                  .split.uniq

      words.each do |w|
        @@index[w] ||= []
        @@index[w] << file_id
      end
    end
end
