FactoryGirl.define do
  factory :question do
    # add association
    title { Faker::Shakespeare.romeo_and_juliet_quote }
    body { Faker::Shakespeare.hamlet_quote }
  end

end
