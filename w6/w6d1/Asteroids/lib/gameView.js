(function () {

if ( window.Asteroids === undefined ) {
  window.Asteroids = {};
}

var GameView = Asteroids.GameView = function GameView(game, ctx, sound) {
  this.game = game;
  this.ctx = ctx;
  this.sound = sound;
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
  var that = this;

  var shoot = function () {
    that.sound.load();
    that.sound.play();
    that.game.ship.fireBullet();
  };
  key('w,up', function () { p([0,-0.4]) } );
  key('a,left', function() { p([-0.4,0]) });
  key('s,down', function() { p([0,0.4]) });
  key('d,right', function() { p([0.4,0]) });
  key('k,space', shoot);
};

})();
