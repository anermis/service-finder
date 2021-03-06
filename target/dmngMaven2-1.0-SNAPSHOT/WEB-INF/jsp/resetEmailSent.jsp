<%--
  Created by IntelliJ IDEA.
  User: tsamo
  Date: 07-Nov-18
  Time: 1:25 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Error</title>
    <style>
        body {
            background: #f5f5f5;
        }

        h5 {
            font-weight: 400;
        }

        .form-container {
            padding: 40px;
            padding-top: 10px;
        }

        .home {
            background-color : red;
            color: white;
            padding: 10px 20px;
            border-radius: 4px;
            border-color: red;
        }

        #homebutton {
            position: fixed;
            bottom: -4px;
            right: 10px;
        }

    </style>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/dist/css/materialize.min.css">
    <script src="${pageContext.request.contextPath}/dist/js/jquery-3.3.1.min.js"></script>
    <script src="${pageContext.request.contextPath}/dist/js/materialize.min.js"></script>
</head>
<body>
<div id="login" class="col s12">
    <div class="form-container">
        <h4 class="red-text center">
            <pre>
            An e-mail has been sent to ${userEmail} with further instructions,
            on how to reset your password.

            With regards,
            The Awesome Inc. Team.
        </pre>
        </h4>
    </div>
</div>
<div id="homebutton">
    <form action="${pageContext.request.contextPath}/home/initialForm.htm">
        <button class="home">Home</button>
    </form>
</div>
</body>
</html>
