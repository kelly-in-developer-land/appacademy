$.Carousel = function (el) {
  this.$el = el;
  this.activeIdx = 0;
  $("div.items img:first-child").addClass("active");
  this.listen();
};

$.Carousel.prototype.slide = function (dir) {
  $("img.left").removeClass("left");
  $("img.right").removeClass("right");
  var direction = (dir === -1) ? "right" : "left";
  $("img").eq(this.activeIdx).removeClass("active").addClass(direction);
  this.activeIdx += dir;
  if (this.activeIdx <= -1 * $("img").length || this.activeIdx >= $("img").length) {
    this.activeIdx = this.activeIdx % $("img").length;
  }
  var $activeImg = $("img").eq(this.activeIdx);
  $activeImg.addClass("active").addClass("left");
  setTimeout(function () {
    $activeImg.removeClass("left");
  }, 0);
};


$.Carousel.prototype.listen = function () {
  var that = this;
  $(".sliders .prev").on("click", that.slide.bind(that, -1));
  $(".sliders .next").on("click", that.slide.bind(that, 1));
};
