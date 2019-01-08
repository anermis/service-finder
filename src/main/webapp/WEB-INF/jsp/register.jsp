<script>
    var ajaxEnabled = true;
    var emailEnabled = true;
    var passwordEnabled = true;

    EnableSubmit = function (val) {
        var sbmt = document.getElementById("actionLogin");

        if (val.checked === true) {
            sbmt.disabled = false;
        } else {
            sbmt.disabled = true;
        }
    };

    EnableEmail = function () {
        document.getElementById('message5').innerHTML = '';
        if (document.getElementById('email').value ===
            document.getElementById('emailConfirm').value) {
            emailEnabled = true;
        } else {
            emailEnabled = false;
        }
    };

    EnablePassword = function () {
        document.getElementById('message5').innerHTML = '';
        if (document.getElementById('pass').value ===
            document.getElementById('passwordConfirm').value) {
            passwordEnabled = true;
        } else {
            passwordEnabled = false;
        }
    };

    CheckEmail = function () {
        if (document.getElementById('email').value ===
            document.getElementById('emailConfirm').value) {
            document.getElementById('message1').style.color = 'green';
            document.getElementById('message1').innerHTML = 'E-mails match';
        } else {
            document.getElementById('message1').style.color = 'red';
            document.getElementById('message1').innerHTML = 'E-mails do not match';
        }
    };

    CheckPassword = function () {
        if (document.getElementById('pass').value ===
            document.getElementById('passwordConfirm').value) {
            document.getElementById('message2').style.color = 'green';
            document.getElementById('message2').innerHTML = 'Passwords match';
        } else {
            document.getElementById('message2').style.color = 'red';
            document.getElementById('message2').innerHTML = 'Passwords do not match';
        }
    };

    toggleField = function () {
        var a = $("#profselect").val();
        if (a === "User") {
            $("#address").removeAttr("required");
            $(".displayNone").hide();
            SelectElement("professionId", 1);
        } else if (a === "Professional") {
            $("#address").attr("required", "required");
            $(".displayNone").show();
        }
    };

    function SelectElement(id, valueToSelect) {
        var element = document.getElementById(id);
        element.value = valueToSelect;
    }

    function blockSpecialChar(e) {
        var k = e.charCode || e.keyCode;
        return ((k > 64 && k < 91) || ((k > 903 && k < 975) || (k > 96 && k < 123) || k === 8 || k === 902));
    }

    function blockSpecialCharForNumber(e) {
        var k = e.charCode || e.keyCode;
        return ((k > 47 && k < 58) || k === 43);
    }

    function checkBeforeSubmit(event) {
        enabled2 = ((emailEnabled && passwordEnabled) && ajaxEnabled);
        if (enabled2 !== true) {
            event.preventDefault();
            document.getElementById('message5').style.color = 'red';
            document.getElementById('message5').innerHTML = 'Please check the data you submitted';
        }
    }

    $(document).ready(function () {
        $("#email").change(function () {
            var text = $(this).val();
            document.getElementById('message4').style.color = 'blue';
            document.getElementById('message4').innerHTML = 'Please allow some seconds to check the database';
            $.ajax({

                url: 'http://localhost:8080/dmngMaven2_war_exploded/mailREST.htm?email=' + text,
                contentType: false,
                success: function (result) {
                    var jsonobj = $.parseJSON(result);
                    if (!jsonobj.exists) {
                        document.getElementById('message4').style.color = 'green';
                        document.getElementById('message4').innerHTML = 'This e-mail is acceptable!!';
                    } else {
                        document.getElementById('message4').style.color = 'red';
                        document.getElementById('message4').innerHTML = 'E-mail already exists!!';
                    }
                }
            });
        });
    });


    $().ready(function () {
        $("#card").flip({
            trigger: 'manual'
        });
    });


    $(".signup_link").click(function () {

        $(".signin_form").css('opacity', '0');
        $(".signup_form").css('opacity', '100');


        $("#card").flip(true);

        return false;
    });

    $("#unflip-btn").click(function () {

        $(".signin_form").css('opacity', '100');
        $(".signup_form").css('opacity', '0');

        $("#card").flip(false);

        return false;

    });

    $(function () {

        if (localStorage.chkbox && localStorage.chkbox != '') {
            $('#rememberChkBox').attr('checked', 'checked');
            $('#emailLogin').val(localStorage.email);
            $('#passwordLogin').val(localStorage.pass);
        } else {
            $('#rememberChkBox').removeAttr('checked');
            $('#emailLogin').val('');
            $('#passwordLogin').val('');
        }

        $('#rememberChkBox').click(function () {

            if ($('#rememberChkBox').is(':checked')) {
                localStorage.email = $('#emailLogin').val();
                localStorage.pass = $('#passwordLogin').val();
                localStorage.chkbox = $('#rememberChkBox').val();
            } else {
                localStorage.username = '';
                localStorage.pass = '';
                localStorage.chkbox = '';
            }
        });
    });
</script>
<script src="${pageContext.request.contextPath}/dist/js/autocomplete.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/dist/js/jquery.cookie.min.js" type="text/javascript"></script>