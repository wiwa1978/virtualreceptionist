class Company
  include DataMapper::Resource  
  property :id,           Serial,	key: true, unique_index: true
  property :name,    	  String,	required: true, length: 1..99
  property :created_at,   DateTime
  property :updated_at,   DateTime

  has n, :employees, :constraint => :destroy
end