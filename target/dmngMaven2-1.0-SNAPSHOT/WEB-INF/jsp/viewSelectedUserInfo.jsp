<!DOCTYPE html>
<html>
<head>
    <title>Service Finder &mdash; DMNG team</title>
    <%@include file="newHeader.jsp" %>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/profile.css">
    <link href="${pageContext.request.contextPath}/dist/css/custom-dMng.css" rel="stylesheet" type="text/css"/>
</head>
<body>
<%@include file="navbar.jsp" %>
<div class="site-wrap">
    <div class="unit-5 overlay"
         style="background-image: url('${pageContext.request.contextPath}/dist/images/woodWallpaper.jpg');">
        <div class="container text-center">
            <h2 class="mb-0 lettering">${selectedUser.getUserEntity().getFirstName()} ${selectedUser.getUserEntity().getLastName()}</h2>
            <p class="mb-0 unit-6">
                <a href="${pageContext.request.contextPath}/home/initialForm.htm">Home</a>
                <span class="sep">></span>
                <c:forEach items="${allProfessions}" var="item">
                    <c:choose>
                        <c:when test="${item.id==selectedUser.getUserEntity().getProfessionId()}">
                            <a href="${pageContext.request.contextPath}/user/viewselectedcategoryofprof.htm?categoryidofprof=${selectedUser.getUserEntity().getProfessionId()}"
                               name="categoryidofprof">${selectedUser.getProfessionsEntity().getProfession()}s</a>
                            <br/>
                        </c:when>
                    </c:choose>
                </c:forEach>
            </p>
        </div>
    </div>


    <div class="site-section bg-light">
        <div class="container">
            <div class="row">

                <div class="col-md-12 col-lg-8 mb-5">
                    <div class="p-5 bg-white">
                        <h4 class="h4 text-black mb-3">Profile Info</h4>
                        <dl class="row p-3">
                            <dt class="col-sm-3">Fullname</dt>
                            <dd class="col-sm-9 lettering">
                                <p>${selectedUser.userEntity.lastName} ${selectedUser.userEntity.firstName} </p>
                            </dd>

                            <dt class="col-sm-3">Job Title</dt>
                            <dd class="col-sm-9 lettering">
                                <p>${selectedUser.professionsEntity.profession}</p>
                            </dd>

                            <dt class="col-sm-3">Email</dt>
                            <dd class="col-sm-9">
                                <p>${selectedUser.userEntity.email}</p>
                            </dd>

                            <dt class="col-sm-3">Address</dt>
                            <dd class="col-sm-9">
                                <p>${selectedUser.addressEntity.address}</p>
                            </dd>

                            <dt class="col-sm-3">Mobile</dt>
                            <dd class="col-sm-9"><p><a href="tel: ${selectedUser.phoneEntity.mobile}"
                                                       class="text-info p-2 rounded border border-info">${selectedUser.phoneEntity.mobile}</a>
                            </p></dd>

                            <dt class="col-sm-3">Landline</dt>
                            <dd class="col-sm-9"><p><a href="tel:${selectedUser.phoneEntity.landline}"
                                                       class="text-info p-2 rounded border border-info">${selectedUser.phoneEntity.landline}</a>
                            </p></dd>

                            <dt class="col-sm-3">Chat</dt>
                            <dd class="col-sm-9"><p><a
                                    href="${pageContext.request.contextPath}/user/chat/${selectedUser.userEntity.id}.htm"
                                    class="text-info p-2 rounded border border-info h5"><span
                                    class="icon-message"></span></a>
                            </p></dd>
                        </dl>
                    </div>
                </div>
                <div class="col-lg-4">
                    <div class="p-4 mb-3 bg-white">


                        <div class="form-group">
                            <div class="col-xs-12">
                                <div class="text-center">
                                    <div class="avatar-upload">

                                        <div class="avatar-preview">
                                            <div id="imagePreview"
                                                 style="background-image: url('http://localhost:8080/images/${selectedUser.getUserEntity().getProfilePicture()}');">
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>

                    <div class="p-4 mb-3 bg-white">
                        <h3 class="h5 text-black mb-3"></h3>
                        <div class="form-group" id="rating-ability-wrapper">
                            <label class="control-label" for="selected_rating">

                                <input type="hidden" id="selected_rating" name="selected_rating" value="${rating}">
                            </label>

                            <button type="button" class="btnrating btn btn-default btn-lg rating-dmng" data-attr="1"
                                    id="rating-star-1">
                                <i class="icon-star" aria-hidden="true"></i>
                            </button>
                            <button type="button" class="btnrating btn btn-default btn-lg rating-dmng" data-attr="2"
                                    id="rating-star-2">
                                <i class="icon-star" aria-hidden="true"></i>
                            </button>
                            <button type="button" class="btnrating btn btn-default btn-lg rating-dmng" data-attr="3"
                                    id="rating-star-3">
                                <i class="icon-star" aria-hidden="true"></i>
                            </button>
                            <button type="button" class="btnrating btn btn-default btn-lg rating-dmng" data-attr="4"
                                    id="rating-star-4">
                                <i class="icon-star" aria-hidden="true"></i>
                            </button>
                            <button type="button" class="btnrating btn btn-default btn-lg rating-dmng" data-attr="5"
                                    id="rating-star-5">
                                <i class="icon-star" aria-hidden="true"></i>
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>


    <div class="py-5 quick-contact-info">
        <div class="container">
            <div class="row">
                <div class="col-md-4">
                    <div>
                        <h2><span class="icon-room"></span> Location</h2>
                        <p class="mb-0">New York - 2398 <br> 10 Hadson Carl Street</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div>
                        <h2><span class="icon-clock-o"></span> Service Times</h2>
                        <p class="mb-0">Wednesdays at 6:30PM - 7:30PM <br>
                            Fridays at Sunset - 7:30PM <br>
                            Saturdays at 8:00AM - Sunset</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <h2><span class="icon-comments"></span> Get In Touch</h2>
                    <p class="mb-0">Email: info@yoursite.com <br>
                        Phone: (123) 3240-345-9348 </p>
                </div>
            </div>
        </div>
    </div>

    <%@include file="footer.jsp" %>
    <script>jQuery(document).ready(function ($) {


        for (ix = 1; ix <= $("#selected_rating").val(); ++ix) {
            $("#rating-star-" + ix).toggleClass('btn-success');
            $("#rating-star-" + ix).toggleClass('btn-default');
        }

    });
    </script>

</body>
</html>