var Anonymous = function() {
  this.initMailTo();
};

Anonymous.prototype = {
  initMailTo: function() {
    var email = 'memrzr' + ' [@] ' + 'gmail.com';
    var mailTo = $('#mail-to');
    mailTo.attr('href', 'mailto:' + email);
    mailTo.text(email);
  }
};

$(document).ready(function() {
  window.app = new Anonymous();
});
