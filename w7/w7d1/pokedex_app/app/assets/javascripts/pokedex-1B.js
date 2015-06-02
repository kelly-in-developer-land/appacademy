Pokedex.RootView.prototype.renderPokemonDetail = function (pokemon) {
  var $details = $("<div>").addClass("detail");
  var imgUrl = pokemon.escape("image_url")
  $details.append($("<img>").attr("src", imgUrl));
  for (key in pokemon.attributes) {
    var $li = $("<li>").text(key + ": " + pokemon.attributes[key]);
    $details.append($li);
  }
  var $toysList = $("<ul>").addClass("toys")
  $details.append($toysList);
  var that = this;
  pokemon.fetch({
    success: function () {
      pokemon.toys().each( function(toy) {
        that.addToyToList(toy);
      })
    }
  })
  this.$pokeDetail.append($details);
};

Pokedex.RootView.prototype.selectPokemonFromList = function (event) {
  event.preventDefault();
  var pid = $(event.currentTarget).data("id");
  var pokemon = this.pokes.where({id: pid})[0];
  this.renderPokemonDetail(pokemon);
};
