require 'httparty'
require 'json'


def fetch_current_time(area, location)
  url = "http://worldtimeapi.org/api/timezone/#{area}/#{location}"
  response = HTTParty.get(url)
  JSON.parse(response.body)
end

def format_date_time(datetime)
  datetime.strftime('%Y-%m-%d %H:%M:%S')
end


area = ARGV[0]
location = ARGV[1]


time_data = fetch_current_time(area, location)
local_datetime = Time.parse(time_data['datetime'])
puts "The current time of #{area}, #{location} is #{format_date_time(local_datetime)}"
