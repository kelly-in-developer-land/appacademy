function Cat(name, guardian) {
  this.name = name;
  this.guardian = guardian;
}

Cat.prototype.cuteStatement = function() {
  return this.guardian + " loves " + this.name + "!";
}

var snow = new Cat("Snow", "Kelly")
// console.log(snow.cuteStatement())

Cat.prototype.cuteStatement = function() {
  return "Everyone loves " + this.name + "!"
}

var allie = new Cat("Allie", "Kelly")
// console.log(snow.cuteStatement())
// console.log(allie.cuteStatement())

Cat.prototype.meow = function() {
  return "Meow!"
}

// console.log(snow.meow())
// console.log(allie.meow())

allie.meow = function() {
  return "MEOW"
}

console.log(snow.meow())
console.log(allie.meow())
