<%@page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Service Finder &mdash; DMNG team</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <link href="https://fonts.googleapis.com/css?family=Amatic+SC:400,700|Work+Sans:300,400,700" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/fonts/icomoon/style.css">

    <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/magnific-popup.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/jquery-ui.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/owl.carousel.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/owl.theme.default.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/bootstrap-datepicker.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/animate.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css//mediaelementplayer.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/fonts/flaticon/font/flaticon.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/aos.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/style.css">
    <script src="${pageContext.request.contextPath}/dist/js/jquery-3.3.1.min.js"></script>
    <style>

        .avatar-upload {
            position: relative;
            max-width: 205px;
            margin: 50px auto;
        }

        .avatar-upload .avatar-edit {
            position: absolute;
            right: 12px;
            z-index: 1;
            top: 0px;
        }

        .avatar-upload .avatar-edit input {
            display: none;
        }

        .avatar-upload .avatar-edit input + label {
            display: inline-block;
            width: 34px;
            height: 34px;
            margin-bottom: 0;
            border-radius: 100%;
            background: #FFFFFF;
            border: 1px solid transparent;
            box-shadow: 0px 2px 4px 0px rgba(0, 0, 0, 0.12);
            cursor: pointer;
            font-weight: normal;
            transition: all .2s ease-in-out;
        }

        .avatar-upload .avatar-edit input + label:hover {
            background: #f1f1f1;
            border-color: #d6d6d6;
        }

        .avatar-upload .avatar-edit input + label:after {
            content: "\f040";
            font-family: 'icomoon';
            color: #757575;
            position: absolute;
            top: 5px;
            left: 0;
            right: 0;
            text-align: center;
            margin: auto;
        }

        .avatar-upload .avatar-preview {
            width: 192px;
            height: 192px;
            position: relative;
            border-radius: 100%;
            border: 6px solid #F8F8F8;
            box-shadow: 0px 2px 4px 0px rgba(0, 0, 0, 0.1);
        }

        .avatar-upload .avatar-preview > div {
            width: 100%;
            height: 100%;
            border-radius: 100%;
            background-size: cover;
            background-repeat: no-repeat;
            background-position: center;
        }

    </style>

    <script>function readURL(input) {
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

    $(document).ready(function () {
        $("#imageUpload").change(function (e) {
            var form = document.forms[1];
            var formData = new FormData(form);
            var ajaxReq = $.ajax({
                url: 'fileUpload.htm',
                type: 'POST',
                data: formData,
                cache: false,
                contentType: false,
                processData: false
            });
            readURL(this);

            ajaxReq.done(function (msg) {
                $('#alertMsg').text(msg);
                $('#imageUpload').val('');

            });

            ajaxReq.fail(function (jqXHR) {
                $('#alertMsg').text(jqXHR.responseText + '(' + jqXHR.status +
                    ' - ' + jqXHR.statusText + ')');
            });
        });
    });
    </script>
</head>
<body>

<div class="site-wrap">

    <div class="site-mobile-menu">
        <div class="site-mobile-menu-header">
            <div class="site-mobile-menu-close mt-3">
                <span class="icon-close2 js-menu-toggle"></span>
            </div>
        </div>
        <div class="site-mobile-menu-body"></div>
    </div> <!-- .site-mobile-menu -->


    <div class="site-navbar-wrap js-site-navbar bg-white">

        <div class="container">
            <div class="site-navbar bg-light">
                <div class="py-1">
                    <div class="row align-items-center">
                        <div class="col-2">
                            <h2 class="mb-0 site-logo"><a href="${pageContext.request.contextPath}/user/search.htm">Service<strong
                                    class="font-weight-bold">Finder</strong> </a></h2>
                        </div>
                        <div class="col-10">
                            <nav class="site-navigation text-right" role="navigation">
                                <div class="container">
                                    <div class="d-inline-block d-lg-none ml-md-0 mr-auto py-3"><a href="#"
                                                                                                  class="site-menu-toggle js-menu-toggle text-black"><span
                                            class="icon-menu h3"></span></a></div>

                                    <ul class="site-menu js-clone-nav d-none d-lg-block">
                                        <li><a href="categories.html">For Customers</a></li>
                                        <li class="has-children">
                                            <a href="category.html">For Employees</a>
                                            <ul class="dropdown arrow-top">
                                                <li><a href="category.html">Category</a></li>
                                                <li><a href="#">Browse Candidates</a></li>
                                                <li><a href="new-post.html">Post a Job</a></li>
                                                <li><a href="${pageContext.request.contextPath}/user/account.htm">Profile</a>
                                                </li>
                                                <li class="has-children">
                                                    <a href="#">More Links</a>
                                                    <ul class="dropdown">
                                                        <li><a href="#">Browse Candidates</a></li>
                                                        <li><a href="#">Post a Job</a></li>
                                                        <li><a href="#">Employer Profile</a></li>
                                                    </ul>
                                                </li>

                                            </ul>
                                        </li>
                                        <li><a href="${pageContext.request.contextPath}/user/account.htm"><span
                                                class="icon-user mr-3"></span>Profile</a></li>
                                        <li><a href="${pageContext.request.contextPath}/user//search.htm"><span
                                                class="bg-primary text-white py-3 px-4 rounded"><span
                                                class="icon-search mr-3"></span>Search</span></a></li>
                                    </ul>
                                </div>
                            </nav>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div style="height: 113px;">
    </div>
</div>