NewsReader.Routers.Feeds = Backbone.Router.extend({
  initialize: function (options) {
    this.$rootEl = options.$rootEl;
    this.collection = options.collection;
  },

  routes: {
    "": "index"
  },

  index: function () {
    var newFeedsIndex = new NewsReader.Views.FeedsIndex({ collection: this.collection });
    this.$rootEl.html(newFeedsIndex.render().$el);
  }

});
