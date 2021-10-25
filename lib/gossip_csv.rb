class Gossip
  attr_accessor :author, :content, :id

  def initialize(id="", author, content)
    @id = id
    @author = author
    @content = content
  end

  def save
    CSV.open("./db/gossip.csv", "ab") do |csv|
      csv << [@author, @content]
    end
  end

  def self.all
    all_gossips = []
    CSV.read("./db/gossip.csv").each_with_index do |csv_line, index|
      all_gossips << Gossip.new(index, csv_line[0], csv_line[1])
    end
    return all_gossips
  end

  def self.find_one(id)
    all_gossips = Gossip.all
    one_gossip = all_gossips[id.to_i]
  end

  def update
    all_gossips = Gossip.all
    all_gossips[@id.to_i] = Gossip.new(@id.to_i, @author, @content)
    CSV.open("./db/gossip.csv", "w") do |csv|
      all_gossips.each do |current|
        csv << [current.author, current.content]
      end
    end
  end
end
