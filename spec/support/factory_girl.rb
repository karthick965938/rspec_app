# RSpec
# spec/support/factory_girl.rb
RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
end

# RSpec without Rails
RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods

  config.before(:suite) do
    FactoryGirl.find_definitions
  end
end

FactoryGirl.define do
  factory :user do
	  name                   "karthick"
	  email                  "karthick@yopmail.com"
	  password               "karthick@yopmail.com"
	  password_confirmation  "karthick@yopmail.com"
  end
end