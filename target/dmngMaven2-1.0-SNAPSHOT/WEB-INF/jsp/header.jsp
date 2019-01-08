<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
        <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/mediaelementplayer.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/fonts/flaticon/font/flaticon.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/aos.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/style.css">
        <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBpNb7KwtNgmsphG-7u8AhPPZ_h_4ZkG5Y&libraries=places&callback=initMap"></script>
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
                                    <h2 class="mb-0 site-logo"><a href="${pageContext.request.contextPath}/user/search.htm">Service<strong class="font-weight-bold">Finder</strong> </a></h2>
                                </div>
                                <div class="col-10">
                                    <nav class="site-navigation text-right" role="navigation">
                                        <div class="container">
                                            <div class="d-inline-block d-lg-none ml-md-0 mr-auto py-3"><a href="#" class="site-menu-toggle js-menu-toggle text-black"><span class="icon-menu h3"></span></a></div>

                                            <ul class="site-menu js-clone-nav d-none d-lg-block">
                                                <li><a href="categories.html">For Customers</a></li>
                                                <li class="has-children">
                                                    <a href="category.html">For Employees</a>
                                                    <ul class="dropdown arrow-top">
                                                        <li><a href="category.html">Category</a></li>
                                                        <li><a href="#">Browse Candidates</a></li>
                                                        <li><a href="new-post.html">Post a Job</a></li>
                                                        <li><a href="${pageContext.request.contextPath}/user/account.htm">Profile</a></li>
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
                                                <li><a href="${pageContext.request.contextPath}/user/account.htm"><span class="icon-user mr-3"></span>Profile</a></li>
                                                <li><a href="${pageContext.request.contextPath}/user/search.htm"><span class="bg-primary text-white py-3 px-4 rounded"><span class="icon-search mr-3"></span>Search</span></a></li>
                                            </ul>
                                        </div>
                                    </nav>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div style="height: 113px;"></div>
        </div>