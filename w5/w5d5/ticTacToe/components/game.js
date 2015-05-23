// You'll want to require your ttt/board.js file.
// Write the Game constructor such that it takes a reader interface as an argument.
// As in the previous exercise, write a #run(completionCallback) method.

// run method that loops, reading in user moves.
// When the game is over, exit the loop.

var Board = require("./board");

function Game(reader) {
  this.reader = reader;
  this.board = new Board();
}

Game.prototype.promptMove = function(callback) {
  console.log(JSON.stringify(this.board.grid));
  var that = this;
  that.reader.question("Piece: ", function (answer1) {
    reader.question("Row: ", function (answer2) {
      reader.question("Column: ", function (answer3) {
        var piece = answer1;
        var row = parseInt(answer2);
        var col = parseInt(answer3);

        that.board.move(piece, row, col);
        callback();
      });
    });
  });
};

Game.prototype.run = function() {
  var that = this;
  // console.log(this.board.isWon.call(that.board));
  if ( this.board.isWon.call(that.board) === true ) {
    console.log("Game over!");
    reader.close();
  } else {
    this.promptMove(this.run.bind(that));
  }
};

module.exports = Game;
