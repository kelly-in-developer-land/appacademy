$.Tabs = function (el) {
  this.$el = $(el);
  this.$contentTabs = $(this.$el.attr("data-content-tabs"));
  this.$activeTab = $("div.tab-pane.active");
  this.$activeAnchor = $("a#" + this.$activeTab.attr("id")).addClass("active");
  this.$el.on("click", "a", function (event) { this.clickTab(event); }.bind(this));
};

$.Tabs.prototype.clickTab = function (event) {
  event.preventDefault();
  this.$activeTab.removeClass("active");
  this.$activeAnchor.removeClass("active");
  var tab = $(event.currentTarget).attr("id");
  var $newActiveAnchor = $("a#" + tab).addClass("active");
  var $newActiveTab = $("div.tab-pane#" + tab).addClass("active");
  this.$activeTab = $newActiveTab;
  this.$activeAnchor = $newActiveAnchor;
};

$.fn.tabs = function () {
  return this.each(function () {
    new $.Tabs(this);
  });
};
