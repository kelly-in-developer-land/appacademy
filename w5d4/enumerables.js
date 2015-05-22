Array.prototype.myEach = function(doSomething) {
  for (var i = 0; i < this.length; i++){
    doSomething(this[i], i, this);
  }
}

Array.prototype.myMap = function(doSomething) {
  var newArray = [];
  function map(element, index, array) {
    newArray.push(doSomething(element));
  }
  this.myEach(map);
  return newArray;
}

Array.prototype.myInject = function(doSomething) {
  var accumulator = this[0];
  function inject(element, index, array) {
    accumulator = doSomething(accumulator, element);
  }
  this.myEach(inject);
  return accumulator;
}


  function injectBlock(sum, num) {
    return sum + num;
}

console.log([1, 2, 3].myInject(injectBlock))
