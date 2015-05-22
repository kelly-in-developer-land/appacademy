Function.prototype.myBind = function (context) {
  var that = this;
  return function () {
    return that.apply(context);
  };
};

// Capture this (which is the function to bind) in a variable named fn.
// Define and return an anonymous function.
// The anonymous function captures fn and context.
// In the anonymous function, call Function#apply on fn, passing the context.
