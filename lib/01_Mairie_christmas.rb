require 'open-uri'
require 'nokogiri'

def get_townhall_email(townhall_url)
  page = Nokogiri::HTML(open(townhall_url))
  email = page.css('td:contains("Email")').first.next_element.text
  email
end

def get_townhall_urls
    url = 'https://www.la-mairie.com/departement/val-d-oise'
    page = Nokogiri::HTML(open(url))
    townhall_urls = []
  
    page.css('.annuaire-liste a').each do |link|
      townhall_urls << link['href']
    end
  
    townhall_urls
  end

  def fetch_all_townhall_emails
    townhall_urls = get_townhall_urls
    all_townhall_emails = []
  
    townhall_urls.each do |url|
      email = get_townhall_email(url)
      town_name = url.split('/').last.gsub('-', ' ').capitalize
      all_townhall_emails << { town_name => email }
    end
  
    all_townhall_emails
  end
  
  # Exécutez la méthode pour récupérer les adresses e-mail
  all_townhall_emails = fetch_all_townhall_emails
  
  # Affichez les résultats
  all_townhall_emails.each do |town|
    puts "#{town.keys.first}: #{town.values.first}"
  end
  