Function.prototype.inherits = function (parent) {
  function Surrogate() {}
  Surrogate.prototype = parent.prototype;
  this.prototype = new Surrogate();
};

function Animal (name) {
  this.name = name;
}

Animal.prototype.sayHello = function () {
  console.log("Hello, my name is " + this.name);
};

function Dog (name) {
  Animal.call(this, name);
}

Dog.inherits(Animal);

var d = new Dog("Fido");
d.sayHello();

Dog.prototype.bark = function () {
  console.log("Bark!");
};

d.bark();
var a = new Animal("gizmo");
a.bark();
