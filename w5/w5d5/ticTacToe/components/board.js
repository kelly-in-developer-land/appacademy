function Board() {
  this.grid = [new Array(3), new Array(3), new Array(3)];
  this.rows = this.grid;
  this.cols = this.grid.myTranspose();
  // this.diags =
}

Array.prototype.myTranspose = function() {
  var newArray = new Array(this[0].length);
  for(var i = 0; i < newArray.length; i++) {
    newArray[i] = [];
  }
  for(var x = 0; x < this.length; x++) {
    for(var y = 0; y < this[x].length; y++) {
      newArray[y][x] = this[x][y];
    }
  }

  return newArray;
};


Board.prototype.move = function(piece, row, col) {
  if ( this.grid[row][col] === undefined ) {
    this.grid[row][col] = piece;
    return true;
  } else {
    return false;
  }
};

Board.prototype.triple = function(piece) {
  var triple = JSON.stringify([piece,piece,piece]);
  console.log(triple);
  function stringify(element, index, array) {
    return JSON.stringify(element);
  }
  var rows = this.rows.map(stringify);
  console.log(rows);
  console.log(rows.indexOf(triple));

  if ( rows.indexOf(triple) !== -1 ) {
    return true;
  } else if (this.cols.indexOf(triple) !== -1 ) {
    return true;
  // } else if (this.diags.indexOf([piece,piece,piece]) !== -1 ) {
  //   return true;
  } else {
    return false;
  }
};

Board.prototype.isWon = function() {
  var that = this;
  if ( that.triple("x") === true || that.triple("o") === true) {
    return true;
  } else {
    return false;
  }
};

Board.prototype.winner = function(piece) {
  var that = this;
  if ( that.triple("x")) {
    return "x wins!";
  } else if ( that.triple("o")) {
    return "o wins!";
  } else {
    return "No winner!";
  }
};


module.exports = Board;
