# logs_generator.rb

require 'date'
require 'time'

def next_minute(current_time)
  # Increment the current time by one minute
  current_time + 10
end

def change_time(current_time)
  if [true, false].sample 
    current_time + rand(1..120)
  else
    current_time - rand(1..120)
  end
end

def random_operation
  %w[ Transfer Withdrawal Rejected Factoring Leasing Discount ].sample
end

def operation_description(operation)
  "#{operation} between account #{rand(1..10)} and account #{rand(1..10)}, amount: #{rand(100..1000)}"
end

# Set the starting date and time
start_time = Time.now
# Get the number of entries from an environment variable, default to 10 if not set
num_entries = (ENV['NUM_ENTRIES'] || 10).to_i

# File to write to
file_name = "output.csv"

# Open a file in write mode

['Citi', 'Bank_of_America', 'Chase', 'Wells_Fargo', 'HSBC', 'BanCoppel', 'BBVA', 'Banorte', 'Inbursa'].each do |bank|
  File.open("#{bank}_#{file_name}", "w") do |file|
    start_time = change_time(Time.now)
    num_entries.times do
      operation = random_operation 
      csv_line = "\"#{start_time.iso8601}\",\"#{bank}\",\"#{operation}\",\"#{operation_description(operation)}\""
      file.puts csv_line
      start_time = next_minute(start_time)
    end
  end
  puts "CSV data written to #{bank}_#{file_name}"
end
