NewsReader.Views.FeedItem = Backbone.View.extend({
  template: JST['feeds/feed_item'],

  initialize: function (options) {
    this.model = options.model;
    this.listenTo(this.model.entries(), "sync", this.render);
  },

  render: function () {
    var content = this.template({ feed: this.model });
    this.$el.html(content);

    return this;
  }

});
