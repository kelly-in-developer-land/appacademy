JournalApp.Collections.Posts = Backbone.Collection.extend({
  url: "posts",
  model: JournalApp.Models.Post,

  getOrFetch: function(id) {
    var mod = collection.get(id)
    if (mod) {
      mod.fetch();
    } else {
      mod = new this.model;
      mod.fetch({
        success: this.add(mod)
      });
    }

    return mod;
  }
})
