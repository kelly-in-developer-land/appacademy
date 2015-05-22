function HanoiGame() {
  this.stacks = [ [3,2,1], [], [] ];
}

HanoiGame.prototype.isWon = function() {
  stacks = JSON.stringify(this.stacks);
  if (stacks === "[[],[3,2,1],[]]" || stacks === "[[],[],[3,2,1]]") {
    return true;
  } else {
    return false;
  }
};

HanoiGame.prototype.isValidMove = function(startTowerIdx, endTowerIdx) {
  // console.log("start: " + startTowerIdx);
  if (this.stacks[endTowerIdx][this.stacks[endTowerIdx].length-1] === undefined || this.stacks[startTowerIdx][this.stacks[startTowerIdx].length-1] < this.stacks[endTowerIdx][0]) {
    return true;
  } else {
    return false;
  }
};

HanoiGame.prototype.move = function(startTowerIdx, endTowerIdx) {
  var that = this;
  if ( this.isValidMove(startTowerIdx, endTowerIdx) === true ) {
    var lastIdx = this.stacks[startTowerIdx].length-1;
    var last = this.stacks[startTowerIdx][lastIdx];
    this.stacks[endTowerIdx].push(last);
    this.stacks[startTowerIdx].splice(lastIdx, 1);
    return true;
  } else {
    return false;
  }
};

HanoiGame.prototype.print = function() {
  console.log(JSON.stringify(this.stacks));
};

var readline = require("readline");

reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

HanoiGame.prototype.promptMove = function(callback) {
  this.print();
  var start = null;
  var end = null;
  var that = this;
  reader.question("Start tower: ", function (answer1) {
    reader.question("End tower: ", function (answer2) {
      var start = parseInt(answer1);
      var end = parseInt(answer2);

      that.move(start, end);
      callback();
    });
  });
};

HanoiGame.prototype.run = function() {
  var that = this;
  if ( this.isWon.call(that) === true ) {
    console.log("You won!");
    reader.close();
  } else {
    this.promptMove(this.run.bind(that));
  }
};

var game = new HanoiGame();

game.run();
