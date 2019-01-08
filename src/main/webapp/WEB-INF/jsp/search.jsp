<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Service Finder &mdash; DMNG team</title>
    <%@include file="newHeader.jsp" %>
    <style>
        #distance {
            background-color: rgba(0, 0, 0, 0) !important;
            border: none !important;
        }

        input[type="number"]::-webkit-outer-spin-button,
        input[type="number"]::-webkit-inner-spin-button {
            -webkit-appearance: none;
            margin: 0;
        }

        input[type="number"] {
            -moz-appearance: textfield;
        }

        .hiddenProfessional {
            display: none !important;
        }
    </style>
</head>
<body>
<div class="site-wrap">
    <%@include file="navbar.jsp" %>
    <div class="site-blocks-cover overlay"
         style="background-image: url('${pageContext.request.contextPath}/dist/images/hero_1.jpg');" data-aos="fade"
         data-stellar-background-ratio="0.5">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-12" data-aos="fade">
                    <h1>Find Service</h1>
                    <form action="#">
                        <form enctype="multipart/form-data">
                            <div class="row mb-3">
                                <div class="col-md-9">
                                    <div class="row">
                                        <div class="col-md-6 mb-3 mb-md-0">
                                            <select class="mr-3 form-control border-0 px-4" id="pro" name="pro">
                                                <option selected>Choose Service...</option>
                                                <c:forEach items="${allProfessions}" var="item">
                                                    <option value="${item.id}">${item.profession}</option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                        <div class="col-md-6 mb-3 mb-md-0">
                                            <div class="input-wrap">
                                                <a href="" class="icon icon-room" id="loc"></a>
                                                <input type="text"
                                                       class="form-control form-control-block search-input  border-0 px-4"
                                                       id="address" placeholder="city, province or region" required>
                                                <input type="number" class="d-none" name="long" id="long" required>
                                                <input type="number" class="d-none" name="lat" id="lat" required>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <button class="btn btn-search btn-primary btn-block" id="search">Search</button>
                                </div>
                            </div>
                            <div class="row mb-3">
                                <div class="col-md-6 mb-3 mb-md-0">
                                    <label class="text-white" for="distance">Searched distance in kilometers:</label>
                                    <input type="number" id="distance" name="distance" class="text-white" readonly>
                                </div>
                                <div class="col-md-6 mb-3 mb-md-0">
                                    <div id="slider"></div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-12">
                                    <p class="small">or browse by category:
                                        <c:forEach items="${allProfessions}" var="item">
                                            <a href="${pageContext.request.contextPath}/user/viewselectedcategoryofprof.htm?categoryidofprof=${item.id}"
                                               name="categoryidofprof" class="category">${item.profession}</a>
                                        </c:forEach>
                                    </p>
                                </div>
                            </div>
                        </form>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <div class="site-section bg-light d-none" id="searchResults">
        <div class="container">
            <div class="row h-75">
                <div class="col-md-5 mb-5 mb-md-0" data-aos="fade-up" data-aos-delay="100">
                    <h2 class="mb-5 h3">Available Professionals</h2>
                    <a href="#" class="owl-custom2-next" onclick="nextFivechildren(event);">Next</a>
                    <div class="ml-auto mt-1">
                    </div>
                    <div class="rounded border jobs-wrap" id="professionals">
                    </div>
                </div>
                <div class="col-md-7 block-16" data-aos="fade-up" data-aos-delay="200">
                    <div class="d-flex mb-0">
                        <h2 class="mb-5 h3 mb-0">Map</h2>

                    </div>
                    <div id="googleMap"></div>
                </div>
            </div>
        </div>
		</div>
            <div class="site-section site-block-feature bg-light">
      <div class="container">
        <br>
          <br>
          <br>
        <div class="text-center mb-5 section-heading">
          <h2>Categories of Services</h2>
        </div>

                <div class="d-block d-md-flex border-bottom">
                    <div class="text-center p-4 item border-right" data-aos="fade">
                        <span class="flaticon-calculator display-3 mb-3 d-block text-primary"></span>
                        <h2 class="h4">Accountants</h2>
                        <p>Provides financial information to management by researching and analyzing accounting data,
                            preparing reports.</p>
                        <p><a href="${pageContext.request.contextPath}/user/viewselectedcategoryofprof.htm?categoryidofprof=2">See Profiles <span class="icon-arrow-right small"></span></a></p>
                    </div>
                    <div class="text-center p-4 item" data-aos="fade">
                        <span class="flaticon-stethoscope display-3 mb-3 d-block text-primary"></span>
                        <h2 class="h4">Doctors</h2>
                        <p>Hospital doctors diagnose and treat medical conditions, disorders, and diseases through the application of 
                            specialist medical skills and knowledge.</p>
                        <p><a href="${pageContext.request.contextPath}/user/viewselectedcategoryofprof.htm?categoryidofprof=3">See Profiles <span class="icon-arrow-right small"></span></a></p>
                    </div>
                </div>
                <div class="d-block d-md-flex">
                    <div class="text-center p-4 item border-right" data-aos="fade">
                        <span class="flaticon-computer-graphic display-3 mb-3 d-block text-primary"></span>
                        <h2 class="h4">Web-Developers </h2>
                        <p>Web developer responsibilities include building our website from concept all the way to completion from the bottom up, 
                            fashioning everything from the home page to site layout and function.</p>
                        <p><a href="${pageContext.request.contextPath}/user/viewselectedcategoryofprof.htm?categoryidofprof=4">See Profiles <span class="icon-arrow-right small"></span></a></p>
                    </div>                    
                </div>
            </div>
        </div>
    </div>
<script>
    var nextFivechildren = function (event) {
        event.preventDefault();
        var lastChild = document.getElementById("professionals").lastChild;
        var numberOfChildren = lastChild.id;
        var count = 0;
        for (var number = 0; number < numberOfChildren || count < 5; number++) {

            if ($('#' + number).hasClass("hiddenProfessional")) {
                $('#' + number).removeClass("hiddenProfessional");
            } else {
                count = count + 1;
                $('#' + number).addClass("hiddenProfessional");
            }
        }
    };
</script>
<%@include file="footer.jsp" %>
<%@include file="map.jsp" %>
</body>
</html>