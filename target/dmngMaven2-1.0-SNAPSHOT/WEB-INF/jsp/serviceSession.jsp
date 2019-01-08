<html>
    <head>
        <title>Service Finder &mdash; DMNG team</title>
        <%@include file="newHeader.jsp" %>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/profile.css">
    </head>
    <body>
        <c:if test="${sessionScope.user.professionsEntity.id==1}">
            <%@include file="navbar.jsp" %>
        </c:if>
        <c:if test="${sessionScope.user.professionsEntity.id>1}">
            <%@include file="navbarProf.jsp" %>
        </c:if>
        <div class="site-wrap">
            <div class="unit-5 overlay"
                 style="background-image: url('${pageContext.request.contextPath}/dist/images/woodWallpaper.jpg');">
                <div class="container text-center">
                    <h2 class="mb-0">Service</h2>
                    
                </div>
            </div>
            <div class="py-5 quick-contact-info">
                <div class="container">
                    <div class="row">
                        <div class="col-md-4">
                            <a href="#" class=" feature-item">
                                <div class="avatar-upload">
                                    <div class="avatar-preview">
                                        <div style="background-image: url('/images/${sessionScope.user.getUserEntity().getProfilePicture()}');">
                                        </div>
                                    </div>
                                </div>
                                <h2>${sessionScope.user.userEntity.firstName} ${sessionScope.user.userEntity.lastName}</h2>
                                <h6><span class="icon-room"></span> Location</h6>
                                <p class="mb-0">${sessionScope.user.addressEntity.address}</p>
                            </a>
                        </div>

                        <div class="col-md-4">
                            <div>
                                <br>
                                <center>
                                    <h2>Starting Date</h2>
                                    <p class="mb-0">${service.startDate}</p>
                                    <br>
                                    <h2>Service Title</h2>
                                    <spring:form modelAttribute="service" method="post" id="serviceValue"
                                                 action="${pageContext.request.contextPath}/prof/editService.htm">

                                        <p class="mb-4 h6 font-italic lineheight1-5">
                                            <c:if test="${sessionScope.user.professionsEntity.id>1}">
                                                <spring:input class="f" path="topic" style="text-align:center;"
                                                              title="Only editable from the professional."/>                                                
                                            </c:if>
                                            <c:if test="${sessionScope.user.professionsEntity.id==1}">
                                                ${service.topic}

                                            </c:if>

                                        </p>
                                        <h2>Cost</h2>
                                        <span class="mb-4 h4 font-italic lineheight1-5">
                                            <c:if test="${sessionScope.user.professionsEntity.id>1}">
                                                <spring:input class="f" path="cost" style="text-align:center;"
                                                              title="Only editable from the professional."/><span class="icon-euro h5"></span>
                                            </c:if>
                                            <c:if test="${sessionScope.user.professionsEntity.id==1}">
                                                <h3>${service.cost}<span class="icon-euro h5"></span></h3>

                                            </c:if>
                                        </span>                                        
                                        <input type="submit" id="subButton">
                                    </spring:form>
                                    <a href="tel:'${service.otherUser.phoneEntity.mobile}'"
                                       class="text-info p-2 rounded border border-info h3"><span class="icon-phone"></span></a>
                                        <c:choose>
                                            <c:when test="${sessionScope.user.userEntity.professionId==1}">
                                            <a href="${pageContext.request.contextPath}/user/chat/${service.otherUser.userEntity.id}.htm "
                                               class="text-info p-2 rounded border border-info h3"><span
                                                    class="icon-message"></span></a>
                                                <c:choose>
                                                    <c:when test="${service.fulfilled==false}">
                                                    <form method="get"
                                                          action="${pageContext.request.contextPath}/user/endService.htm">
                                                        <br>
                                                        <input type="submit" value="End Service"
                                                               class="btn btn-primary pill px-4 py-2">
                                                    </form>
                                                </c:when>
                                            </c:choose>
                                        </c:when>
                                        <c:otherwise>
                                            <a href="${pageContext.request.contextPath}/prof/chat/${service.otherUser.userEntity.id}.htm "
                                               class="text-info p-2 rounded border border-info h3"><span
                                                    class="icon-message"></span></a>
                                            </c:otherwise>
                                        </c:choose>
                                </center>
                            </div>
                        </div>

                        <div class="col-md-4">
                            <a href="#" class=" feature-item">
                                <div class="avatar-upload">
                                    <div class="avatar-preview">
                                        <div id="imagePreview"
                                             style="background-image: url('/images/${service.otherUser.userEntity.profilePicture}');">
                                        </div>
                                    </div>
                                </div>
                                <h2>${service.otherUser.userEntity.firstName} ${service.otherUser.userEntity.lastName}</h2>
                                <h6><span class="icon-room"></span> Location</h6>
                                <p class="mb-0">${service.otherUser.addressEntity.address}</p>
                            </a>
                        </div>

            </div>

            <div class="row">
                <div class="col-md-4">
                </div>

                <c:choose>
                    <c:when test="${service.fulfilled==true}">
                        <div class="col-md-4" id="rating-ability-wrapper">
                            <br>
                            <h2 style="">Rate Your Experience</h2>
                            <form>
                                <label class="control-label" for="selected_rating">
                                    <input type="hidden" id="selected_rating" name="selected_rating" value="">
                                </label>
                                <button type="button" class="btnrating btn btn-default btn-lg rating-dmng" name="rating"
                                        value="1"
                                        id="rating-star-1">
                                    <i class="icon-star" aria-hidden="true"></i>
                                </button>
                                <button type="button" class="btnrating btn btn-default btn-lg rating-dmng" name="rating"
                                        value="2"
                                        id="rating-star-2">
                                    <i class="icon-star" aria-hidden="true"></i>
                                </button>
                                <button type="button" class="btnrating btn btn-default btn-lg rating-dmng" name="rating"
                                        value="3"
                                        id="rating-star-3">
                                    <i class="icon-star" aria-hidden="true"></i>
                                </button>
                                <button type="button" class="btnrating btn btn-default btn-lg rating-dmng" name="rating"
                                        value="4"
                                        id="rating-star-4">
                                    <i class="icon-star" aria-hidden="true"></i>
                                </button>
                                <button type="button" class="btnrating btn btn-default btn-lg rating-dmng" name="rating"
                                        value="5"
                                        id="rating-star-5">
                                    <i class="icon-star" aria-hidden="true"></i>
                                </button>
                            </form>
                        </div>
                    </c:when>
                </c:choose>
            </div>


            <%@include file="footer.jsp" %>
        </div>
        <script>

            function markStars(rating) {
                $("btnrating").toggleClass('btn-default');
                for (i = 1; i <= rating; i++) {
                    $("#rating-star-" + i).toggleClass('btn-success');
                }
            }

            $(document).ready(function () {

    function markStars(rating) {
        $("btnrating").toggleClass('btn-default');
        for (i = 1; i <= rating; i++) {
            $("#rating-star-" + i).toggleClass('btn-success');
        }
    }

    $(document).ready(function () {

        if ("${sessionScope.user.professionsEntity.id}" > 1 && "${service.fulfilled}" === true) {
            for (ix = 1; ix <= ${service.rating}; ++ix) {
                $("#rating-star-" + ix).tog gleClass('btn-success');
                $("#rating-star-" + ix).toggleClass('btn-default');
            }
        }

        if ("${sessionScope.user.professionsEntity.id}" == 1 || "${service.fulfilled}" == true) {
            $('#subButton').addClass('d-none');
            $('.f').prop('readonly', true);
        }

        $(".btnrating").on('click', (function (e) {
            e.preventDefault();
            if ('${sessionScope.user.professionsEntity.id}' == 1) {
                var rating = $(this).val();
                $.ajax({
                    url: '${pageContext.request.contextPath}/user/rate.htm?selected_rating=' + rating + '&serviceid=${service.id}',
                    contentType: 'application/json',
                    method: 'get',
                    success: function (result) {
                        markStars(rating);
                    }
                });
            }
        }));

        if ("${sessionScope.user.professionsEntity.id}" == 1 || "${service.fulfilled}" == true) {
            $('#subButton').addClass('d-none');
            $('.f').prop('readonly', true);
        }
    });
</script>
</body>
</html>