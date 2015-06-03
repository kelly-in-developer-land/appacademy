JournalApp.Routers.PostsRouter = Backbone.Router.extend({
  routes: {
    '': 'postsIndex',
    'posts/:id': 'postShow'
  },

  initialize: function ($el) {
    this.$el = $el;
  },

  postsIndex: function () {
    var postIndex = new JournalApp.Views.PostsIndex();
    postIndex.fetch();
    this.swapView(postIndex);
  },

  postShow: function (id) {
    var postModel = new JournalApp.Models.Post({ id: id });
    postModel.fetch();
    var postShow = new JournalApp.Views.PostShow({model: postModel});
    this.swapView(postShow);
  },

  swapView: function (otherView) {
    if (this.view) {
      this.view.remove();
    }
    this.view = otherView;
    this.$el.html(this.view.render().$el);
  }
});

$(function () {
  var route = new JournalApp.Routers.PostsRouter($("body"));
  Backbone.history.start();
});
