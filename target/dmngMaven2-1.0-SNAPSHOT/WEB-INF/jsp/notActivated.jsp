<html>
<head>
    <title>Service Finder &mdash; DMNG team</title>
    <%@include file = "newHeader.jsp" %>
</head>
<body>
<div class="site-wrap">
    <%@include file = "navbarLogin.jsp" %>
    <div class="site-blocks-cover overlay" style="background-image: url('${pageContext.request.contextPath}/dist/images/hero_1.jpg');" data-aos="fade" data-stellar-background-ratio="0.5">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-12" data-aos="fade">
                    <h1>Your account has not been activated.</h1>
                    <h1>Check your inbox for an email from us to activate your account.</h1>
                    <h1>If you haven't received it, please click the following button to resend it</h1>
                    <div class="row mb-3">
                        <div class="col-md-3">
                            <a href="${pageContext.request.contextPath}/verification/newActivationLink.htm">
                                <button class="btn btn-search btn-primary btn-block">Activate</button>
                            </a>
                        </div>
                    </div>
                    <div class="row mb-3">
                        <div class="col-md-3">
                            <a href="${pageContext.request.contextPath}/home/initialForm.htm">
                                <button class="btn btn-search btn-primary btn-block">Log In</button>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<%@include file = "footer.jsp" %>
</body>
</html>