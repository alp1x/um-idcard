window.addEventListener('message', function( event ) {
  var sex = event.data.information.gender
  $('#card').show();
  if (event.data.nui == 'idcard') {
    $("#name").html(event.data.information.name);
    $("#sex").html(event.data.information.gender);
    $("#dob").html(event.data.information.dob);
    $("#nationality").html(event.data.information.nationality);
    $("#fingerprint").html(event.data.information.fingerprint);
    $("#type").html('');
    $("body").css("color","#000");
    }
    if (event.data.nui == 'driverlicense') {
      $("#name").html(event.data.information.name);
      $("#dob").html(event.data.information.dob);
      $("#type").html(event.data.information.type);
      $("#nationality").html('');
      $("#fingerprint").html('');
      $("#sex").html('');
      $("body").css("color","#fff");
      $('#card').css('background', 'url("/html/assets/images/driverlicense.png")');
      }  
    if ( sex == '0' ) {
      $('#card').css('background', 'url("/html/assets/images/idcard.png")');
      $('#sex').text('male');
    } else if ( sex == '1' ) {
      $('#card').css('background', 'url("/html/assets/images/idcard2.png")');
      $('#sex').text('female');
    }

});


document.onkeyup = function (event) {
event = event || window.event;
var charCode = event.keyCode || event.which;
if (charCode == 27) {
  $.post(`https://qb-idcard/escape`)
  $('#card').hide();
}};
