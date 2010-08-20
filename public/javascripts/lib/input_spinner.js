var InputSpinner = function(input) {
  this.input = input;
  this.submit = this.input.parents('form').find('input[type=submit]');
};

InputSpinner.IMAGE_SRC = '/images/ajax-loader.gif'
InputSpinner.IMAGE_TAG = '<img src="' + InputSpinner.IMAGE_SRC + '" border="0" class="input-spinner" />';

InputSpinner.prototype = {
  start: function() {
    this.submit.attr('disabled', true);
    this.input.after(InputSpinner.IMAGE_TAG);
    this.spinner = this.input.next();
  },
  
  stop: function() {
    this.submit.attr('disabled', false);
    this.spinner.remove();
    this.spinner = null;
  }
};
