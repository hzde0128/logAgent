<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>登录</title>
        <link rel="stylesheet" type="text/css" href="/static/css/reset.css">
        <link rel="stylesheet" type="text/css" href="/static/css/main.css">
</head>
<body>
    <div class="login_logo">
        <img src="/static/img/logo.png" alt="">
    </div>
    <form  class="login_form"  name = "login" method="post" action="/">
        <h1 class="login_title">用户登录</h1>
        <input type="text"  class="input_txt" name = "userName" value="admin">
        <input type="password" name = "password"  class="input_txt" value="admin">
        <div class="remember"><input type="checkbox" name="remember" ><label>记住用户名</label></div>
        <input type="submit" value="登 录" class="input_sub">
    </form>
    <div class="login_bg"></div>
</body>
</html>
