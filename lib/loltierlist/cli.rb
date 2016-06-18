require_relative 'version'
require_relative 'tierlist'
require_relative 'champion'

class Loltierlist::CLI
  def start
    puts "\n"
    puts "************ League of Legends Current Tier List ****************"
    puts "\n"
    godTier = Loltierlist::TierList.get_tier("god")
    strongTier = Loltierlist::TierList.get_tier("strong")
    aboveAverageTier = Loltierlist::TierList.get_tier("above-average")
    belowAverageTier = Loltierlist::TierList.get_tier("below-average")
    weakTier = Loltierlist::TierList.get_tier("weak")
    badTier = Loltierlist::TierList.get_tier("bad")
    input = ""
    while input != "exit" do
      puts "\n\n\n"
      puts "Enter list to show the list of tiers again"
      puts "Enter list {tier} to show the list of a specific tier (e.g. 'list above-average')"
      puts "Enter champion name for more info"
      puts "Enter exit to enter the program"
      input = gets.strip.downcase
      if input == "list"
        Loltierlist::TierList.all.each do |tier|
          tier.print_tier
        end
      elsif input == "list god"
        godTier.print_tier
      elsif input == "list strong"
        strongTier.print_tier
      elsif input == "list above-average"
        aboveAverageTier.print_tier
      elsif input == "list below-average"
        belowAverageTier.print_tier
      elsif input == "list weak"
        weakTier.print_tier
      elsif input == "list bad"
        badTier.print_tier
      elsif input == "exit"
        puts "Goodbye."
      elsif !lookup_champ(input)
        puts "Bad input!"
      end
    end

  end

  def lookup_champ(name)
    Loltierlist::Champion.all.each {|champ|
      # allow champ name matches to be case insensitive, and no need for space for multi phrase names
      if champ.name.downcase == name.gsub(" ","")
        champ.get_data
        champ.print_data
        return true
      end
    }
    false
  end



end