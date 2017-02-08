$(document).ready(function (e) {
    $('.expanded').click(function (e) {
        if (window.innerWidth <= 768) {
            $('.expanded').removeClass("up");
            $(this).toggleClass("up");
            if ($(this).next('.expanded-data').css('display') != 'block') {
                $('.active').slideUp('slow').removeClass('active');
                $(this).next('.expanded-data').addClass('active').slideDown('slow');
            } else {
                if (!($(this).hasClass("up"))) {
                    $('.expanded').removeClass("up");
                    $('.active').slideUp('slow').removeClass('active');
                }
            }
        }
    });
});