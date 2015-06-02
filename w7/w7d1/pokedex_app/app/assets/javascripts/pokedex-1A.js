Pokedex.RootView.prototype.addPokemonToList = function (pokemon) {
  var $li = $("<li>").text(pokemon.escape("name")+ ": " + pokemon.escape("poke_type"));
  var pid = pokemon.id
  $li.addClass("poke-list-item").data("id", pid);
  this.$pokeList.append($li);
};

Pokedex.RootView.prototype.refreshPokemon = function () {
  var pokemon = this.pokes.fetch({
    success: function (pokemon) {
      pokemon.each(this.addPokemonToList.bind(this));
    }.bind(this)
  });
};
