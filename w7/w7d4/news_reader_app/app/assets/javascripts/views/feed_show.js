NewsReader.Views.FeedShow = Backbone.View.extend({
  template: JST['feeds/feed_show'],

  initialize: function (options) {
    this.model = options.model;
    this.listenTo(this.model.entries(), "sync", this.render);
  },

  render: function () {
    console.log('TEST');
    var content = this.template({ feed: this.model });
    this.$el.html(content);

    return this;
  }

});
