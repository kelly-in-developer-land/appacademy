$.Tabs = function (el) {
  this.$el = $(el);
  this.$contentTabs = $(this.$el.attr("data-content-tabs"));
  this.$activeTab = $("div.tab-pane.active");
  this.$activeAnchor = $("a#" + this.$activeTab.attr("id")).addClass("active");
  this.$el.on("click", "a", function (event) { this.clickTab(event); }.bind(this));
};

$.Tabs.prototype.clickTab = function (event) {
  event.preventDefault();
  this.$activeTab.removeClass("active").addClass("transitioning");
  this.$activeAnchor.removeClass("active");
  var tab = $(event.currentTarget).attr("for");
  var $newActiveAnchor = $("a" + tab).addClass("active");
  this.$activeAnchor = $newActiveAnchor;

  var that = this;
  that.$activeTab.one("transitionend", function (event) {
    that.$activeTab.removeClass("transitioning");
    that.$activeTab = $("div.tab-pane" + tab).addClass("active").addClass("transitioning");
    setTimeout( function () {
      that.$activeTab.removeClass("transitioning");
    }, 0);
  });
};

$.fn.tabs = function () {
  return this.each(function () {
    new $.Tabs(this);
  });
};
