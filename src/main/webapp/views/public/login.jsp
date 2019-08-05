<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String path = request.getContextPath();
%>
<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8 no-js"> <![endif]-->
<!--[if IE 9]> <html lang="en" class="ie9 no-js"> <![endif]-->
<!--[if !IE]><!-->
<html lang="en">
<!--<![endif]-->
<!-- BEGIN HEAD -->
<head>
<title><%=com.ecom.extra.Const.SYSTEM_TITLE%></title>
<meta charset="utf-8" />
<meta name="renderer" content="webkit">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta content="width=device-width, initial-scale=1.0" name="viewport" />
<meta http-equiv="Content-type" content="text/html; charset=utf-8">
<meta content="" name="description" />
<meta content="" name="author" />
<!-- BEGIN GLOBAL MANDATORY STYLES -->

<script>
	var ctxRoot = '<%=request.getContextPath()%>';
</script>

<link href="<%=path%>/res/js/Metronic/assets/global/plugins/font-awesome/css/font-awesome.min.css" rel="stylesheet"
	type="text/css" />
<link href="<%=path%>/res/js/Metronic/assets/global/plugins/simple-line-icons/simple-line-icons.min.css" rel="stylesheet"
	type="text/css" />
<link href="<%=path%>/res/js/Metronic/assets/global/plugins/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
<link href="<%=path%>/res/js/Metronic/assets/global/plugins/uniform/css/uniform.default.css" rel="stylesheet" type="text/css" />
<!-- END GLOBAL MANDATORY STYLES -->
<!-- BEGIN PAGE LEVEL STYLES -->
<link href="<%=path%>/res/js/Metronic/assets/admin/pages/css/login.css" rel="stylesheet" type="text/css" />
<!-- END PAGE LEVEL SCRIPTS -->
<!-- BEGIN THEME STYLES -->
<link href="<%=path%>/res/js/Metronic/assets/global/css/components-rounded.css" id="style_components" rel="stylesheet"
	type="text/css" />
<link href="<%=path%>/res/js/Metronic/assets/global/css/plugins.css" rel="stylesheet" type="text/css" />
<link href="<%=path%>/res/js/Metronic/assets/admin/layout/css/layout.css" rel="stylesheet" type="text/css" />
<link href="<%=path%>/res/js/Metronic/assets/admin/layout/css/custom.css" rel="stylesheet" type="text/css" />

<link href="<%=path%>/res/js/Metronic/assets/admin/layout3/css/themes/red-intense.css" rel="stylesheet" type="text/css" />
<!-- END THEME STYLES -->
<link href="<%=path%>/res/css/ek.css" rel="stylesheet" type="text/css">

<!-- BEGIN JAVASCRIPTS(Load javascripts at bottom, this will reduce page load time) -->
<!-- BEGIN CORE PLUGINS -->
<!--[if lt IE 9]>
<script src="<%=path%>/res/js/Metronic/assets/global/plugins/respond.min.js"></script>
<![endif]-->
<script src="<%=path%>/res/js/Metronic/assets/global/plugins/jquery.min.js" type="text/javascript"></script>
<script src="<%=path%>/res/js/Metronic/assets/global/plugins/jquery-migrate.min.js" type="text/javascript"></script>
<script src="<%=path%>/res/js/Metronic/assets/global/plugins/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
<script src="<%=path%>/res/js/Metronic/assets/global/plugins/jquery.blockui.min.js" type="text/javascript"></script>
<!-- END CORE PLUGINS -->
<!-- BEGIN PAGE LEVEL SCRIPTS -->
<script src="<%=path%>/res/js/Metronic/assets/global/scripts/metronic.js" type="text/javascript"></script>
<script src="<%=path%>/res/js/Metronic/assets/admin/layout/scripts/layout.js" type="text/javascript"></script>
<!-- END PAGE LEVEL SCRIPTS -->

<script type="text/javascript" src="<%=path%>/res/js/jquery/jquery.form.js"></script>
<script type="text/javascript" src="<%=path%>/views/public/icn/login.js?a=3"></script>

<!-- END JAVASCRIPTS -->

</head>
<!-- END HEAD -->
<!-- BEGIN BODY -->
<body class="login">
	<!-- BEGIN SIDEBAR TOGGLER BUTTON -->
	<div class="menu-toggler sidebar-toggler"></div>
	<!-- END SIDEBAR TOGGLER BUTTON -->
	<!-- BEGIN LOGO -->
	<div class="logo">
		<img src="<%=path%>/res/images/ecom4.png" alt="" />
	</div>
	<!-- END LOGO -->
	<!-- BEGIN LOGIN -->
	<div class="content">
		<!-- BEGIN LOGIN FORM -->
		<form class="login-form" action="<%=request.getContextPath()%>/public/Login" method="post" enctype="multipart/form-data">
			<h3 class="form-title">Sign In</h3>
			<div class="alert alert-danger display-hide">
				<button class="close" data-close="alert"></button>
				<span id="errorContain"> Enter any username and password. </span>
			</div>
			<div class="form-group">
				<!--ie8, ie9 does not support html5 placeholder, so we just show field title for that-->
				<label class="control-label visible-ie8 visible-ie9">Username</label> <input id="username"
					class="form-control form-control-solid placeholder-no-fix" type="text" autocomplete="off" placeholder="Username"
					name="username" />
			</div>
			<div class="form-group">
				<label class="control-label visible-ie8 visible-ie9">Password</label> <input id="password"
					class="form-control form-control-solid placeholder-no-fix" type="password" autocomplete="off" placeholder="Password"
					name="password" />
			</div>
			
			<div class="form-group captchaContain" <%if("false".equals(request.getAttribute("_captcha"))){ %>style="display:none"<%}%> >
				<label class="control-label visible-ie8 visible-ie9">验证码</label> <input type="text" name="captcha"
					style="width: 140px; display: inline; height: 32px" placeholder="请输入验证码"
					class="form-control form-control-solid placeholder-no-fix">&nbsp;&nbsp;<img src="<%=path%>/public/captcha-image"
					name="kaptchaImage" id="kaptchaImage" style="width: 120px; height: 32px; vertical-align: bottom" />
			</div>
			
			<hr class="more" style="display: none; border-top: 1px solid #DDE3EC;" />
			<div class="form-group more" style="display: none;">
				<label class="control-label visible-ie8 visible-ie9">选择密钥</label> <input type="file" id="keyE1" name="keyE1"
					class="form-control form-control-solid placeholder-no-fix" autocomplete="off" placeholder="选择密钥" />
			</div>
			<div class="form-group more" style="display: none;">
				<label class="control-label visible-ie8 visible-ie9">KEY ALIAS</label> <input type="text" name="keyAlias"
					class="form-control form-control-solid placeholder-no-fix" autocomplete="off" placeholder="KEY ALIAS" />
			</div>
			<div class="form-group more" style="display: none;">
				<label class="control-label visible-ie8 visible-ie9">KEY PASSWORD</label> <input type="password" name="keyPassword"
					class="form-control form-control-solid placeholder-no-fix" autocomplete="off" placeholder="KEY PASSWORD" />
			</div>
			<div class="form-actions">
				<button type="submit" class="btn btn-success ">Login</button>
			</div>
		</form>
		<!-- END LOGIN FORM -->
	</div>
	<!-- END LOGIN -->
</body>
<!-- END BODY -->
</html>