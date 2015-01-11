class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  # before_create :create_login

  # Virtual attribute for authenticating by either name or email
  # This is in addition to a real persisted field like 'name'
  # attr_accessible :name
  acts_as_voter

  has_many :links
  validates :name,
  	:uniqueness => {
    :case_sensitive => false
  }

  # def create_login
  #   email = self.email.split(/@/)
  #   login_taken = User.where( :login => email[0]).first
  #   unless login_taken
  #     self.login = email[0]
  #   else
  #     self.login = self.email
  #   end
  # end


  # def self.find_for_database_authentication(warden_conditions)
  #   conditions = warden_conditions.dup
  #   if login = conditions.delete(:login)
  #     where(conditions).where(["lower(name) = :value OR lower(email) = :value", { :value => login.downcase }]).first
  #   else
  #     where(conditions).first
  #   end
  # end

  def self.find_first_by_auth_conditions(warden_conditions)
    puts "in user.rb....find_first_by_auth_conditions"
    puts warden_conditions.inspect
    conditions = warden_conditions.dup
    puts conditions[:name]
    if login = conditions.delete(:login)
      puts "HERERERE"
      where(conditions).where(["lower(name) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      if conditions[:name].nil?
        where(conditions).first
      else
        where(name: conditions[:name]).first
      end
    end
  end

  def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :current_password, :remember_me, :login)
  end
end
