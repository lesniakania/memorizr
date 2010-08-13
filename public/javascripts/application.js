$(document).ready(function() {
  $('#translate-form').submit(function(){
    $.post('/words/translate', $(this).serialize(), function(results) {
      var resultsDiv = $('#results');
      if (resultsDiv.html()) {
        resultsDiv.replaceWith(results);
      } else {
        $('#translate-form').after(results);
      }
    });

    return false;
  })

  $('#save-button').live('click', function() {
    var meanings = []
    $('#translation li').each(function() {
      meanings.push($.trim($(this).text()));
    })
    var data = {
      word: $.trim($('#word').text()),
      from: $.trim($('#from').text()),
      to: $.trim($('#to').text()),
      meanings: meanings
    }

    $.ajax({
      url: '/words/save',
      type: 'POST',
      data: data,
      success: function(response) {
        alert('success');
      },
      error: function() {
        alert('error');
      }
    });

    return false;
  })
});