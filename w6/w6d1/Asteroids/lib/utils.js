(function () {

if ( window.Asteroids === undefined ) {
  window.Asteroids = {};
}

var Util = Asteroids.Util = function Util() {
};

Util.inherits = function inherits(ChildClass, ParentClass) {
  function Surrogate() {}
  Surrogate.prototype = ParentClass.prototype;
  ChildClass.prototype = new Surrogate();
};

Util.randomVec = function randomVec(length) {
  var x = Math.floor(Math.random() * length - length/2);
  var y = Math.floor(Math.random() * length - length/2);
  return [x,y];
};

Util.distance = function distance(pos1, pos2) {
  return Math.sqrt( Math.pow((pos1[0] - pos2[0]), 2) +
                      Math.pow((pos1[1] - pos2[1]), 2)
              );
};

})();
