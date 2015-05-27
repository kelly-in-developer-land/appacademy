(function () {
  if (typeof TTT === "undefined") {
    window.TTT = {};
  }

  function mapSquare (id) {
    var result = []
    if (id <= 2) {
      result.push(0);
    } else if (id >= 3 && id <= 5) {
      result.push(1);
    } else {
      result.push(2);
    }
    result.push(id % 3)

    return result;
  }

  var View = TTT.View = function (game, $el) {
    this.game = game;
    this.grid = $el;
    this.setupBoard();
    this.bindEvents();
  };

  View.prototype.bindEvents = function () {
    var that = this;
    $(".square").on("click", function (event) {
      var id = $(event.currentTarget).attr("id");
      var pos = mapSquare(id);
      that.game.playMove(pos);
      $(event.currentTarget).text(that.game.currentPlayer)
        .addClass("marked");
      if (game.isOver()) {
        alert("Game Over!");
      }
    });
  };

  View.prototype.makeMove = function ($square) {
  };

  View.prototype.setupBoard = function () {
    var j = 0;
    for(var i = 0; i < 3; i++) {
      var $row = $("<div>").addClass("row").addClass("group");
      this.grid.append($row);
      var l = j;
      for(j; j < l + 3; j++) {
        $row.append($("<div>").addClass("square").attr("id", i + j));
      }
      j = j - 1;
    }
  };
})();
