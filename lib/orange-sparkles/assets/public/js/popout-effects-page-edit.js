$(function(){
  $('#save-draft').click(function(){
    $('#save-status').text('Saving draft...'); 
    $('#edit').ajaxSubmit({
      success: function(){
        $('#save-status').text('Draft saved.')
      }, 
      method: 'post'
    }); 
    return false;
  });
})