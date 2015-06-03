Pokedex.Router = Backbone.Router.extend({
  routes: {
    "": "pokemonIndex",
    "pokemon/:id": "pokemonDetail"
    "pokemon/:pokemonId/toys/:toyId": "toyDetail"
  },

  pokemonDetail: function (id, callback) {
    if (!this._pokemonIndex) {
      this.pokemonIndex(function() {
        this.pokemonDetail(id, callback);
      }.bind(this));
    } else {
      var pokemon = this._pokemon.findWhere({id: parseInt(id)});
      new Pokedex.Views.PokemonDetail({model: pokemon, el: $(".pokemon-detail")});
    }
  },

  pokemonIndex: function (callback) {
    this._pokemonIndex = new Pokedex.Views.PokemonIndex({collection: this._pokemon});
    this._pokemonIndex.refreshPokemon({callback: callback});
    $("#pokedex .pokemon-list").html(this._pokemonIndex.$el);
  },

  toyDetail: function (options) {
    if (!this._pokemonDetail) {
      this.pokemonDetail(function() {
        this.pokemonDetail(id, callback);
      }.bind(this));
    } else {
      var pokemon = this._pokemon.findWhere({id: parseInt(id)});
      new Pokedex.Views.PokemonDetail({model: pokemon, el: $(".pokemon-detail")});
    }
  },

  pokemonForm: function () {
  }
});


$(function () {
  var router = new Pokedex.Router();
  router._pokemon = new Pokedex.Collections.Pokemon();
  Backbone.history.start();
});
