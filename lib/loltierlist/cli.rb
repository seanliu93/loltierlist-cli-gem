require_relative 'version'
require_relative 'tierlist'
require_relative 'champion'

class Loltierlist::CLI
  def start
    puts "\n"
    puts "************ League of Legends Current Tier List ****************"
    puts "\n"
    tierlist = Loltierlist::TierList.new
    tierlist.get_tiers
    tierlist.print_tier("tier0")
    tierlist.print_tier("tier1")
    tierlist.print_tier("tier2")
    tierlist.print_tier("tier3")
    tierlist.print_tier("tier4")
    tierlist.print_tier("tier5")

    input = ""
    while input != "exit" do
      puts "\n\n\n"
      puts "Enter list to show the list of tiers again"
      puts "Enter list {tier} to show the list of a specific tier (e.g. 'list above-average')"
      puts "Enter champion name for more info"
      puts "Enter exit to enter the program"
      input = gets.strip.downcase
      if input == "list"
        tierlist.print_tier("tier0")
        tierlist.print_tier("tier1")
        tierlist.print_tier("tier2")
        tierlist.print_tier("tier3")
        tierlist.print_tier("tier4")
        tierlist.print_tier("tier5")
      elsif input == "list god"
        tierlist.print_tier("tier0")
      elsif input == "list strong"
        tierlist.print_tier("tier1")
      elsif input == "list above-average"
        tierlist.print_tier("tier2")
      elsif input == "list below-average"
        tierlist.print_tier("tier3")
      elsif input == "list weak"
        tierlist.print_tier("tier4")
      elsif input == "list bad"
        tierlist.print_tier("tier5")
      elsif input == "exit"
        puts "Goodbye."
      elsif !lookup_champ(input, tierlist)
        puts "Bad input!"
      end
    end

  end

  def lookup_champ(name, tierlist)
    tierlist.tier_hash.each {|tier, role_hash|
      role_hash.each {|role, champs|
        champs.each {|champ|
          # allow champ name matches to be case insensitive, and no need for space for multi phrase names
          if champ.name.downcase == name.gsub(" ","")
            champ.get_data
            champ.print_data
            return true
          end
        }
      }
    }
    false
  end



end