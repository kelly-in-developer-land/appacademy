Array.prototype.bubbleSort = function() {
  for(var j = 0; j < this.length; j++) {
    for(var i = 0; i < this.length; i++) {
      if (this[i] > this[i+1]) {
        first = this[i]
        second = this[i+1]
        this[i] = second
        this[i+1] = first
      }
    }
  }
  return this
}

// console.log([3,4,2,5,1].bubbleSort())


String.prototype.substrings = function() {
  subs = [];

  for(i = 0; i < this.length; i++) {
    for(j = i + 1; j <= this.length; j++) {
      if (subs.indexOf(this.substring(i, j)) === -1) {
        subs.push(this.substring(i, j));
      }
    }
  }

  return subs;
}

console.log('Caat'.substrings())
