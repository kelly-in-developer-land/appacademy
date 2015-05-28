// things we could do:
// add apples and augment snake length when apple hit;
// make it fail if you hit yourself;
// keep score;
// pause and restart game;
// either fail or redirect on wall hit;
// leaderboard;

(function() {

  if (typeof SnakeGame === "undefined") {
    window.SnakeGame = {};
  }

  var View = SnakeGame.View = function(board, grid) {
    this.board = board;
    this.snake = this.board.snake;
    this.grid = grid;
    this.buildBoard();
    this.bindEvents();
    this.step();
    this.board.addApple();
  };

  GRID = 20

  View.prototype.buildBoard = function() {
    for (var i = 0; i < GRID; i++) {
      var $row = $("<div>").addClass("row").addClass("group");
      this.grid.append($row);
      for (var j = 0; j < GRID; j++) {
        var position = i + "-" + j;
        $row.append($("<div>").addClass("square").attr("id", position));
      }
    }
  };

  View.prototype.bindEvents = function() {
    var that = this;
    $(window).keydown(function(event) {
      switch (event.which) {
        case 40:
          that.snake.dir = "S";
          break;
        case 39:
          that.snake.dir = "E";
          break;
        case 38:
          that.snake.dir = "N";
          break;
        case 37:
          that.snake.dir = "W";
          break;
      }
    });
  };

  View.prototype.step = function() {
    var that = this;
    setInterval(function() {
      that.snake.move();
      var grid = that.grid;
      that.board.render();
    }, 100);
  };
})();
