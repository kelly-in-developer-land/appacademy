var Components = require("./components");
var readline = require("readline");

reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

var game = new Components.Game(reader);

game.run();
