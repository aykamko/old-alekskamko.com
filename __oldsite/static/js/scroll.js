$(document).ready(function() {
  var contentContainer = $('div.container-content')[0];
  var navBar = $('div.mobile-navbar')[0];
  var iconDiv = $('div.icon-div')[0];
  var scrollToContent = function() {
    var topY = $(contentContainer).position().top;
    var navBarHeight = $(navBar).height();
    var iconDivHeight = $(iconDiv).height();
    // top of content - navbar height - iconDivHeight - padding
    $(window).scrollTop(topY - navBarHeight - iconDivHeight - 26);
  }

  var pathname = window.location.pathname;
  // If not at base path and navbar is shown, scroll to content
  if (pathname.length > 1 && $(navBar).is(':visible')) {
    scrollToContent();
  }
});
