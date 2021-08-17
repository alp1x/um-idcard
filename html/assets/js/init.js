
$(document).ready(function(){
  // LUA listener
  window.addEventListener('message', function( event ) {
    if (event.data.status == 'open') {
      let {gender, name, dob, nationality, fingerprint} = event.data.information;

      let sex = gender == 0 ? 'male' : 'female';

      $("#name").html(name);
      $("#sex").html(sex);
      $("#dob").html(dob);
      $("#nationality").html(nationality);
      $("#fingerprint").html(fingerprint);


      $('#id-card').fadeIn();
    }

    if (event.data.action == 'close') {
      $('#id-card').fadeOut();
    }
  });

  $('#id-card').css('background', 'url("/html/assets/images/idcard2.png")');
});


document.onkeyup = function (data) {
  if (data.which == 27) { // Escape key
    $.post('http://qb-idcard/escape', JSON.stringify({}));
  }
}
