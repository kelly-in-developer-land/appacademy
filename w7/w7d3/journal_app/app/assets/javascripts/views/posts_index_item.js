JournalApp.Views.PostsIndexItem = Backbone.View.extend({
  template: JST['posts/posts_index_item'],

  initialize: function(options) {
    this.model = options.model;
  },

  events: {
    "click button.delete": "destroy"
  },

  tagName: 'li',

  render: function () {
    var content = this.template({post: this.model});
    this.$el.html(content);

    return this;
  },

  destroy: function (event) {
    this.model.destroy();
    this.remove();
  }
});
