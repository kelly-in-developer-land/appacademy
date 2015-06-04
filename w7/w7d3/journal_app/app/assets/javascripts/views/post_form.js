JournalApp.Views.PostsForm = Backbone.View.extend({
  template: JST['posts/post_form'],

  events: {
    'submit form': 'submitForm'
  },

  initialize: function(options) {
    this.model = options.model;
    this.listenTo(this.model, "sync", this.render);
  },

  render: function () {
    var content = this.template({post: this.model});
    this.$el.html(content);

    return this;
  },

  submitForm: function (event) {
    var $errorsDiv = $(this.$el.find('.errors'));
    $errorsDiv.empty();
    event.preventDefault();
    var attrs = $(event.currentTarget).serializeJSON().post;
    this.model.save(attrs, {
      success: function () {
        Backbone.history.navigate(this.model.url, {trigger :true})
      },
      error: function (model, response) {
        var errorsObj = JSON.parse(response.responseText)
        $errorsDiv.text(errorsObj.errors)
        this.$el.append($errors)
      }.bind(this)
    });
  }

});
