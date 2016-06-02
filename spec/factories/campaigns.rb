FactoryGirl.define do
  # we define our factory for the Campaign model in here.
  # remember that this should always succeed in giving a valid campaign
  factory :campaign do
    # using a sequence will guarantee us that we will have a unique number `n`
    # which we can use to generate a unique title
    sequence(:title) {|n| "#{Faker::Company.bs}-#{n}" }
    body             { Faker::Hipster.paragraph       }
    goal             { 11 + rand(100000)              }
    end_date         { Time.now + rand(120).days      }
  end
end
