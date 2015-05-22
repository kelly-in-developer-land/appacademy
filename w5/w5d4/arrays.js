Array.prototype.uniq = function() {
  var newArray = [];

  function pushIfUniq(element, index, array) {
    if (newArray.indexOf(element) === -1) {
      newArray.push(element);
    }
  }
  this.forEach(pushIfUniq)

  return newArray
}

// console.log([1, 2, 3, 2, 4, 3, 5].uniq())

Array.prototype.twoSum = function() {
  var newArray = [];
  for(i = 0; i < this.length; i++) {
    for(j = i + 1; j < this.length; j++) {
      if (this[i] + this[j] === 0) {
        newArray.push([i, j]);
      }
    }
  }

  return newArray
}

// console.log([-1, 0, 2, -2, 1].twoSum())

Array.prototype.myTranspose = function() {
  var newArray = new Array(this[0].length);

  for(var i = 0; i < newArray.length; i++) {
    newArray[i] = new Array;
  }

  for(var x = 0; x < this.length; x++) {
    for(var y = 0; y < this[x].length; y++) {
      newArray[y][x] = this[x][y]
      // newArray.push(this[y][x])
    }
  }

  return newArray
}

console.log([
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8]
  ].myTranspose())
