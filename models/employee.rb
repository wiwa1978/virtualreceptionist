class Employee
  include DataMapper::Resource  
  property :id,           Serial,	key: true, unique_index: true
  property :company_id,   Integer,  required:true
  property :firstname,    String,	required: true, length: 1..20
  property :lastname,     String,   required: true, length: 1..30
  property :phone,        String,   required: true, length: 1..13
  property :email,		  String,	required: true, length: 1..60
  property :created_at,   DateTime
  property :updated_at,   DateTime

  belongs_to :company
end


