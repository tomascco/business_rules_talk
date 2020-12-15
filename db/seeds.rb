10.times do
  Product.create(
    price: (1000..5000).to_a.sample,
    name: Faker::Game.title,
    description: Faker::Lorem.sentence(word_count: 30)
  )
end
