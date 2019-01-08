<html>
<head>
    <title>Service Finder &mdash; DMNG team</title>
    <%@include file="newHeader.jsp" %>
</head>
<body>
<div class="site-wrap">
    <%@include file="navbarLogin.jsp" %>
    <div class="site-blocks-cover overlay"
         style="background-image: url('${pageContext.request.contextPath}/dist/images/hero_1.jpg');" data-aos="fade"
         data-stellar-background-ratio="0.5">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-12" data-aos="fade">
                    <h1>Input your email to send a new activation link</h1>
                        <spring:form method="post" action="${pageContext.request.contextPath}/verification/sendNewLink.htm"
                                     modelAttribute="user">
                            <div class="row mb-3">
                                <div class="col-md-9">
                                    <div class="row">
                                        <div class="col-md-6 mb-3 mb-md-0">
                                            <spring:input path="email" id="email" type="email"
                                                          class="mr-3 form-control border-0 px-4" required="required"/>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <button class="btn btn-search btn-primary btn-block" id="actionLogin">Submit
                                    </button>
                                </div>
                            </div>
                        </spring:form>
                </div>
            </div>
        </div>
    </div>
    <%@include file="footer.jsp" %>
</body>
</html>