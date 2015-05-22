// "use strict";

function Clock () {
}

Clock.TICK = 5000;

Clock.prototype.printTime = function () {
  // Format the time in HH:MM:SS
  var time = this.currentTime.getHours() + ":" + this.currentTime.getMinutes() + ":" + this.currentTime.getSeconds();
  console.log(time);
};

Clock.prototype.run = function () {
  // 1. Set the currentTime.
  this.currentTime = new Date();
  // 2. Call printTime.
  this.printTime();
  // 3. Schedule the tick interval.
  var that = this;
  setInterval(this._tick.bind(that), Clock.TICK);
};

Clock.prototype._tick = function () {
  // 1. Increment the currentTime.
  // console.log(this)
  // console.log(this.currentTime.setSeconds(this.currentTime.seconds + 5))
  this.currentTime.setSeconds(this.currentTime.getSeconds() + 5);
  // 2. Call printTime.
  this.printTime();
};

// var clock = new Clock();
// clock.run();


var readline = require("readline");

reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

function addNumbers(sum, numsLeft, completionCallback) {
  if ( numsLeft > 0 ) {
    reader.question("Pick a number: ", function (answer) {
      a = parseInt(answer);
      sum += a;
      numsLeft -= a;
      completionCallback(sum);
      addNumbers(sum, numsLeft, completionCallback);
    });
  } else {
    reader.close();
  }
}

// addNumbers(0, 3, function (sum) {
//   console.log("Total Sum: " + sum);
// });


function askIfGreaterThan (el1, el2, callback) {
  // Prompt user to tell us whether el1 > el2; pass true back to the
  // callback if true; else false.
  q = "Is " + el1.toString() + " greater than " + el2.toString() + "? ";
  reader.question (q, function (answer) {
    if ( answer === "y" ) {
      callback(true);
    } else if ( answer === "n" ) {
      callback(false);
    } else {
      throw "Invalid response.";
    }
  });
}

function innerBubbleSortLoop (arr, i, madeAnySwaps, outerBubbleSortLoop) {
  // Do an "async loop":
  // 1. If (i == arr.length - 1), call outerBubbleSortLoop, letting it
  //    know whether any swap was made.
  // 2. Else, use `askIfGreaterThan` to compare `arr[i]` and `arr[i +
  //    1]`. Swap if necessary. Call `innerBubbleSortLoop` again to
  //    continue the inner loop. You'll want to increment i for the
  //    next call, and possibly switch madeAnySwaps if you did swap.

  if ( i == arr.length - 1 ) {
    outerBubbleSortLoop (madeAnySwaps);
  } else if ( i < arr.length - 1 ) {
    askIfGreaterThan ( arr[i], arr[i+1], function (isGreaterThan) {
      if ( isGreaterThan === true ) {
        l = arr[i];
        s = arr[i+1];
        arr[i] = s;
        arr[i+1] = l;
        madeAnySwaps = true;
      } else {
        madeAnySwaps = false;
      }
      innerBubbleSortLoop (arr, i+1, madeAnySwaps, outerBubbleSortLoop);
    });
  }
}

function absurdBubbleSort (arr, sortCompletionCallback) {
  function outerBubbleSortLoop (madeAnySwaps) {
    // Begin an inner loop if `madeAnySwaps` is true, else call
    // `sortCompletionCallback`.
    if ( madeAnySwaps === true ) {
      innerBubbleSortLoop (arr, 0, false, outerBubbleSortLoop);
    } else {
      sortCompletionCallback(arr);
    }
  }

  // Kick the first outer loop off, starting `madeAnySwaps` as true.
  outerBubbleSortLoop (true);
}

absurdBubbleSort([3, 2, 1], function (arr) {
  console.log("Sorted array: " + JSON.stringify(arr));
  reader.close();
});





// End.
