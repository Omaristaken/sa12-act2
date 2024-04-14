require 'httparty'
require 'json'


def fetch_cryptocurrency_data
  url = 'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd'
  response = HTTParty.get(url)
  JSON.parse(response.body)
end

def top_5_cryptocurrencies(data)
  sorted_data = data.sort_by { |crypto| -crypto['market_cap'] }
  top_5 = sorted_data.take(5)
  top_5.map { |crypto| [crypto['name'], crypto['current_price'], crypto['market_cap']] }
end

def display_top_5_cryptocurrencies(top_5)
  puts "Top 5 cryptocurrencies:"
  top_5.each_with_index do |crypto, index|
    name = crypto[0]
    price = crypto[1]
    market_cap = crypto[2]
    puts "#{index + 1}. #{name}: $#{price} (Market Cap: $#{market_cap})"
  end
end



cryptocurrency_data = fetch_cryptocurrency_data
top_5 = top_5_cryptocurrencies(cryptocurrency_data)
display_top_5_cryptocurrencies(top_5)
