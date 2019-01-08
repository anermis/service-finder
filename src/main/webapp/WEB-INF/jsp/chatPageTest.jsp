<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css"
          href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <style>
        .main-section {
            border: 1px solid #000;
        }

        .left-sidebar {
            background-color: #3A3A3A;
            padding: 0px;
        }

        .chat-left-img, .chat-left-detail {
            float: left;
        }

        .left-chat {
            overflow-y: scroll;
        }

        .left-chat ul {
            overflow: hidden;
            padding: 0px;
        }

        .left-chat ul li {
            list-style: none;
            width: 100%;
            float: left;
            margin: 10px 0px 8px 15px;
        }

        .chat-left-img img {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            text-align: left;
            float: fixed;
            border: 3px solid #6B6F79;
        }

        .chat-left-detail {
            margin-left: 10px;
        }

        .chat-left-detail p {
            margin: 0px;
            color: #fff;
            padding: 7px 0px 0px;
        }

        .chat-left-detail span {
            color: #B8BAC3;
        }

        .chat-left-detail span i {
            color: #86BB71;
            font-size: 10px;
        }

        .chat-left-detail .orange {
            color: #E38968;
        }

        .right-sidebar {
            border-left: 2px solid #000;
        }

        .right-header {
            border-bottom: 2px solid #000;
            margin: 0px;
            padding: 0px;
        }

        .right-header-img img {
            width: 50px;
            height: 50px;
            float: left;
            border-radius: 50%;
            border: 3px solid #61BC71;
            margin-right: 10px;
        }

        .right-header {
            padding: 20px;
            height: 90px;
            background-color: #3A3A3A;
        }

        .right-header-detail p {
            margin: 0px;
            color: #fff;
            font-weight: bold;
            padding-top: 5px;
        }

        .right-header-detail span {
            color: #9FA5AF;
            font-size: 12px;
        }

        .rightside-left-chat, .rightside-right-chat {
            float: left;
            width: 80%;
            position: relative;
        }

        .rightside-right-chat {
            float: right;
            margin-right: 35px;
        }

        .right-header-contentChat {
            overflow-y: scroll;
            background-color: #FFFFFF;
            position: relative;
        }

        .right-header-contentChat ul li {
            list-style: none;
            margin-top: 20px;
        }

        .right-header-contentChat .rightside-left-chat p, .right-header-contentChat .rightside-right-chat p {
            background-color: #7e7e7e;
            padding: 15px;
            border-radius: 8px;
            color: #fff;
        }

        .right-header-contentChat .rightside-right-chat p {
            background-color: #86BB71;
        }

        .rightside-left-chat .fa {
            color: #7e7e7e;
        }

        .rightside-right-chat .fa {
            color: #86BB71;
        }

        .right-chat-textbox {
            padding: 15px 30px;
            width: 100%;
            background-color: #3A3A3A;
        }

        .right-chat-textbox input {
            width: 88%;
            height: 40px;
            color: #9FA5AF;
            border-radius: 5px;
            padding: 0px 10px;
            border: 1px solid #c1c1c1;
        }

        .right-chat-textbox a i {
            color: #3A3A3A;
            text-align: center;
            height: 40px;
            width: 40px;
            background-color: #fff;
            border-radius: 50%;
            padding: 12px 0px;
            margin-left: 20px;
        }

        .rightside-left-chat span i, .rightside-right-chat span i {
            color: #86BB71;
            font-size: 12px;
        }

        .rightside-right-chat span i {
            color: #94C2ED;
        }

        .rightside-right-chat span {
            float: right;
        }

        .rightside-right-chat span small, .rightside-left-chat span small {
            color: #BDBDC2;
        }

        .rightside-left-chat:before {
            content: " ";
            position: absolute;
            top: 14px;
            left: 15px;
            bottom: 150px;
            border: 15px solid transparent;
            border-bottom-color: #7d7d7d;
            z-index: 1;
        }

        .rightside-right-chat:before {
            content: " ";
            position: absolute;
            top: 14px;
            right: 15px;
            bottom: 150px;
            border: 15px solid transparent;
            border-bottom-color: #86BB71;
        }

        @media only screen and (max-width: 320px) {
            .main-section {
                display: none;
            }
        }
    </style>
</head>
<body>
<div class="container main-section">
    <div class="row">
        <div class="col-md-3 col-sm-3 col-xs-12 left-sidebar">
            <a href="${pageContext.request.contextPath}/home/initialForm.htm" class="btn btn-search btn-primary btn-block" style="padding: 20px; color: white; height: 90px; font-size: 30px; line-height: 50px; background-color: green; font-weight: 500;
">Home</a>
            <div class="left-chat">
                <ul>
                    <c:forEach items="${profs}" var="item">
                        <li>
                            <a href="${item.id}.htm">
                                <div class="chat-left-img">
                                    <img src="/images/${item.profilePicture}">
                                </div>
                                <div class="chat-left-detail">
                                    <p>${item.firstName} ${item.lastName}</p>
                                </div>
                            </a>
                        </li>
                    </c:forEach>
                </ul>
            </div>
        </div>
        <div class="col-md-9 col-sm-9 col-xs-12 right-sidebar">
            <div class="row">
                <div class="col-md-12 right-header">
                    <div class="right-header-img">
                        <img class="rounded-circle" src="/images/${sessionScope.user.getUserEntity().getProfilePicture()}">
                    </div>
                    <div class="right-header-detail">
                        <p>${sessionUser.userEntity.firstName} ${sessionUser.userEntity.lastName}</p>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-12 right-header-contentChat" id="test2">
                    <ul id="msgContainer">
                        <c:forEach items="${currentSessionsMessages}" var="item">
                            <c:choose>
                                <c:when test="${item.senderId==sessionUser.userEntity.id}">
                                    <li>
                                        <div class="rightside-right-chat test">
                                    <span>
                                        <small>${item.timeSent.toLocaleString()}</small>
                                        ${sessionUser.userEntity.firstName} ${sessionUser.userEntity.lastName}
                                        <i class="fa fa-circle" aria-hidden="true"></i>
                                              </span><br><br>
                                            <p>${item.data}</p>
                                        </div>
                                    </li>
                                </c:when>
                                <c:otherwise>
                                    <li>
                                        <div class="rightside-left-chat test">
                                <span>
                                    <i class="fa fa-circle" aria-hidden="true"></i>
                                    ${currentSessionRecipient.userEntity.firstName} ${currentSessionRecipient.userEntity.lastName}
                                    <small>${item.timeSent.toLocaleString()}</small>
                                </span><br><br>
                                            <p>${item.data}</p>
                                        </div>
                                    </li>
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>
                    </ul>
                </div>
            </div>
            <a href="#" onclick="proxy.login_keyup(event)" id="myA" hidden>Start chat</a>
            <div class="row" id="msgPanel">
                <div id="msgContainer2">
                    <div class="col-md-12 right-chat-textbox">
                        <input type="text" id="txtMsg" onkeyup="proxy.sendMessage_keyup(event)"><a href="#"
                                                                                                   onclick="proxy.sendMessage_button()"><i
                            class="fa fa-arrow-right" aria-hidden="true"></i></a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    var goToBottomOfChat = function () {
        var objDiv = document.getElementById("test2");
        objDiv.scrollTop = objDiv.scrollHeight;
    };

    var CreateProxy = function (wsUri) {
        var websocket = null;
        var elements = null;

        var displayMessage = function (msgJSON) {
            var msg = JSON.parse(msgJSON);
            var txt;
            if (msg.senderId ===${sessionUser.userEntity.id}) {
                txt = "<li>\n" +
                    "                                        <div class=\"rightside-right-chat test\">\n" +
                    "                                    <span>\n" +
                    "                                        <small>" + moment().format('ll') + " " + moment().format('LTS') + "</small>\n" +
                    "                                        ${sessionUser.userEntity.firstName} ${sessionUser.userEntity.lastName}\n" +
                    "                                        <i class=\"fa fa-circle\" aria-hidden=\"true\"></i>\n" +
                    "                                              </span><br><br>\n" +
                    "                                            <p>" + msg.data + "</p>\n" +
                    "                                        </div>\n" +
                    "                                    </li>";
            } else {
                txt = "<li>\n" +
                    "                                        <div class=\"rightside-left-chat test\">\n" +
                    "                                <span>\n" +
                    "                                    <i class=\"fa fa-circle\" aria-hidden=\"true\"></i>\n" +
                    "                                    ${currentSessionRecipient.userEntity.firstName} ${currentSessionRecipient.userEntity.lastName}\n" +
                    "                                    <small>" + moment().format('ll') + " " + moment().format('LTS') + "</small>\n" +
                    "                                </span><br><br>\n" +
                    "                                            <p>" + msg.data + "</p>\n" +
                    "                                        </div>\n" +
                    "                                    </li>";
            }

            $('#msgContainer').append(txt);
            goToBottomOfChat();
        };

        var clearMessage = function () {
            elements.msgContainer.innerHTML = '';
        };

        return {
            login: function () {
                // Initiate the socket and set up the events
                if (websocket == null) {
                    websocket = new WebSocket(wsUri);

                    websocket.onopen = function () {
                        var message = {messageType: 'LOGIN', data: "login"};
                        websocket.send(JSON.stringify(message));
                    };
                    websocket.onmessage = function (e) {
                        displayMessage(e.data);
                    };
                    websocket.onerror = function (e) {
                    };
                    websocket.onclose = function (e) {
                        websocket = null;
                        clearMessage();
                    };
                }
            },
            sendMessage: function () {

                if (websocket != null && websocket.readyState == 1) {
                    var input = elements.txtMsg.value.trim();
                    if (input == '') {
                        return;
                    }
                    elements.txtMsg.value = '';
                    var message = {
                        messageType: 'MESSAGE',
                        data: input,
                        senderId: ${sessionUser.userEntity.id},
                        timeSent: moment()
                    };
                    websocket.send(JSON.stringify(message));
                }
            },
            login_keyup: function (e) {
                this.login();
            },
            sendMessage_keyup: function (e) {
                if (e.keyCode == 13) {
                    this.sendMessage();
                }
            },
            sendMessage_button: function () {
                this.sendMessage();
            },
            logout: function () {
                if (websocket != null && websocket.readyState == 1) {
                    websocket.close();
                }
            },
            initiate: function (e) {
                elements = e;
            }
        }
    };
</script>
<script src="${pageContext.request.contextPath}/dist/js/moment-with-locales.js" type="text/javascript"></script>
<script>

    var proxy = CreateProxy("ws://localhost:8080/dmngMaven2_war_exploded/chat");

    document.addEventListener("DOMContentLoaded", function (event) {
        proxy.initiate({
            msgPanel: document.getElementById('msgPanel'),
            txtMsg: document.getElementById('txtMsg'),
            msgContainer: document.getElementById('msgContainer')
        });
    });

    $(document).ready(function () {
        var height = $(window).height();
        $('.left-chat').css('height', (height - 92) + 'px');
        $('.right-header-contentChat').css('height', (height - 163) + 'px');
        goToBottomOfChat();
        document.getElementById('myA').dispatchEvent(new MouseEvent("click"));
    });
</script>
</body>
</html>