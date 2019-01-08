<html>
<head>
    <title>Service Finder &mdash; DMNG team</title>
    <%@include file="newHeader.jsp" %>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/profile.css">
</head>
<c:if test="${services.size()==0}">
<body>
</c:if>
<c:if test="${services.size()!=0}">
<body style="background-image: url('${pageContext.request.contextPath}/dist/images/hero_1.jpg');" data-aos="fade"
      data-stellar-background-ratio="0.5">
</c:if>
<c:if test="${sessionScope.user.professionsEntity.id==1}">
    <%@include file="navbar.jsp" %>
</c:if>
<c:if test="${sessionScope.user.professionsEntity.id>1}">
    <%@include file="navbarProf.jsp" %>
</c:if>
<div class="site-wrap">
    <div class="row">
        <div class="col-md-6 mx-auto text-center mb-5 section-heading">
            <br>
            <h1 style=" color: azure">${message}</h1>
        </div>
    </div>
    <c:if test="${services.size()==0}">
        <div class="unit-5 overlay"
             style="background-image: url('${pageContext.request.contextPath}/dist/images/woodWallpaper.jpg');">
            <div class="container text-center">
                <h2 class="mb-0">No Services at the Moment!</h2>
            </div>
        </div>
        <div class="site-section" data-aos="fade">
            <div class="container">
                <div class="container text-center">
                    <h3>Make some connections and enjoy the ServiceFinder</h3>
                </div>
            </div>
        </div>
    </c:if>
    <div class="container">
        <div class="row">
            <c:forEach items="${services}" var="item">
                <div class="col-sm-6 col-md-4 col-lg-3 mb-3" data-aos="fade-up" data-aos-delay="100">
                    <c:choose>
                    <c:when test="${sessionScope.user.professionsEntity.id!=1}">
                    <a href="${pageContext.request.contextPath}/prof/servicesession.htm?sessionId=${item.id}"
                       class=" feature-item">
                        </c:when>
                        <c:otherwise>
                        <a href="${pageContext.request.contextPath}/user/servicesession.htm?sessionId=${item.id}"
                           class=" feature-item">
                            </c:otherwise>
                            </c:choose>
                            <div class="avatar-upload">
                                <div class="avatar-preview">
                                    <div id="imagePreview"
                                         style="background-image: url('http://localhost:8080/images/${item.otherUser.userEntity.profilePicture}');">
                                    </div>
                                </div>
                            </div>
                            <h2>${item.otherUser.userEntity.firstName} ${item.otherUser.userEntity.lastName}</h2>
                            <span class="counting">${item.startDate}</span>
                        </a>
                </div>
            </c:forEach>
        </div>
    </div>
    <%@include file="footer.jsp" %>
</div>
</body>
</html>