JournalApp.Routers.PostsRouter = Backbone.Router.extend({
  routes: {
    '': 'postsIndex',
    'posts/new': 'postNew',
    'posts/:id': 'postShow',
    'posts/:id/edit': 'postEdit'
  },

  initialize: function ($el) {
    this.$el = $el;
  },

  postNew: function () {
    debugger
    var postModel = new JournalApp.Models.Post();
    var postsColl = new JournalApp.Collections.Posts()
    var newForm = new JournalApp.Views.PostsForm({model: postModel,
       collection: postsColl});
    this.swapView(newForm);
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

  postEdit: function (id) {
    var postModel = new JournalApp.Models.Post({ id: id });
    var postsColl = new JournalApp.Collections.Posts()
    postsColl.add(postModel);
    postsColl.getOrFetch(postModel);
    var postForm = new JournalApp.Views.PostsForm({model: postModel});
    this.swapView(postForm);
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
