require 'open-uri'
require 'nokogiri'
require 'json'

# URL du site CoinMarketCap
url = 'https://coinmarketcap.com/all/views/all/'

# Méthode pour extraire les données
def scrape_crypto_prices(url)
  doc = Nokogiri::HTML(open(url))
  crypto_prices = []

  # Sélectionne les éléments contenant les noms et les prix des cryptomonnaies
  doc.css('.cmc-table-row').each do |row|
    crypto_name = row.css('.cmc-table__column-name').text
    crypto_price = row.css('.cmc-table__cell--sort-by__price').text.gsub('$', '').to_f

    # Ajoute les données dans un hachage
    crypto_hash = { crypto_name => crypto_price }
    crypto_prices << crypto_hash
  end

  crypto_prices
end

# Appelle la méthode et stocke les données dans un tableau
crypto_data = scrape_crypto_prices(url)

# Affiche le tableau de hachages
crypto_data.each do |crypto|
  puts crypto
end

def fetch_crypto_prices
  url = 'https://api.coinmarketcap.com/v1/ticker/?limit=100'
  response = open(url).read
  data = JSON.parse(response)

  crypto_prices = data.map do |crypto|
    { crypto['symbol'] => crypto['price_usd'].to_f }
  end

  crypto_prices
end

# Exécutez la méthode pour récupérer les cours
crypto_prices = fetch_crypto_prices

# Affichez les résultats
crypto_prices.each do |crypto|
  puts "#{crypto.keys.first}: #{crypto.values.first}"
end
