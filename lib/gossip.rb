class Gossip
  attr_accessor :author, :content, :id

  def initialize(id, author, content)
    @author = author
    @content = content
    @id = id
  end

  def self.id_new
    ids = []
    Gossip.all.each do |current|
      ids << current.id.to_i
    end
    if ids.max then ids.max + 1 else 0 end
  end

  def save
    all_gossips = {}
    json = File.read('./db/gossip.json')
    if json != ""
      all_gossips = JSON.parse(json)
    else
      all_gossips = {}
    end
    all_gossips[@id] = { author: @author, content: @content}
    file = File.open("./db/gossip.json", 'w')
    file.write(JSON.pretty_generate(all_gossips))
    file.close
  end

  def self.all
    all_gossips = []
    json = File.read('./db/gossip.json')
    if json != ""
      JSON.parse(json).each do |current|
        all_gossips << Gossip.new(current[0], current[1]['author'], current[1]['content'])
      end
    else
      all_gossips = []
    end
    return all_gossips
  end

  def self.find_one(id)
    all_gossips = Gossip.all
    gossip = []
    all_gossips.each do |current|
      if current.id.to_i == id.to_i
        gossip = current
      end
    end
    return gossip
  end

  def update
    json = File.read('./db/gossip.json')
    all_gossips = JSON.parse(json)
    all_gossips.delete(@id.to_s)
    # comments = all_gossips[@id.to_i][1]['comments']
    all_gossips[@id.to_i] = { author: @author, content: @content}
    file = File.open("./db/gossip.json", 'w')
    file.write(JSON.pretty_generate(all_gossips))
    file.close
  end
end
