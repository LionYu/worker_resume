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
      
      words = File.read("#{RESUMES_PATH}/#{filename}", :encoding => "ASCII-8BIT")
                  .downcase.gsub(/\W/, ' ')
                  .split.uniq

      words.each do |w|
        @@index[w] ||= []
        @@index[w] << t_index
      end
    rescue
      puts "Error Index File: #{filename}"
      next
    end

    t2 = Time.now
    puts "+++++ refresh_index finish: cost #{(t2 - t1).to_i} seconds +++++"
  end
end
