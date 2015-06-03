JournalApp.Views.PostsIndex = Backbone.View.extend({
  template: JST['posts/index'],

  initialize: function () {
    this.listenTo(this.collection, "sync remove reset", this.render);
  },

  render: function () {
    var content = this.template();
    this.$el.html(content);
    this.collection.each( function(post) {
      var newIndexItem = new JournalApp.Views.PostsIndexItem({model: post})
      this.$el.find("ul").append(newIndexItem.render().$el)
    }, this);
    $('body').append(this.$el)
    return this;
  }
});

$(function () {


  var newColl = new JournalApp.Collections.Posts();
  // var postOne = new JournalApp.Models.Post({title: "1", body: "one"});
  // postOne.save();
  // var postTwo = new JournalApp.Models.Post({title: "2", body: "two"});
  // postTwo.save();
  // var postThree = new JournalApp.Models.Post({title: "3", body: "three"});
  // postThree.save();
  // newColl.add([postOne, postTwo, postThree]);
  newColl.fetch({
    success: function () {
      var postsIdx = new JournalApp.Views.PostsIndex({collection: newColl});
      postsIdx.render();
    },
    reset: true
  });
})
