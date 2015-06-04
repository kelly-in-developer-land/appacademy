NewsReader.Routers.Feeds = Backbone.Router.extend({
  initialize: function (options) {
    this.$rootEl = options.$rootEl;
    this.collection = options.collection;
  },

  routes: {
    "": "index",
    "feeds/:id": "feedShow"
  },

  index: function () {
    var newFeedsIndex = new NewsReader.Views.FeedsIndex({ collection: this.collection });
    this.$rootEl.html(newFeedsIndex.render().$el);
  },

  feedShow: function(id) {
    var feed = this.collection.get(id);
    feed.entries().fetch();
    var newFeedShow = new NewsReader.Views.FeedShow({ model: feed });
    this.$rootEl.html(newFeedShow.render().$el);
  }

});
