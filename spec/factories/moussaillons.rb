FactoryGirl.define do
  factory :moussaillon do
    username 'MyUsername'
    email 'example@example.com'
    password 'password'
    sign_up_code 'GOSSIP_2018'

    factory :moussaillon_wrong_code do
    	sign_up_code 'BLABLABLA'
    end
  end
end
