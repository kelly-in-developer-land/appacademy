Pokedex.RootView.prototype.addPokemonToList = function (pokemon) {
  var $li = $("<li>").text(pokemon.attributes.name+ ": " + pokemon.attributes.poke_type);
  $li.addClass("poke-list-item");
  this.$pokeList.append($li);
};

Pokedex.RootView.prototype.refreshPokemon = function () {
  var jolteon = new Pokedex.Models.Pokemon({ id: 1 });
  this.pokes.add(jolteon)
  var pokemon = this.pokes.fetch({
    success: function (pokemon) {
      pokemon.each(this.addPokemonToList.bind(this));
    }.bind(this)
  });
};
