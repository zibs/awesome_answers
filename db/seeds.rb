# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


100.times do
  q = Question.create title: Faker::Company.bs,
                   body: Faker::Lorem.paragraph,
                   view_count: rand(100)
  10.times do
    a = q.answers.create(body: Faker::Company.catch_phrase)
    5.times { a.comments.create(body: Faker::Company.bs) }
  end
end

["Art", "Science", "Cats", "Sports", "Technology"].each do |cat|
  Category.create(name: cat)
end

["lyric", "conceptual", "confessional", "quotidian", "sestina", "concrete"].each do |tag|
  Tag.create(name: tag)
end
# comments = []
# q.answers.each { |ans| comments << ans.comments }
# all_comments = comments.flatten
# all_comments.length >> 50
