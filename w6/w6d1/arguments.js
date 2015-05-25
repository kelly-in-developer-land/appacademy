function sum() {
  var args = Array.prototype.slice.apply(arguments);
  var result = 0;
  args.forEach( function(arg) {
    result += arg;
  });
  return result;
}

Function.prototype.myBind = function(context) {
  var that = this;
  var bindArgs = Array.prototype.slice.call(arguments, 1);
  return function () {
    var callArgs = Array.prototype.slice.call(arguments);
    return that.apply(context, bindArgs.concat(callArgs));
  };
};


function curriedSum(numArgs) {
  var numbers = [];
  return function _curriedSum (n) {
    numbers.push(n);
    if ( numbers.length === numArgs ) {
      var result = 0;
      numbers.forEach( function(num) {
        result += num;
      });
      return result;
    } else {
      return _curriedSum;
    }
  };
}

Function.prototype.curry = function curry(numArgs) {
  var totalArgs = [];
  var that = this;
  return function _curried () {
    for (var i = 0; i < arguments.length; i++) {
      totalArgs.push(arguments[i]);
    }

    if ( totalArgs.length >= numArgs ) {
      return that.apply(null, totalArgs);
    } else {
      return _curried;
    }
  };
};
