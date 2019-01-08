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
                                <div class="d-inline-block d-lg-none ml-md-0 mr-auto py-3"><a href="" class="site-menu-toggle js-menu-toggle text-black"><span class="icon-menu h3"></span></a></div>

                                <ul class="site-menu js-clone-nav d-none d-lg-block">                                    
                                    <li></li>
                                    <li class="has-children">
                                        <a href="${pageContext.request.contextPath}/user/services.htm"><span class="icon-mms mr-3"></span>My Services</a>
                                        <ul class="dropdown arrow-top">
                                            <li><a href="${pageContext.request.contextPath}/user/activeServices.htm"><span class="icon-notifications_active mr-3"></span>Active</a></li>
                                            <li><a href="${pageContext.request.contextPath}/user/closedServices.htm"><span class="icon-notifications_off mr-3"></span>Closed</a></li>
                                        </ul>
                                    </li>
                                    <li class="has-children">
                                        <a href="${pageContext.request.contextPath}/user/account.htm"><span class="icon-user mr-3"></span>Profile</a>
                                        <ul class="dropdown arrow-top">
                                            <li><a href="${pageContext.request.contextPath}/user/logout.htm"><span class="icon-power-off mr-3"></span>Log Out</a></li>
                                        </ul>
                                    </li>
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