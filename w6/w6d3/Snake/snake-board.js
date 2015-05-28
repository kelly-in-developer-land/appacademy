(function() {

  if (typeof SnakeGame === "undefined") {
    window.SnakeGame = {};
  }

  var Board = SnakeGame.Board = function() {
    this.snake = new SnakeGame.Snake();
    this.apples = [];
  };

  Board.prototype.render = function() {
    var lastSegment = this.snake.segments.shift();
    var interpolation = lastSegment[0] + "-" + lastSegment[1]
    $("#" + interpolation).removeClass("marked");
    this.snake.segments.forEach( function(segment) {
      interpolation = segment[0] + "-" + segment[1]
      $("#" + interpolation).addClass("marked");
    });
  };

})();
