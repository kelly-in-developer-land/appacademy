$.Carousel = function (el) {
  this.$el = el;
  this.activeIdx = 0;
  $("div.items img:first-child").addClass("active");
  this.listen();
};

$.Carousel.prototype.slide = function (event, dir) {
  event.preventDefault();
  // $("img.left").removeClass("left");
  // $("img.right").removeClass("right");
  var direction = (dir === 1) ? "right" : "left";
  var oppDirection = (dir === 1) ? "left" : "right";

  var $oldActiveImg = $("img").eq(this.activeIdx).addClass(direction);

  this.activeIdx += dir;
  if (this.activeIdx <= -1 * $("img").length || this.activeIdx >= $("img").length) {
    this.activeIdx = this.activeIdx % $("img").length;
  }

  var $activeImg = $("img").eq(this.activeIdx).addClass("active").addClass(direction);

  $oldActiveImg.one("transitioned", function (event) {
    $oldActiveImg.removeClass("active").removeClass(direction);
    setTimeout(function () {
      $activeImg.removeClass(direction);
    }, 0);
  });
};


$.Carousel.prototype.listen = function () {
  var that = this;
  $(".sliders .prev").on("click", function (event) {
    that.slide.call(that, event, -1);
  });
  $(".sliders .next").on("click", function (event) {
    that.slide.call(that, event, 1);
  });
};
