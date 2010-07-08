$(function(){
  $("a[rel='colorbox']").colorbox({title: function(){
      var url = $(this).attr('href');
      return '<a href="'+url+'" target="_blank" onclick="$.fn.colorbox.close(); true">Open In New Window</a>';
  }, iframe: true, width: "90%", height: "90%", rel: 'nofollow'});
  $("#site-selector").change(function(){
    window.location = $(this).val();
  });
  
  $('a.insert_asset').colorbox({ width: "60%", height: "80%"});
});