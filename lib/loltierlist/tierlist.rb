require_relative 'version'
require_relative 'champion'
  
class Loltierlist::TierList
  attr_reader :tier_hash, :name
  @@all = []

  def initialize(name)
    @roles = {
        MID: [],
        JUNGLE: [],
        ADC: [],
        TOP: [],
        SUPPORT: []        
    }
    @name = name
    @@all << self
  end

  def roles
    @roles
  end

  def self.all
    @@all
  end

  def self.get_tier(tier)
    doc = Nokogiri::HTML(open("http://www.metasrc.com/na/5v5/tierlist"))
    if doc.css("#" + tier + ".tier .rig a").length > 0
      tierlist = Loltierlist::TierList.new(tier)
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
        tierlist.roles[role] << new_champ
      }
      return tierlist
    else
      puts "That tier doesn't exist for the site this CLI uses!"
    end
  end

  def print_tier
    puts "\n\n"
    puts self.name + " Tier"
    puts "****************************"
    print "Mid: "
    @roles[:MID].each {|champ|
      if champ.name != @roles[:MID][-1].name
        print "#{champ.name}, "
      else
        print "#{champ.name}"
      end
    }
    print "\nJungle: "
    @roles[:JUNGLE].each {|champ|
      if champ.name != @roles[:JUNGLE][-1].name
        print "#{champ.name}, "
      else
        print "#{champ.name}"
      end
    }
    print "\nADC: "
    @roles[:ADC].each {|champ|
      if champ.name != @roles[:ADC][-1].name
        print "#{champ.name}, "
      else
        print "#{champ.name}"
      end
    }
    print "\nTop: "
    @roles[:TOP].each {|champ|
      if champ.name != @roles[:TOP][-1].name
        print "#{champ.name}, "
      else
        print "#{champ.name}"
      end
    }
    print "\nSupport: "
    @roles[:SUPPORT].each {|champ|
      if champ.name != @roles[:SUPPORT][-1].name
        print "#{champ.name}, "
      else
        print "#{champ.name}"
      end
    }
    print "\n\n"
  end

end