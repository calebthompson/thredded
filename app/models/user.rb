class User
  include Mongoid::Document
  include Mongoid::Timestamps
  ROLES = %w[superadmin admin moderator member user]

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable, 
         :recoverable, :rememberable, :trackable, :validatable

  field :name
  references_many :messageboards, :stored_as => :array, :inverse_of => :users
  embeds_many :roles
  
  validates_presence_of :name
  validates_uniqueness_of :name, :email, :case_sensitive => false
  attr_accessible :name, :email, :password, :password_confirmation
end
