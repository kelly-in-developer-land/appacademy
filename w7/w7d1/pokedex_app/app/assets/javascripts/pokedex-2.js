Pokedex.RootView.prototype.addToyToList = function (toy) {
  var $li = $("<li>").text("Name: " + toy.escape("name") +
    ", Happiness: " + toy.escape("happiness") +
    ", Price: " + toy.escape("price")
  );
  $li.data("id", toy.id)
  $li.data("pokemon-id", toy.escape('pokemon_id'));
  this.$pokeDetail.find("ul.toys").append($li);
};

Pokedex.RootView.prototype.renderToyDetail = function (toy) {
  var $div = $("<div>").addClass("detail");
  for (key in toy.attributes) {
    var $li = $("<li>").text(key + ": " + toy.attributes[key]);
    $div.append($li);
  }
  this.$toyDetail.append($div);
};

Pokedex.RootView.prototype.selectToyFromList = function (event) {
  event.preventDefault();
  var tid = $(event.currentTarget).data("id");

  var pid = $(event.currentTarget).data('pokemon-id');

  var pokemon = this.pokes.get(pid);
  var toy = pokemon.toys().get(tid);
  this.renderToyDetail(toy);
};
