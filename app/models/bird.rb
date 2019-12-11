class Bird < ActiveRecord::Base
  has_many :sightings
  has_many :users, through: :sightings

  def self.scrape_attributes(url)
    html = open(url)
    # html = open("https://www.audubon.org/field-guide/bird/aberts-towhee")
    doc = Nokogiri::HTML(html)

    attributes = {
      :common_name => doc.css("h1.common-name").first.text,
      :scientific_name => doc.css("p.scientific-name").first.text.strip,
      :family => doc.css("table.collapse tr td").children[1].text.strip,
      :description => doc.css("section.bird-guide-section").first.children.children.children.first.text.strip,
      :conservation_status => doc.css("table.collapse tr td").first.text.strip,
      :habitat => doc.css("table.collapse tr td").children[2].text.strip,
      :feeding_behavior => doc.css("div.bird-guide-container section.sans div.row div.large-6").first.children.children[1].text.strip,
      :eggs => doc.css("div.bird-guide-container section.sans div.row div.large-6").first.children.children[3].text.strip,
      :young => doc.css("div.bird-guide-container section.sans div.row div.large-6").first.children.children[5].text.strip,
      :diet => doc.css("div.bird-guide-container section.sans div.row div.large-6:nth-child(2)").first.children.children[1].text.strip,
      :image => doc.css("div.medium-4 img").attribute("src").value
     }
  end

end
