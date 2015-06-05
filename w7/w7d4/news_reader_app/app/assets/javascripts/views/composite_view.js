NewsReader.Views.CompositeView = Backbone.CompositeView.extend({
  template: JST["composite"],

  initialize: function () {
    this.collection.each(this.addFeedItemView.bind(this));
    this.listenTo(this.collection, 'add', this.addFeedItemView);
    // this.subviews().each(function(sub) {
    //   sub.listenTo(sub.model.entries(), "sync", sub.render);
    // })
  },

  events: {
    "click a": "addFeedShowView"
  },

  addFeedItemView: function(feed) {
    var subview = new NewsReader.Views.FeedItem({model: feed});
    this.addSubview('.feedIndex', subview);
  },

  addFeedShowView: function(event) {
    // if (this.subviews('.feedShow').includes(subview)) {
    //   console.log("remooooving");
    //   this.removeSubview('.feedShow', subview);
    // }
    $('.feedShow').empty();
    var id = $(event.currentTarget).data("id");
    var feed = this.collection.getOrFetch(id);
    var subview = new NewsReader.Views.FeedShow({ model: feed });
    this.addSubview('.feedShow', subview);
    //
    // var that = this;
    // setInterval(function(){
    //   feed.fetch({
    //     success: function() {
    //       that.removeSubview('.feedShow', subview);
    //       subview = new NewsReader.Views.FeedShow({ model: feed });
    //       that.addSubview('.feedShow', subview);
    //       that.render();
    //       // console.log("here")
    //       // that.addFeedShowView(event);
    //     }
    //   });
    // }, 1000);
  },

  render: function () {
    var content = this.template();
    this.$el.html(content);
    this.attachSubviews();

    return this;
  }
});
