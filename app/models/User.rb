require 'bcrypt'

class User < ActiveRecord::Base

  # users.password_hash in the database is a :string
  include BCrypt

  validates :email, {
                      :uniqueness => {:case_sensitive => false},
                      :format => {:with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i}
                  }
  validates :password, :presence => true, length: {minimum: 6}, confirmation: true

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end

end