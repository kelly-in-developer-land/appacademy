$.TweetCompose = function (el) {
  this.$el = $(el);
  this.$el.on("submit", this.submit);
  this.ulId = this.$el.data("tweets-ul");
};

$.TweetCompose.prototype.submit = function (event) {
  event.preventDefault();
  var content = $(this).serialize();
  $(":input").prop("disabled", true);
  $.ajax({  url: "/tweets", type: "post", dataType: "json",
            success: function (response) {
              this.handleSuccess(response);
            }.bind(this)
        });
};

$.TweetCompose.prototype.handleSuccess = function (response) {
  $(":input").val("");
  $(":input").prop("disabled", false);
  var tweet = JSON.stringify(response);
  $(this.ulId).append(("<li>").text(tweet));
};


$.fn.TweetCompose = function () {
  return this.each(function () {
    var newTweetCompose = new $.TweetCompose(this);
  });
};
