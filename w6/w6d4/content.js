(function() {

  $("ul").attr("data-content-tabs", "#content-tabs");

  var $contentTabs = $("<div>").attr("id", "content-tabs");
  $(".tabs").after($contentTabs);
  for (i = 0; i < 4; i++) {
    $contentTabs.append($("<div>").addClass("tab-pane"));
  }

  var breed = {
    0: "Labrador",
    1: "Labradoodle",
    2: "Poodle",
    3: "Cockerspaniel"
  };

  $(".tab-pane").each( function(i, el) {
    $(el).append($("<p>").text(breed[i] + "s are wonderful.")).attr("id", breed[i].toLowerCase());
    $("ul.tabs").append($("<li>").append($("<a>").attr("href", "#" + el.id).text(breed[i]).attr("id", breed[i].toLowerCase())));
  });

  var $firstTab = $("div.tab-pane").first();
  $firstTab.addClass("active");
  $($("a").attr("href")).addClass("active");

})();
