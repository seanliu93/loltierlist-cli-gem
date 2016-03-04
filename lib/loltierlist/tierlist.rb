require_relative 'version'
require_relative 'champion'
  
class Loltierlist::TierList
  attr_reader :tier_hash
  def initialize
    @tier_hash = {
      tier0: {
        MID: [],
        JUNGLE: [],
        ADC: [],
        TOP: [],
        SUPPORT: []
        }, 
      tier1: {
        MID: [],
        JUNGLE: [],
        ADC: [],
        TOP: [],
        SUPPORT: []  
        }, 
      tier2: {
        MID: [],
        JUNGLE: [],
        ADC: [],
        TOP: [],
        SUPPORT: []   
        }, 
      tier3: {
        MID: [],
        JUNGLE: [],
        ADC: [],
        TOP: [],
        SUPPORT: []
        }, 
      tier4: {
        MID: [],
        JUNGLE: [],
        ADC: [],
        TOP: [],
        SUPPORT: []
        },
      tier5: {
        MID: [],
        JUNGLE: [],
        ADC: [],
        TOP: [],
        SUPPORT: []        
      }
    }
  end

  def tier_hash
    @tier_hash
  end

  def get_tier(tier, doc)
    if tier != "god" && tier != "strong" && tier != "above-average" && tier != "below-average" && tier != "weak" && tier != "bad"
      return
    else
      # fill in tier data
      doc.css("#" + tier + ".tier .rig a").each {|champ|
        champurl = "http://www.metasrc.com" + champ["href"]
        champ_id = champ.css("li").first
        champ_data = champ_id["id"].split("-")  
        # get role of champ
        role = champ_data[1].to_sym
        # create new champ object
        new_champ = Loltierlist::Champion.new(champ_data[0], champurl, role.to_s)
        # add champ to that role
        case tier
        when "god"
          @tier_hash[:tier0][role] << new_champ
        when "strong"
          @tier_hash[:tier1][role] << new_champ
        when "above-average"
          @tier_hash[:tier2][role] << new_champ
        when "below-average"
          @tier_hash[:tier3][role] << new_champ
        when "weak"
          @tier_hash[:tier4][role] << new_champ
        when "bad"
          @tier_hash[:tier5][role] << new_champ
        end
      }
    end
  end

  
  def get_tiers
    doc = Nokogiri::HTML(open("http://www.metasrc.com/na/5v5/tierlist"))

    self.get_tier("god", doc)
    self.get_tier("strong", doc)
    self.get_tier("above-average", doc)
    self.get_tier("below-average", doc)
    self.get_tier("weak", doc)
    self.get_tier("bad", doc)
  end

  def print_tier(tier)
    puts "\n\n"
    case tier
    when "tier0"
      puts "God Tier"
    when "tier1"
      puts "Strong Tier"
    when "tier2"
      puts "Above-Average Tier"
    when "tier3"
      puts "Below-Average Tier"
    when "tier4"
      puts "Weak Tier"
    when "tier5"
      puts "Bad Tier"
    end
    puts "****************************"
    print "Mid: "
    @tier_hash[tier.to_sym][:MID].each {|champ|
      if champ.name != @tier_hash[tier.to_sym][:MID][-1].name
        print "#{champ.name}, "
      else
        print "#{champ.name}"
      end
    }
    print "\nJungle: "
    @tier_hash[tier.to_sym][:JUNGLE].each {|champ|
      if champ.name != @tier_hash[tier.to_sym][:JUNGLE][-1].name
        print "#{champ.name}, "
      else
        print "#{champ.name}"
      end
    }
    print "\nADC: "
    @tier_hash[tier.to_sym][:ADC].each {|champ|
      if champ.name != @tier_hash[tier.to_sym][:ADC][-1].name
        print "#{champ.name}, "
      else
        print "#{champ.name}"
      end
    }
    print "\nTop: "
    @tier_hash[tier.to_sym][:TOP].each {|champ|
      if champ.name != @tier_hash[tier.to_sym][:TOP][-1].name
        print "#{champ.name}, "
      else
        print "#{champ.name}"
      end
    }
    print "\nSupport: "
    @tier_hash[tier.to_sym][:SUPPORT].each {|champ|
      if champ.name != @tier_hash[tier.to_sym][:SUPPORT][-1].name
        print "#{champ.name}, "
      else
        print "#{champ.name}"
      end
    }
    print "\n\n"
  end

end