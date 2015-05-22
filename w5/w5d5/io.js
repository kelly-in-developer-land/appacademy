"use strict";

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

var clock = new Clock();
clock.run();



// window.reader = readline.createInterface
















// End.
