10.times do |n|
  name  = Faker::Beer.unique.hop << n.to_s
  about = Faker::Beer.style
  Badge.create!(
  	name:  name,
  	about:  about
  )
end