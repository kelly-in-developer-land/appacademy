Pokedex.RootView.prototype.createPokemon = function (attrs, callback) {
  var newPoke = new Pokedex.Models.Pokemon;
  var that = this;
  newPoke.save(attrs, {
    success: function () {
      that.pokes.add(newPoke);
      that.addPokemonToList(newPoke);
      callback(newPoke);
    }
  });
};

Pokedex.RootView.prototype.submitPokemonForm = function (event) {
  event.preventDefault();
  var formData = $(event.currentTarget).serializeJSON();
  var that = this;
  this.createPokemon(formData, that.renderPokemonDetail.bind(that));
};
