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
                    <h1>Account with e-mail:${userEmail} is already activated</h1>
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
</body>
</html>