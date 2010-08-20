var Application = function() {
  this.initFilter();
  this.initTranslate();
  this.initSave();
  this.initWordsList();
};

Application.prototype = {

  initFilter: function() {
    var button = $('#filter-form').find('input[type=submit]');
    this.filterSpinner = new ButtonSpinner(button);
    button.click($.proxy(this.onFilter, this));
  },

  onFilter: function(e) {
    this.filterSpinner.start();
  },
  
  initTranslate: function() {
    $('#translate-form').submit($.proxy(this.onTranslate, this));
    this.translateSpinner = new InputSpinner($('#word_value'));
  },

  onTranslate: function(e) {
    var form = $(e.currentTarget);
    $.ajax({
      url: '/words/translate',
      data: form.serialize(),
      type: 'POST',
      success: $.proxy(this.onTranslateSuccess, this),
      error: $.proxy(this.onTranslateError, this)
    });

    this.translateSpinner.start();

    return false;
  },

  onTranslateSuccess: function(results, status, xhr) {
    var resultsDiv = $('#results');
    if (resultsDiv.html()) {
      resultsDiv.replaceWith(results);
    } else {
      $('#translate-box').after(results);
    }

    this.translateSpinner.stop();
  },

  onTranslateError: function(xhr) {
    $('#translate-box').replaceWith(xhr.responseText);
    this.initTranslate();
  },
  
  initSave: function() {
    $('#save-button').live('click', $.proxy(this.onSave, this));
  },

  onSave: function() {
    var data = this.getTranslationData();

    $.ajax({
      url: '/words/save',
      type: 'POST',
      data: data,
      success: $.proxy(this.onSaveSuccess, this),
      error: $.proxy(this.onSaveError, this)
    });

    this.saveSpinner = new ButtonSpinner($('#save-button'));
    this.saveSpinner.start();

    return false;
  },

  getTranslationData: function() {
    var meanings = [];

    $('#translation li').each(function() {
      meanings.push($.trim($(this).text()));
    });

    var data = {
      word: $.trim($('#word').text()),
      from: $.trim($('#from').text()),
      to: $.trim($('#to').text()),
      meanings: meanings
    }

    return data;
  },

  onSaveSuccess: function(response, status, xhr) {
    this.saveSpinner.stop();
    var flash = $('#save-button').next('.flash');
    flash.text(response);
    flash.addClass('flash-notice');
    flash.show();
  },

  onSaveError: function(xhr) {
    this.saveSpinner.stop();
    var flash = $('#save-button').next('.flash');
    flash.text(xhr.responseText);
    flash.addClass('flash-error');
    flash.show();
  },

  initWordsList: function() {
    $('ul.custom li').toggle(function() {
      $(this).find('dd').slideDown();
    }, function() {
      $(this).find('dd').slideUp();
    });
  }

};

$(document).ready(function() {
  window.app = new Application();
});