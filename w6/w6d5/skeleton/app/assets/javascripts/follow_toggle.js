$.FollowToggle = function (el) {
  this.$el = $(el);
  this.userId = this.$el.attr("user-id");
  this.followState = this.$el.attr("initial-follow-state") === true ? "followed" : "unfollowed";
  this.handleClick();
};

$.FollowToggle.prototype.render = function () {
    if (this.followState === "unfollowed") {
      this.$el.text("Follow!");
      this.$el.prop("disabled", false);
    } else if (this.followState === "followed") {
      this.$el.text("Unfollow!");
      this.$el.prop("disabled", false);
    } else {
      this.$el.prop("disabled", true);
    }
};

$.FollowToggle.prototype.handleClick = function () {
  var that = this;
  this.$el.on("click", function () {
    event.preventDefault();
    // that.$el.prop("disabled", true);
    // that.render();

    var ttype = "post";
    if (that.followState === "followed") {
      that.followState = "unfollowing";
      ttype = "delete";
    } else {
      that.followState = "following";
    }
    that.render();
    // if (that.$el.prop("disabled")) {
      $.ajax ({ type: ttype, url: "/users/" + that.userId + "/follow",
                dataType: "json", success: function () {
                  if (that.followState === "following") {
                    that.followState = "followed";
                  } else {
                    that.followState = "unfollowed";
                  }
                  that.render();
                }});
      // that.$el.prop("disabled", false);
    // }
  });
};

$.fn.followToggle = function () {
  return this.each(function () {
    var newFollowToggle = new $.FollowToggle(this);
    newFollowToggle.render();
  });
};

$(function () {
  $("button.follow-toggle").followToggle();
});
