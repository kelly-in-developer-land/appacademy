JournalApp.Views.PostShow = Backbone.View.extend({
  template: JST['posts/show'],

  initialize: function(options) {
    this.model = options.model;
    this.listenTo(this.model, "sync", this.render);
  },

  render: function () {
    var content = this.template({post: this.model});
    this.$el.html(content);

    return this;
  },
})
