(function () {

  if (typeof SnakeGame === "undefined") {
    window.SnakeGame = {};
  }

  var Snake = SnakeGame.Snake = function () {
    this.dir = "E";
    this.segments = [[0, 0], [0, 1], [0, 2]];
  };

  function directionCoord(dir) {
    if (dir === "N") {
      return [-1, 0];
    } else if (dir === "E") {
      return [0, 1];
    }  else if (dir === "S") {
      return [1, 0];
    } else if (dir === "W") {
      return [0, -1];
    }
  }

  Snake.prototype.moveSegment = function (segment) {
    var that = this;
    var dir = directionCoord(that.dir);
    return [dir[0] + segment[0], dir[1] + segment[1]];
  }

  Snake.prototype.move = function () {
    var that = this;
    this.segments.push(this.moveSegment(that.segments[that.segments.length - 1]));
  };

})();
