$.UsersSearch = function (el) {
  this.$el = $(el);
  this.$ul = $(this.$el.find("ul.users"));
  this.$input = $(this.$el.find("input"));
  this.handleInput();
};

$.UsersSearch.prototype.handleInput = function () {
  // currently requires click or enter, fix that
  var that = this;
  this.$input.on("change", function () {
    that.$ul.empty();
    var currentSearch = that.$input.val();
    $.ajax({  url: "/users/search?query=" + currentSearch,
              dataType: "json", data: currentSearch,
              success: function (response) {
                for (var i = 0; i < response.length; i++) {
                  var username = response[i].username;
                  var userId = response[i].id;

                  that.$ul.append("<li>"+username+"</li>").append("<button data-user-id=\""+response[i].id+"\">");
                  $("[data-user-id=\"" + userId + "\"]").addClass("follow-toggle").attr("data-initial-follow-state", response[i].followed).followToggle();
                }
              }
           });
  });
};


$.fn.usersSearch = function () {
  return this.each(function () {
    var newUsersSearch = new $.UsersSearch(this);
  });
};
