<!DOCTYPE html>
<html>
    <head>
        <title>Service Finder &mdash; DMNG team</title>
        <%@include file = "newHeader.jsp" %>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/profile.css">
        <link href="${pageContext.request.contextPath}/dist/css/custom-dMng.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>
        <%@include file = "navbar.jsp" %>
        <div class="site-wrap">
            <div class="unit-5 overlay" style="background-image: url('${pageContext.request.contextPath}/dist/images/woodWallpaper.jpg');">
                <div class="container text-center">
                    <h2 class="mb-0 lettering">${thiscategory.profession}s</h2>
                    <p class="mb-0 unit-6">
                        <a href="${pageContext.request.contextPath}/user/search.htm">Home</a>
                        <br /></p>
                </div>
            </div>
    <div class="site-section">
      <div class="container">
        <div class="row">
          <div class="col-md-6 mx-auto text-center mb-5 section-heading">
            <h2 class="mb-5">Profiles</h2> 
            <c:if test="${allprofswithsamecategoryid.size()==0}">
       
            <div class="container text-center">
                <h2 class="mb-0">There are no providers at the Moment!</h2>
            </div>
    </c:if>
          </div>
        </div>
        <div class="row">
             <c:forEach items="${allprofswithsamecategoryid}" var="item">
          <div class="col-sm-6 col-md-4 col-lg-3 mb-3" data-aos="fade-up" data-aos-delay="100">
            <a href="${pageContext.request.contextPath}/user/viewselectedprof.htm?email=${item.userEntity.email}" name="email" class="h-100 feature-item">
                        
                            <div class="avatar-upload">
                                <div class="avatar-preview">
                                    <div id="imagePreview"
                                         style="background-image: url('/images/${item.userEntity.profilePicture}');">
                                    </div>
                                </div>
                            </div>
                            <h2>${item.userEntity.firstName} ${item.userEntity.lastName}</h2>
                        </a>
                </div>
            </c:forEach>
        </div>
      </div>
    </div>
            <%@include file = "footer.jsp" %>
        </div>
            <script src="${pageContext.request.contextPath}/dist/js/profile.js" type="text/javascript" ></script>
    </body>
</html>