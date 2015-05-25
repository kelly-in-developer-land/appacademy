(function () {

if ( window.Asteroids === undefined ) {
  window.Asteroids = {};
}


var Asteroid = Asteroids.Asteroid = function Asteroid(options) {
  options['color'] = Asteroid.COLOR;
  options['radius'] = Asteroid.RADIUS;
  options['vel'] = Asteroids.Util.randomVec(Asteroid.SPEED);
  Asteroids.MovingObject.call(this, options);
};

Asteroids.Util.inherits(Asteroid, Asteroids.MovingObject);

Asteroid.COLOR = '#808080';
Asteroid.RADIUS = 30;
Asteroid.SPEED = 5;

})();
