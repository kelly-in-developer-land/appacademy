json.(pokemon, :id, :name, :attack, :defense, :poke_type, :moves, :image_url)

if display_toys
  json.toys pokemon.toys.each do |toy|
    json.partial!("toys/toy", toy: toy)
  end
end
