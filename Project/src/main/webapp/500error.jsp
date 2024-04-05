<!DOCTYPE html>
<%@ page isErrorPage="true" %>
<% response.setStatus(200); %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>
    <style>
        @import url('https://fonts.googleapis.com/css?family=Roboto+Mono');

        /* helper */
        .center-xy {
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            position: absolute;
        }

        html, body {
            font-family: 'Roboto Mono', monospace;
            font-size: 16px;
            background-color: #000;
            color: #fff;
            margin: 0;
            padding: 0;
            width: 100%;
            height: 100%;
        }

        .container {
            position: relative;
            width: 100%;
            height: 100%;
        }

        .copy-container {
            text-align: center;
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
        }

        p {
            color: #fff;
            font-size: 24px;
            letter-spacing: .2px;
            margin: 0;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="copy-container">
        <p id="animatedText"></p>
    </div>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        var text = "Sorry 500, It's me not You .";
        var i = 0;
        var speed = 150; // Speed in milliseconds

        function typeWriter() {
            if (i < text.length) {
                document.getElementById("animatedText").innerHTML += text.charAt(i);
                i++;
                setTimeout(typeWriter, speed);
            }
        }

        typeWriter();
    });
</script>
</body>
</html>
