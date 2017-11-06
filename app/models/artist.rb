class Artist < ActiveRecord::Base
  has_many :songs
  has_many :genres, through: :songs

  def slug
    self.name.split.join("-").downcase
  end

  def self.find_by_slug(slug_name)
    real_name = slug_name.split("-")
    real_name.delete_if {|x| x == "-"}
    real_name.each {|s| s.capitalize}
    real_name = real_name.join(" ")
    artist = Artist.find_by(name: real_name)
  end

end
