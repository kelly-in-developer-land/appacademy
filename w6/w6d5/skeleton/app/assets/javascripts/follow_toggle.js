$.FollowToggle = function (el) {
  this.$el = $(el);
  this.userId = this.$el.data("user-id");
  this.followState = this.$el.data("initial-follow-state") === true ? "followed" : "unfollowed";
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

    var ttype = "post";
    if (that.followState === "followed") {
      that.followState = "unfollowing";
      ttype = "delete";
    } else {
      that.followState = "following";
    }
    that.render();
    $.ajax ({ type: ttype, url: "/users/" + that.userId + "/follow",
              dataType: "json", success: function (response) {
                if (that.followState === "following") {
                  that.followState = "followed";
                } else {
                  that.followState = "unfollowed";
                }
                that.render();
              }});
  });
};

$.fn.followToggle = function () {
  return this.each(function () {
    var newFollowToggle = new $.FollowToggle(this);
    newFollowToggle.render();
  });
};

// $(function () {
//   $("button.follow-toggle").followToggle();
// });
