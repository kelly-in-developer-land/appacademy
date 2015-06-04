NewsReader.Models.Feed = Backbone.Model.extend({
  urlRoot: "api/feeds",

  entries: function () {
    if (!this._entries) {
      this._entries = new NewsReader.Collections.Entries([], { feed: this });
      this._entries.fetch({
        success: function () {
          return this._entries;
        }.bind(this)
      });
    } else {
      return this._entries;
    }
  },

  parse: function(response) {
    if (response.latest_entries) {
      this._entries.set(response.latest_entries);
      delete response.latest_entries;
    }

    return response;
  }

});
