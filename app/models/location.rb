class Location < ActiveRecord::Base
  
  # only tested on postgresql
  DISTANCE_SQL = "(3959 * acos(cos(radians(:lat)) * cos(radians(lat)) * cos(radians(lng) - radians(:lng)) + sin(radians(:lat)) * sin(radians(lat))))"
  
  has_many :check_ins
  validates :name, :lat, :lng, :presence => true
  
  def self.within(from_lat, from_lng, miles)
    sanitized_distance_sql = send(:sanitize_sql, [DISTANCE_SQL, :lat => from_lat, :lng => from_lng])
    select_sql = '*, ' + sanitized_distance_sql + ' as distance'
    where_sql = sanitized_distance_sql + ' <= ?'
    
    select(select_sql).where(where_sql, miles)
  end
  
  def google_map_img_src(zoom = 14)
    "http://maps.google.com/maps/api/staticmap?sensor=true&center=#{lat},#{lng}&amp;#{zoom}=14&size=300x400&markers=color:blue|label:X|#{lat},#{lng}"
  end
  
end