class User < ActiveRecord::Base
  include Conversion

  has_many :accounts

end
