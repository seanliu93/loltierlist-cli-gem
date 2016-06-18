require_relative 'tierlist'
require_relative 'cli'
class Loltierlist::Champion
  attr_accessor :name, :url, :role
  @@all = []
  
  def initialize(name, url, role)
    @name = name
    @url = url
    @role = role
    @champ_hash = {
      tier: nil,
      score: nil,
      win_rate: nil,
      role_rate: nil,
      pick_rate: nil,
      ban_rate: nil
    }
    @@all << self
  end

  def self.all
    @@all
  end

  def champ_hash
    @champ_hash
  end

  def get_data
    doc = Nokogiri::HTML(open(@url))
    count = 0
    doc.css(".stats_table tr").each {|element|
      header = element.css("th").text
      data = element.css("td").text
      if data != nil && count < 8
        # convert the header into symbol format to access hash, then set value to data
        header_sym = header.downcase.gsub(" ","_").chomp(":").to_sym
        champ_hash[header_sym] = data
        # i know i only want the first 7 fields for data
        count += 1
      end
    }
  end

  def print_data
    puts "\n\n\n#{@name} Champion Data"
    puts "-------------------------------------"
    puts "Role: #{@role}"
    puts "Tier: #{champ_hash[:tier]}"
    puts "Score: #{champ_hash[:score]}"
    puts "Win Rate: #{champ_hash[:win_rate]}"
    puts "Role Rate: #{champ_hash[:role_rate]}"
    puts "Pick Rate: #{champ_hash[:pick_rate]}"
    puts "Ban Rate: #{champ_hash[:ban_rate]}"
    puts "KDA Ratio: #{champ_hash[:kda_ratio]}"
  end

end 