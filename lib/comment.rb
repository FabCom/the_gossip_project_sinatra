class Comment
  attr_accessor :id, :author, :content, :date, :gossip_id

  def initialize(id, gossip_id, author, content, date)
    @id = id
    @gossip_id = gossip_id
    @author = author
    @content = content
    @date = date
  end

  def self.id_new
    ids = []
    Comment.all.each do |current|
      ids << current.id.to_i
    end
    if ids.max then ids.max + 1 else 0 end
  end

  def save
    all_comments = {}
    json = File.read('./db/comments.json')
    if json != ""
      all_comments = JSON.parse(json)
    else
      all_comments = {}
    end
    all_comments[@id] = { author: @author, gossip_id: @gossip_id, content: @content, date: @date}
    file = File.open("./db/comments.json", 'w')
    file.write(JSON.pretty_generate(all_comments))
    file.close
  end

  def self.find_many(gossip_id)
    Comment.all.select {|current| current.gossip_id == gossip_id.to_i }
  end

  def self.all
    all_comments = []
    json = File.read('./db/comments.json')
    if json != ""
      JSON.parse(json).each do |current|
        all_comments << Comment.new(current[0], current[1]['gossip_id'], current[1]['author'], current[1]['content'], current[1]['date'])
      end
    else
      all_comments = []
    end
    return all_comments
  end
end
