NewsReader.Views.CompositeView = Backbone.CompositeView.extend({
  template: JST["composite"],

  initialize: function () {
    this.collection.each(this.addFeedItemView.bind(this));
    this.listenTo(this.collection, 'add', this.addFeedItemView);
  },

  events: {
    "click a": "addFeedShowView"
  },

  addFeedItemView: function(feed) {
    var subview = new NewsReader.Views.FeedItem({model: feed});
    this.addSubview('.feedIndex', subview);
  },

  addFeedShowView: function(event) {
    $('.feedShow').empty();
    var id = $(event.currentTarget).data("id");
    var feed = this.collection.getOrFetch(id);
    var subview = new NewsReader.Views.FeedShow({model: feed});
    this.addSubview('.feedShow', subview);
  },

  render: function () {
    var content = this.template();
    this.$el.html(content);
    this.attachSubviews();

    return this;
  }
});
