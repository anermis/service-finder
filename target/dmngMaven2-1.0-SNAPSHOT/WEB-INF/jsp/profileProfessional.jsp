<html>
<head>
    <title>Service Finder &mdash; DMNG team</title>
    <%@include file = "newHeader.jsp" %>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/profile.css">
</head>
<body>
<%@include file = "navbarProf.jsp" %>
<div class="site-wrap">
    <div class="unit-5 overlay" style="background-image: url('${pageContext.request.contextPath}/dist/images/woodWallpaper.jpg');">
        <div class="container text-center">
            <h2 class="mb-0">Profile</h2>
            <p class="mb-0 unit-6">
                <a href="${pageContext.request.contextPath}/home/initialForm.htm">Home</a>
                <span class="sep">></span>
                <span>Profile</span></p>
        </div>
    </div>
    <div class="site-section bg-light">
        <div class="container">
            <div class="text-left mb-5 section-heading">
                <h3>${message}</h3>
            </div>
            <div class="row">
                <div id="login" class="col-md-12 col-lg-8 mb-5">
                    <spring:form action="${pageContext.request.contextPath}/prof/edited.htm" method="post" modelAttribute="userInSession" class="p-5 bg-white">
                        <h4 class="h4 text-black mb-3">Edit profile</h4>
                        <div class="row form-group">
                            <div class="col-md-12 mb-3 mb-md-0">
                                <spring:label path="userEntity.firstName" class="font-weight-bold" for="firstName">First Name</spring:label>
                                    <a id="switch-readonly-fn" href="">
                                        <span style="padding-left:15px" class="icon-edit">Edit</span>
                                    </a>
                                <spring:input path="userEntity.firstName" type="text" id="firstName" class="form-control" readonly="true"
                                              onkeypress="return blockSpecialChar(event)" />
                            </div>
                            <spring:errors path="userEntity.firstName"/>
                        </div>
                        <div class="row form-group">
                            <div class="col-md-12 mb-3 mb-md-0">
                                <spring:label path="userEntity.lastName" class="font-weight-bold switch-readonly" for="lastName">Last Name</spring:label>
                                    <a id="switch-readonly-ln" href="">
                                        <span style="padding-left:15px" class="icon-edit">Edit</span>
                                    </a>
                                <spring:input path="userEntity.lastName" type="text" id="lastName" class="form-control" placeholder="Last Name"
                                              onkeypress="return blockSpecialChar(event)" readonly="true"/>
                            </div>
                            <spring:errors path="userEntity.lastName"/>
                        </div>
                        <div class="row form-group">
                            <div class="col-md-12">
                                <spring:label path="userEntity.email" class="font-weight-bold" for="email">Email</spring:label>
                                    <a id="switch-readonly-e" href="">
                                        <span style="padding-left:15px" class="icon-edit">Edit</span>
                                    </a>
                                <spring:input path="userEntity.email" type="email" id="email" class="form-control" placeholder="Email Address"
                                              onkeyup='CheckEmail(); EnableEmail()' readonly="true"/>
                            </div>
                            <spring:errors path="userEntity.email"/>
                        </div>
                        <div class="row form-group">
                            <div class="col-md-12 mb-3 mb-md-0">
                                <spring:label path="phoneEntity.mobile" class="font-weight-bold" for="phone1">Mobile</spring:label>
                                    <a id="switch-readonly-m" href="">
                                        <span style="padding-left:15px" class="icon-edit">Edit</span>
                                    </a>
                                <spring:input path="phoneEntity.mobile" type="text" id="phone1" class="form-control" placeholder="Phone #"
                                              pattern=".{10,16}" title="10 to 16 characters"
                                              onkeypress="return blockSpecialCharForNumber(event)" readonly="true"/>
                            </div>
                            <spring:errors path="phoneEntity.mobile"/>
                        </div>
                        <div class="row form-group">
                            <div class="col-md-12 mb-3 mb-md-0">
                                <spring:label path="phoneEntity.landline" class="font-weight-bold" for="phone2">Landline</spring:label>
                                    <a id="switch-readonly-l" href="">
                                        <span style="padding-left:15px" class="icon-edit">Edit</span>
                                    </a>
                                <spring:input path="phoneEntity.landline" type="text" id="phone2" class="form-control" placeholder="Phone #"
                                              pattern=".{10,16}" title="10 to 16 characters"
                                              onkeypress="return blockSpecialCharForNumber(event)" readonly="true"/>
                            </div>
                            <spring:errors path="phoneEntity.mobile"/>
                        </div>
                        <div class="row form-group">
                            <div class="col-md-12">
                                <input type="submit" value="Confirm Changes" class="btn btn-primary pill px-4 py-2">
                            </spring:form>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4">
                    <div class="p-4 mb-3 bg-white">
                        <h3 class="h5 text-black mb-3">Profile Image</h3>
                        
                        <form class="form" action="" method="post" id="registrationForm" enctype="multipart/data" >
                            <div class="form-group">

                                <div class="col-xs-12">
                                    <div class="text-center">
                                        <div class="avatar-upload">
                                            <div class="avatar-edit" >
                                                <input type="file" id="imageUpload" name="uploaded" accept="image/png, image/jpeg">
                                                <label for="imageUpload" ></label>
                                            </div>
                                            <div class="avatar-preview">
                                                <div id="imagePreview" style="background-image: url('http://localhost:8080/images/${sessionScope.user.getUserEntity().getProfilePicture()}');">
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </form>
<div class="form-group" id="rating-ability-wrapper">
	     <label class="control-label" for="selected_rating">
	  
	    <input type="hidden" id="selected_rating" name="selected_rating" value="${rating}" >
	    </label>
	 
	    <button type="button" class="btnrating btn btn-default btn-lg rating-dmng" data-attr="1" id="rating-star-1">
	        <i class="icon-star" aria-hidden="true"></i>
	    </button>
	    <button type="button" class="btnrating btn btn-default btn-lg rating-dmng" data-attr="2" id="rating-star-2">
	        <i class="icon-star" aria-hidden="true"></i>
	    </button>
	    <button type="button" class="btnrating btn btn-default btn-lg rating-dmng" data-attr="3" id="rating-star-3">
	        <i class="icon-star" aria-hidden="true"></i>
	    </button>
	    <button type="button" class="btnrating btn btn-default btn-lg rating-dmng" data-attr="4" id="rating-star-4">
	        <i class="icon-star" aria-hidden="true"></i>
	    </button>
	    <button type="button" class="btnrating btn btn-default btn-lg rating-dmng" data-attr="5" id="rating-star-5">
	        <i class="icon-star" aria-hidden="true"></i>
	    </button>
	</div>
                        <spring:form action="${pageContext.request.contextPath}/user/pass.htm" method="post" modelAttribute="userInFormPassword" class="p-3 bg-white">
                            <h4 class="h4 text-black mb-3">Change Password</h4>
                            <div class="row form-group">
                                <div class="col-md-12 mb-3 mb-md-0">
                                    <spring:label path="passwordHash" class="font-weight-bold" for="passwordHash">Password</spring:label>
                                        <a id="switch-readonly-p" href="">
                                            <span style="padding-left:15px" class="icon-edit">Edit</span>
                                        </a>
                                    <spring:input path="passwordHash" title="8 to 50 characters" pattern=".{8,50}" type="password" id="password" class="form-control" readonly="true"
                                                  onkeyup='CheckPassword(); EnablePassword();' placeholder="Password"/>
                                </div>
                                <spring:errors path="passwordHash"/>
                            </div>
                            <div class="row form-group">
                                <div class="col-md-12">
                                    <input type="submit" value="Confirm Changes" class="btn btn-primary pill px-4 py-2">
                                </spring:form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

   
</div>

        <%@include file = "footer.jsp" %>
        <script src="${pageContext.request.contextPath}/dist/js/profile.js" type="text/javascript" ></script>
        <script>jQuery(document).ready(function($){
	    
            
            for (ix = 1; ix <= $("#selected_rating").val(); ++ix) {
                    $("#rating-star-"+ix).toggleClass('btn-success');
                    $("#rating-star-"+ix).toggleClass('btn-default');
                    }

    });
</script>

    </body>
</html>
