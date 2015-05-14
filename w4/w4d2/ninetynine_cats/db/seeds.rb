# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Cat.destroy_all

Cat.create!(birth_date: Time.new('2010-03-31'), color: :orange, name: 'Reginald', sex: 'M')
Cat.create!(birth_date: Time.new('2010-03-31'), color: :orange, name: 'Reg', sex: 'M')
Cat.create!(birth_date: Time.new('2010-03-31'), color: :orange, name: 'Reggie', sex: 'M')
Cat.create!(birth_date: Time.new('2010-03-31'), color: :orange, name: 'Regex', sex: 'M')
Cat.create!(birth_date: Time.new('2010-03-31'), color: :orange, name: 'Regina', sex: 'F')

(10..19).each do |num|
  Cat.create!(birth_date: Time.new("2010-03-#{num}"), color: :orange, name: "Reg#{num}", sex: 'M', description: "This is Reg#{num}'s life story!")
end


200.times do
  id = (1..15).to_a.sample
  CatRentalRequest.create!(cat_id: id, start_date: '20150501', end_date: '20150510')
end

CatRentalRequest.create!(cat_id: 5, start_date: '20150501', end_date: '20150510')

CatRentalRequest.create!(cat_id: 5, start_date: '20150501', end_date: '20150505')
