var ButtonSpinner = function(button) {
  this.button = button;
};

ButtonSpinner.IMAGE_SRC = '/images/ajax-loader.gif'
ButtonSpinner.IMAGE_TAG = '<img src="' + ButtonSpinner.IMAGE_SRC + '" border="0" class="button-spinner" />';

ButtonSpinner.prototype = {
  start: function() {
    this.button.attr('disabled', true);
    this.button.after(ButtonSpinner.IMAGE_TAG);
    this.spinner = this.button.next();
  },

  stop: function() {
    this.button.attr('disabled', false);
    this.spinner.remove();
    this.spinner = null;
  }
};
