# Events

50.times do
  event = Event.create({
    name: Faker::Name.name,
    description: Faker::Lorem.sentence(4, true, 0),
    start_time: Faker::Date.forward(50),
    duration: 120,
    venue: Faker::Address.country,
    created_at: Faker::Date.backward(50),
    price: rand(100..900),
  })
end 
8.times do
  event = Event.create({
    name: Faker::Name.name,
    description: Faker::Lorem.sentence(4, true, 0),
    start_time: Faker::Date.backward(50),
    duration: 120,
    venue: Faker::Address.country,
    created_at: Faker::Date.backward(100),
    price: rand(100..900),
  })
end 