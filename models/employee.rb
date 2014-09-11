class Employee
  include DataMapper::Resource  
  property :id,           Serial,	key: true, unique_index: true
  property :company_id,   Integer
  property :firstname,    String,	required: true, length: 1..99
  property :lastname,     String,   required: true, length: 1..99
  property :phone,        String,   required: true, length: 1..12
  property :created_at,   DateTime
  property :updated_at,   DateTime

  belongs_to :company
end