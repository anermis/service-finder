$(document).ready(function () {
    if ($("#switch-readonly-fn")) {
        $("#switch-readonly-fn").click(function (e) {
            e.preventDefault();
            if ($("#firstName").attr("readonly")) {
                $("#firstName").prop("readonly", false);
            } else {
                $("#firstName").prop("readonly", true);
            }
        });
    }
    if ($("#switch-readonly-ln")) {
        $("#switch-readonly-ln").click(function (e) {
            e.preventDefault();
            if ($("#lastName").attr("readonly")) {
                $("#lastName").prop("readonly", false);
            } else {
                $("#lastName").prop("readonly", true);
            }
        });
    }
    if ($("#switch-readonly-e")) {
        $("#switch-readonly-e").click(function (e) {
            e.preventDefault();
            if ($("#email").attr("readonly")) {
                $("#email").prop("readonly", false);
            } else {
                $("#email").prop("readonly", true);
            }
        });
    }
    if ($("#switch-readonly-p")) {
        $("#switch-readonly-p").click(function (e) {
            e.preventDefault();
            if ($("#password").attr("readonly")) {
                $("#password").prop("readonly", false);
            } else {
                $("#password").prop("readonly", true);
            }
        });
    }
    if ($("#switch-readonly-m")) {
        $("#switch-readonly-m").click(function (e) {
            e.preventDefault();
            if ($("#phone1").attr("readonly")) {
                $("#phone1").prop("readonly", false);
            } else {
                $("#phone1").prop("readonly", true);
            }
        });
    }
    if ($("#switch-readonly-l")) {
        $("#switch-readonly-l").click(function (e) {
            e.preventDefault();
            if ($("#phone2").attr("readonly")) {
                $("#phone2").prop("readonly", false);
            } else {
                $("#phone2").prop("readonly", true);
            }
        });
    }

    function readURL(input) {
        if (input.files && input.files[0]) {
            var reader = new FileReader();
            reader.onload = function (e) {
                $('#imagePreview').css('background-image', 'url(' + e.target.result + ')');
                $('#imagePreview').hide();
                $('#imagePreview').fadeIn(650);
            };
            reader.readAsDataURL(input.files[0]);
        }
    }


    $("#imageUpload").change(function (e) {
       
        var form = document.forms[1];
        var formData = new FormData(form);//html5 FormData
        var ajaxReq = $.ajax({
            url: 'fileUpload.htm',
            type:'POST',
            data: formData,
            cache: false,//mporei k na mi xreiazetai sto post
            //to documentation leei na mi cacharetai i selida
            contentType: false,
            //den jerw ti arxeio tha m steilei
            processData: false 
            //Callback for creating the XMLHttpRequest object
        });readURL(this);

        // Called on success of file upload
        ajaxReq.done(function (msg) {
            $('#alertMsg').text(msg);
            $('#imageUpload').val('');

        });

        // Called on failure of file upload
        ajaxReq.fail(function (jqXHR) {
            $('#alertMsg').text(jqXHR.responseText + '(' + jqXHR.status +
                ' - ' + jqXHR.statusText + ')');
        });
    });
});