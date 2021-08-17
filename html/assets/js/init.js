
$(document).ready(function(){
  // LUA listener
  window.addEventListener('message', function( event ) {
    if (event.data.status == 'open') {
      var sex = event.data.information.gender
      $("#name").html(event.data.information.name);
      $("#sex").html(event.data.information.gender);
      $("#dob").html(event.data.information.dob);
      $("#nationality").html(event.data.information.nationality);
      $("#fingerprint").html(event.data.information.fingerprint);
      } 
        if ( sex == '0' ) {
          $('#id-card').show();
          $('#sex').text('male');
        } else if ( sex == '1' ) {
          $('#id-card').show();
          $('#id-card').css('background', 'url("/html/assets/images/idcard2.png")');
          $('#sex').text('female');
        }

        if (event.data.action == 'close') { 
          $('#id-card').hide();
        }
  });

  
});



