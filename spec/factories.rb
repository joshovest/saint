FactoryGirl.define do
  factory :user do
    sequence(:name)		{ |n| "person_#{n}" }
    sequence(:email) 	{ |n| "person_#{n}@example.com"}
    password "foobar"
    password_confirmation "foobar"
    
    factory :admin do
      admin true
    end
    
    factory :non_admin do
      admin false
    end
  end
  
  factory :site do
    sequence(:name)			{ |n| "site#{n}.com" }
    sequence(:suite_list) 	{ |n| "salesforcesite#{n}com,salesforcesite#{n}comdev"}
  end
  
  factory :cloud do
    sequence(:name)			{ |n| "Cloud #{n}" }
  end
  
  factory :brand_match do
    sequence(:match_list)	{ |n| "match#{n},exclude#{n}" }
    sequence(:position)		{ |n| n }
  end
end