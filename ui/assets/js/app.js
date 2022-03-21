window.addEventListener('message', function(idcard) {
    $('.qb-idcard').show();
    $('.qb-idcard').addClass('slide-in');
    const person = {
        Name: idcard.data.information.name,
        Lastname: idcard.data.information.lastname,
        Dob: idcard.data.information.dob,
        Nationality: idcard.data.information.nationality,
        Sex: idcard.data.information.gender
    };
    switch (idcard.data.nui) {
        case 'idcard':
            $("#lang-header2").html(QB.Idcard.header);
            $("#name").html(person.Name);
            $("#lastname").html(person.Lastname);
            $("#dob").html(person.Dob);
            $("#nationality").html(person.Nationality);
            $('.qb-idcard').css('background', QB.Idcard.background);
            break;
        case 'driverlicense':
            $("#lang-header2").html(QB.Driverlicense.header);
            $("#name").html(person.Name);
            $("#lastname").html(person.Lastname);
            $("#dob").html(person.Dob);
            $('#lang-sex').html('Type');
            $('#sex').html('CLASS C Driver License');
            $("#lang-nat").css('display', 'none');
            $('.qb-idcard').css('background', QB.Driverlicense.background);
            break;
        case 'weaponlicense':
            $("#lang-header2").html(QB.Weaponlicense.header);
            $("#name").html(person.Name);
            $("#lastname").html(person.Lastname);
            $("#dob").html(person.Dob);
            $('.qb-idcard').css('background', QB.Weaponlicense.background);
            $("#lang-nat").css('display', 'none');
            $("#lang-sex").css('display', 'none');
            break;
        case 'lawyerpass':
            $("#lang-header2").html(QB.Lawyerpass.header);
            $("#name").html(person.Name);
            $("#lastname").html(person.Lastname);
            $("#dob").html(person.Dob);
            $('.qb-idcard').css('background', QB.Lawyerpass.background);
            $("#lang-nat").css('display', 'none');
            $("#lang-sex").css('display', 'none');
            break;
        case 'policecard':
            $("#lang-header2").html(QB.Policeidcard.header);
            $("#name").html(person.Name);
            $("#lastname").html(person.Lastname);
            $("#dob").html(person.Dob);
            $("#nationality").html(person.Nationality);
            $("#type").html('');
            $('.qb-idcard').css('background', QB.Policeidcard.background);
            break;
    }
    let imageMug;
    if (person.Sex == '0') {
        $('#sex').html('Male');
        imageMug = 'assets/img/male.png';
        $('#seximg').attr('src', imageMug);
    } else if (person.Sex == '1') {
        $('#sex').html('Female');
        imageMug = 'assets/img/female.png';
        $('#seximg').attr('src', imageMug);
    }
});

$("#lang-header1").html(QB.Idcardlang.header);
$("#lang-last").html(QB.Idcardlang.langlast);
$("#lang-first").html(QB.Idcardlang.langfirst);
$("#lang-dob").html(QB.Idcardlang.langdob);
$("#lang-sex").html(QB.Idcardlang.langsex);
$("#lang-nat").html(QB.Idcardlang.langnat);

hidefunction = function() {
    $('.qb-idcard').addClass('slide-out');
    setTimeout(function() {
        $('.qb-idcard').removeClass('slide-in');
        $('.qb-idcard').removeClass('slide-out');
        $('.qb-idcard').hide();
        location.reload();
    }, 1000)
}

document.onkeyup = function(event) {
    event = event || window.event;
    var charCode = event.keyCode || event.which;
    if (charCode == 8) { // Nui hide key backspace
        $.post(`https://qb-idcard/escape`)
        hidefunction()
    }
};
