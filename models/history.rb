class History
  include DataMapper::Resource  
  property :id,           Serial,	key: true, unique_index: true
  property :level, 		  String
  property :event,		  String
  property :created_at,   DateTime
end