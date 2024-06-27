require_relative '../lib/00_Darke_Trader'

describe '#scrape_crypto_prices' do
  it 'retourne un tableau de hachages contenant les noms et les prix des cryptomonnaies' do
    # Remplacez l'URL par celle que vous souhaitez tester
    url = 'https://coinmarketcap.com/all/views/all/'
    crypto_data = scrape_crypto_prices(url)

    expect(crypto_data).to be_an(Array)
    expect(crypto_data.first).to be_a(Hash)
    expect(crypto_data.first.keys).to include('Bitcoin') # Vérifiez si le nom 'Bitcoin' est présent
    expect(crypto_data.first['Bitcoin']).to be_a(Float) # Vérifiez si le prix est un nombre flottant
  end
end

require_relative '../lib/00_Darke_Trader'

describe 'fetch_crypto_prices' do
  it 'returns an array of hashes' do
    expect(fetch_crypto_prices).to be_an(Array)
    expect(fetch_crypto_prices.first).to be_a(Hash)
  end

  it 'contains valid cryptocurrency symbols and prices' do
    crypto_prices = fetch_crypto_prices
    expect(crypto_prices).not_to be_empty

    # Vérifiez la présence de quelques cryptomonnaies
    expect(crypto_prices).to include(
      { 'BTC' => a_value_within(0.1).of(5245.12) },
      { 'ETH' => a_value_within(0.1).of(217.34) }
      # Ajoutez d'autres cryptomonnaies ici
    )
  end
end