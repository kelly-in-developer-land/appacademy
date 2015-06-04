JournalApp.Views.PostsIndex = Backbone.View.extend({
  template: JST['posts/index'],

  initialize: function () {
    this.collection = new JournalApp.Collections.Posts();
    this.collection.fetch();
    this.listenTo(this.collection, "sync remove reset", this.render);
  },

  render: function () {
    var content = this.template();
    this.$el.html(content);
    this.collection.each( function (post) {
      var newIndexItem = new JournalApp.Views.PostsIndexItem({model: post})
      this.$el.find("ul").append(newIndexItem.render().$el)
    }, this);
    $('body').append(this.$el)
    return this;
  }
});
