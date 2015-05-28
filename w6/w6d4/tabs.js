$.Tabs = function (el) {
  this.$el = $(el);
  this.$contentTabs = $(this.$el.attr("data-content-tabs"));
  this.$activeTab = $("#content-tabs .active");
  this.$activeAnchor = $("a#" + this.$activeTab.attr("id"));
  this.clickTab.call(this);
  // this.$el.on("click", "a", this.clickTab(event));
};

$.Tabs.prototype.clickTab = function () {
  this.$el.on("click", "a", function (event) {

  event.preventDefault();
  this.$activeTab.removeClass("active");
  this.$activeAnchor.removeClass("active");
  var tab = $(event.currentTarget).attr("id");
  $("a#" + tab).addClass("active");
  var $newActiveTab = $("div.tab-pane#" + tab);
  $newActiveTab.addClass("active");
  this.$activeTab = $newActiveTab;

}.bind(this));

};

$.fn.tabs = function () {
  return this.each(function () {
    new $.Tabs(this);
  });
};
