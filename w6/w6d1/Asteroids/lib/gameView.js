(function () {

if ( window.Asteroids === undefined ) {
  window.Asteroids = {};
}

var GameView = Asteroids.GameView = function GameView(game, ctx) {
  this.game = game;
  this.ctx = ctx;
};

GameView.prototype.start = function start() {
  var that = this;
  this.bindKeyHandlers();
  setInterval( function () {
      that.game.step(that.ctx);
    }, 16);
};

GameView.prototype.bindKeyHandlers = function bindKeyHandlers() {
  var p = this.game.ship.power.bind(this.game.ship)
  var that = this.game.ship
  key('w', function () { p([0,-1]) } );
  key('a', function() { p([-1,0]) });
  key('s', function() { p([0,1]) });
  key('d', function() { p([1,0]) });
  key('e', that.fireBullet.bind(that));
};

})();
