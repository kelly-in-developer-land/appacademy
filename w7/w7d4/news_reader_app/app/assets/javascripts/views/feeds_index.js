NewsReader.Views.FeedsIndex = Backbone.View.extend({
  template: JST['feeds/feeds_index'],

  initialize: function(options) {
    this.listenTo(NewsReader.feeds, "sync", this.render);
    this.collection = options.collection
  },

  render: function () {
    var content = this.template({ feeds: this.collection });
    this.$el.html(content);

    // NewsReader.feeds.each(function (feed) {
    //   var newFeedIndexItem = NewsReader.Views.FeedsIndexItem( { model: feed });
    //
    // });

    return this;
  }
});
