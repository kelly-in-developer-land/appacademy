Pokedex.Views = {}

Pokedex.Views.PokemonIndex = Backbone.View.extend({
  events: {
    "click li": "selectPokemonFromList"
  },

  initialize: function (options) {
    this.listenTo(this.collection, "sync add", this.render());
  },

  addPokemonToList: function (pokemon) {
    this.$el.append(JST["pokemonListItem"]({ pokemon: pokemon }));
  },

  refreshPokemon: function (options) {
    this.collection.fetch({
      success: (function () {
        this.$el.empty();
        this.collection.each(this.addPokemonToList.bind(this));
        options.callback();
      }).bind(this)
    });

    return this.pokes;
  },

  render: function () {
    this.$el.find(".pokemon-list").empty();
    this.collection.each(function(pokemon) {
      this.addPokemonToList.call(this, pokemon);
    });
  },

  selectPokemonFromList: function (event) {
    this.$el.find('.toy-detail').empty();
    var $target = $(event.currentTarget);

    var pokeId = $target.data('id');
    var pokemon = this.collection.get(pokeId);

    Backbone.history.navigate("pokemon/" + pokeId, {id: pokeId, trigger: true});
    // var pokeDetail = new Pokedex.Views.PokemonDetail({ model: pokemon });
    // $("#pokedex .pokemon-detail").html(pokeDetail.$el);
    // pokeDetail.refreshPokemon();
  }
});

Pokedex.Views.PokemonDetail = Backbone.View.extend({
  initialize: function(options) {
    this.pokemon = options.model;
    this.render.call(this);
  },

  events: {
    "click .toys li": "selectToyFromList"
  },

  refreshPokemon: function (options) {
    this.pokemon.fetch({
      success: function() {
        this.render.bind(this);
        options.callback();
      }
    });
  },

  render: function () {
    this.$el.html(JST["pokemonDetail"]({ pokemon: this.pokemon }));
    this.pokemon.toys().each(function(toy) {
      this.$el.append( $("<ul>").addClass("toys") );
      this.$el.find(".toys").append(JST["toyListItem"]({ toy: toy }));
    }.bind(this));

  },

  selectToyFromList: function (event) {

    var targetToyId = $(event.currentTarget).data("id");
    var toy = this.pokemon.toys().findWhere({id: targetToyId});
    var pokeId = toy.escape("pokemon_id");
    Backbone.history.navigate("pokemon/" + pokeId + "/toys/" + toy.id,
            {id: toy.id, pokemonId: pokeId, trigger: true});
    // var toyDetail = new Pokedex.Views.ToyDetail({ model: toy});
    // $("#pokedex .toy-detail").append(toyDetail.$el);
    // toyDetail.render();
  }
});

Pokedex.Views.ToyDetail = Backbone.View.extend({
  initialize: function(options) {
    this.toy = options.model;
  },
  render: function () {
    this.$el.html(JST["toyDetail"]({ toy: this.toy, pokes: [] }));
  }
});

// $(function () {
//   var pokeCollection = new Pokedex.Collections.Pokemon();
//   var pokemonIndex = new Pokedex.Views.PokemonIndex({ collection: pokeCollection });
//   pokemonIndex.refreshPokemon();
//   $("#pokedex .pokemon-list").html(pokemonIndex.$el);
// });
