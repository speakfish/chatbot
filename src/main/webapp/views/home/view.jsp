<%@page import="com.ecom.extra.Const"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8 no-js"> <![endif]-->
<!--[if IE 9]> <html lang="en" class="ie9 no-js"> <![endif]-->
<!--[if !IE]><!-->
<html lang="en">
<!--<![endif]-->
<head>
<%@include file="/include/base2.jsp"%>
<link href="<%=path%>/res/js/Metronic/assets/global/plugins/bootstrap-datepicker/css/bootstrap-datepicker3.min.css"
	rel="stylesheet" type="text/css" />
<link href="<%=path%>/res/js/Metronic/assets/global/plugins/icheck/skins/all.css" rel="stylesheet" />

<link rel="stylesheet" type="text/css" media="screen" href="<%=path%>/res/js/zTree/css/zTreeStyle/zTreeStyle.css" />
<script type="text/javascript" src="<%=path%>/res/js/zTree/js/jquery.ztree.all-3.5.js"></script>

<script src="<%=path%>/res/js/echarts/echarts-all.js" type="text/javascript"></script>
<script src="<%=path%>/res/js/Metronic/assets/global/plugins/bootstrap-datepicker/js/bootstrap-datepicker.min.js"
	type="text/javascript"></script>
<script src="<%=path%>/res/js/Metronic/assets/global/plugins/icheck/icheck.min.js"></script>

<link href="<%=path%>/res/js/Metronic/assets/global/plugins/fancybox/source/jquery.fancybox.css" rel="stylesheet"
	type="text/css" />
<script src="<%=path%>/res/js/Metronic/assets/global/plugins/fancybox/source/jquery.fancybox.pack.js"></script>
<script src="<%=path%>/views/home/icn/view.js?a=1" type="text/javascript"></script>
<%
	com.ecom.permission.entity.SysUser _user = (com.ecom.permission.entity.SysUser) session.getAttribute(Const.SESSION_KEY_USER);
%>
<script id="tmpl-select" type="text/x-jsrender">
	<option value='{{>value}}' {{>selected}}>{{>text}}</option>
</script>

</head>
<!-- BEGIN BODY -->
<body>
	<div class="modal fade" id="messageDialog" tabindex="-1" role="basic" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<form class="messageForm" action="<%=path%>/message/update" method="post">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
						<h4 class="modal-title">发布留言</h4>
					</div>
					<div class="modal-body">
						<textarea name="message" class="form-control todo-taskbody-taskdesc" rows="8" maxlength=200
							placeholder="Description..." autofocus=true></textarea>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn default" data-dismiss="modal">Close</button>
						<button type="button" class="btn blue messageSubmitBtn">Save changes</button>
					</div>
				</form>
			</div>
		</div>
	</div>
	<div class="page-header">
		<div class="page-header-top">
			<div class="container">
				<div class="page-logo">
					<img src="<%=path%>/res/images/ecom4.png" alt="logo" class="logo-default">
				</div>
				<a href="javascript:;" class="menu-toggler"></a>
				<div class="top-menu">
					<ul class="nav navbar-nav pull-right">
						<!-- BEGIN USER LOGIN DROPDOWN -->
						<li class="dropdown dropdown-user dropdown-dark"><a href="javascript:;" class="dropdown-toggle"
							data-toggle="dropdown" data-hover="dropdown" data-close-others="true"> <img alt="" class="img-circle"
								src="<%=path%>/person/head-pic/s/<%=_user.getLoginName()%>"><span class="username username-hide-mobile"><%=_user.getName()%></span>
						</a>
							<ul class="dropdown-menu dropdown-menu-default">
								<li><a href="###" onclick="ek.showCenter('900-001')"> <i class="icon-user"></i> My Profile
								</a></li>
								<!-- <li><a href="page_calendar.html"> <i class="icon-calendar"></i> My Calendar
								</a></li> -->
								<li class="divider"></li>
								<li><a href="<%=path%>/logout"> <i class="icon-key"></i> Log Out
								</a></li>
							</ul></li>
					</ul>
				</div>
			</div>
		</div>
		<div class="page-header-menu">
			<div class="container">
				<!-- BEGIN HEADER SEARCH BOX -->
				<!-- <form class="search-form" action="extra_search.html" method="GET">
					<div class="input-group">
						<input type="text" class="form-control" placeholder="Search" name="query"><span class="input-group-btn">
							<a href="javascript:;" class="btn submit"><i class="icon-magnifier"></i></a>
						</span>
					</div>
				</form> -->
				<div class="hor-menu ">
					<ul class="nav navbar-nav menuContain">
					</ul>
				</div>
				<!-- END MEGA MENU -->
			</div>
		</div>
		<!-- END HEADER MENU -->
	</div>
	<!-- END HEADER -->
	<!-- BEGIN PAGE CONTAINER -->
	<div class="page-container">
		<!-- BEGIN PAGE HEAD -->
		<!-- 	<div class="page-head">
			<div class="container">
				BEGIN PAGE TITLE
				<div class="page-title">
					<h1>
						<span class="pageTitle"></span> <small></small>
					</h1>
				</div>
				END PAGE TITLE
				<div class="page-toolbar">
					BEGIN THEME PANEL
					<div class="btn-group btn-theme-panel open">
						<div class="rateit" data-rateit-resetable="false" data-rateit-ispreset="true" data-rateit-min="0" data-rateit-max="5"></div>
					</div>
					END THEME PANEL
				</div>
			</div>
		</div> -->
		<!-- END PAGE HEAD -->
		<!-- BEGIN PAGE CONTENT -->
		<div class="page-content">
			<div class="container">
				<!-- BEGIN PAGE BREADCRUMB -->
				<!-- <ul class="page-breadcrumb breadcrumb">
					<li><a href="#">Home</a><i class="fa fa-circle"></i></li>
					<li class="active">Pages</li>
				</ul> -->
				<!-- END PAGE BREADCRUMB -->
				<!-- BEGIN PAGE CONTENT INNER -->
				<div>
					<div class="row margin-top-10">
						<div class="col-md-12">
							<!-- BEGIN PROFILE SIDEBAR -->
							<!-- END BEGIN PROFILE SIDEBAR -->
							<div class="profile-content pageContent"></div>
						</div>
					</div>
				</div>
				<!-- END PAGE CONTENT INNER -->
			</div>
		</div>
		<!-- END PAGE CONTENT -->
	</div>
	<!-- END PAGE CONTAINER -->
	<!-- BEGIN FOOTER -->
	<div class="page-footer">
		<div class="container">2019 &copy; botchat by sliu.</div>
	</div>
	<div class="scroll-to-top">
		<i class="icon-arrow-up"></i>
	</div>
	<!-- END FOOTER -->
</body>
<!-- END BODY -->
</html>