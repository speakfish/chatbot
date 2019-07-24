<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String path = request.getContextPath();
%>
<meta charset="utf-8" />
<title><%=com.ecom.extra.Const.SYSTEM_TITLE%></title>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="renderer" content="webkit">
<meta content="width=device-width, initial-scale=1.0" name="viewport" />
<meta http-equiv="Content-type" content="text/html; charset=utf-8">
<meta content="" name="description" />
<meta content="" name="author" />
<!-- BEGIN GLOBAL MANDATORY STYLES -->
<link href="<%=path%>/res/js/Metronic/assets/global/plugins/font-awesome/css/font-awesome.min.css" rel="stylesheet"
	type="text/css">
<link href="<%=path%>/res/js/Metronic/assets/global/plugins/simple-line-icons/simple-line-icons.min.css" rel="stylesheet"
	type="text/css">
<link href="<%=path%>/res/js/Metronic/assets/global/plugins/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css">
<link href="<%=path%>/res/js/Metronic/assets/global/plugins/uniform/css/uniform.default.css" rel="stylesheet" type="text/css">
<!-- END GLOBAL MANDATORY STYLES -->
<!-- BEGIN PAGE LEVEL STYLES -->
<link href="<%=path%>/res/js/Metronic/assets/global/plugins/bootstrap-fileinput/bootstrap-fileinput.css" rel="stylesheet"
	type="text/css" />
<link href="<%=path%>/res/js/Metronic/assets/admin/pages/css/profile.css" rel="stylesheet" type="text/css" />
<link href="<%=path%>/res/js/Metronic/assets/admin/pages/css/tasks.css" rel="stylesheet" type="text/css" />
<link href="<%=path%>/res/js/Metronic/assets/admin/pages/css/timeline.css" rel="stylesheet" type="text/css" />
<link href="<%=path%>/res/js/Metronic/assets/global/plugins/bootstrap-toastr/toastr.min.css" rel="stylesheet" type="text/css" />
<link href="<%=path%>/res/js/Metronic/assets/global/plugins/datatables/plugins/bootstrap/dataTables.bootstrap.css"
	rel="stylesheet" type="text/css" />
<!-- END PAGE LEVEL STYLES -->
<!-- BEGIN THEME STYLES -->
<link href="<%=path%>/res/js/Metronic/assets/global/css/components-rounded.css" id="style_components" rel="stylesheet"
	type="text/css">
<link href="<%=path%>/res/js/Metronic/assets/global/css/plugins.css" rel="stylesheet" type="text/css">
<link href="<%=path%>/res/js/Metronic/assets/admin/layout3/css/layout.css" rel="stylesheet" type="text/css">
<link href="<%=path%>/res/js/Metronic/assets/admin/layout3/css/themes/blue-steel.css" rel="stylesheet" type="text/css"
	id="style_color">
<link href="<%=path%>/res/js/Metronic/assets/admin/layout3/css/custom.css" rel="stylesheet" type="text/css">
<link href="<%=path%>/res/js/Metronic/assets/global/plugins/icheck/skins/all.css" rel="stylesheet" />

<!-- END THEME STYLES -->
<link rel="shortcut icon" href="/res/images/favicon.ico" />
<link href="<%=path%>/res/css/ek.css" rel="stylesheet" type="text/css">
<!-- BEGIN JAVASCRIPTS(Load javascripts at bottom, this will reduce page load time) -->
<!-- BEGIN CORE PLUGINS -->
<!--[if lt IE 9]>
<script src="<%=path%>/res/js/Metronic/assets/global/plugins/respond.min.js"></script>
<![endif]-->

<script type="text/javascript">
var ctxRoot = '<%=request.getContextPath()%>';
var publicRoot = '<%=path%>';
	var templet_flag = 0;
	var action_uri = "";
</script>

<script src="<%=path%>/res/js/jquery/jquery-1.11.0.min.js" type="text/javascript"></script>
<script src="<%=path%>/res/js/Metronic/assets/global/plugins/jquery-migrate.min.js" type="text/javascript"></script>
<!-- IMPORTANT! Load jquery-ui.min.js before bootstrap.min.js to fix bootstrap tooltip conflict with jquery ui tooltip -->
<script src="<%=path%>/res/js/Metronic/assets/global/plugins/jquery-ui/jquery-ui.min.js" type="text/javascript"></script>
<script src="<%=path%>/res/js/Metronic/assets/global/plugins/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
<script src="<%=path%>/res/js/Metronic/assets/global/plugins/bootstrap-hover-dropdown/bootstrap-hover-dropdown.min.js"
	type="text/javascript"></script>
<script src="<%=path%>/res/js/Metronic/assets/global/plugins/jquery-slimscroll/jquery.slimscroll.min.js"
	type="text/javascript"></script>
<script src="<%=path%>/res/js/Metronic/assets/global/plugins/jquery.blockui.min.js" type="text/javascript"></script>
<script src="<%=path%>/res/js/Metronic/assets/global/plugins/jquery.cokie.min.js" type="text/javascript"></script>
<script src="<%=path%>/res/js/Metronic/assets/global/plugins/uniform/jquery.uniform.min.js" type="text/javascript"></script>
<!-- END CORE PLUGINS -->
<!-- BEGIN PAGE LEVEL PLUGINS -->
<script src="<%=path%>/res/js/Metronic/assets/global/plugins/bootstrap-fileinput/bootstrap-fileinput.js"
	type="text/javascript"></script>
<script src="<%=path%>/res/js/Metronic/assets/global/plugins/jquery.sparkline.min.js" type="text/javascript"></script>
<script src="<%=path%>/res/js/Metronic/assets/global/plugins/bootstrap-toastr/toastr.min.js"></script>
<script src="<%=path%>/res/js/Metronic/assets/global/plugins/icheck/icheck.min.js"></script>
<script src="<%=path%>/res/js/Metronic/assets/global/scripts/metronic.js" type="text/javascript"></script>
<script src="<%=path%>/res/js/Metronic/assets/admin/layout3/scripts/layout.js" type="text/javascript"></script>


<link rel="stylesheet" type="text/css" href="<%=path%>/res/js/v6/select24/css/select2.css">
<script src="<%=path%>/res/js/v6/select24/js/select2.full.js" type="text/javascript"></script>
<!-- END PAGE LEVEL SCRIPTS -->
<script type="text/javascript" src="<%=path%>/res/js/jquery/jquery.form.js"></script>
<script type="text/javascript" src="<%=path%>/res/js/jquery/jsrender.min.js"></script>

<script src="<%=path%>/res/js/v6/ek.js?v=<%=com.ecom.core.CoreConst.APP_VERSION%>" type="text/javascript"></script>
<script src="<%=path%>/res/js/v6/ek-widget.js?v=<%=com.ecom.core.CoreConst.APP_VERSION%>" type="text/javascript"></script>
<!-- END JAVASCRIPTS -->

<script id="tmpl-head-menu" type="text/x-jsrender">
<li class="menu-dropdown classic-menu-dropdown "><a {{if type==2}}href="<%=path%>{{>text}}" target="_blank"{{else}}href="javascript:;" onclick="ek.showCenter('{{:code}}')" {{/if}}  {{if isParent==true}}data-hover="megamenu-dropdown" data-close-others="true" data-toggle="dropdown"{{/if}}>
		{{:name}} {{if isParent==true}}<i class="fa fa-angle-down"></i>{{/if}}
</a> {{if isParent==true}}
	<ul class="dropdown-menu pull-left">
{{for children}}
		<li><a {{if type==2}}href="<%=path%>{{>text}}" target="_blank"{{else}}href="javascript:;" onclick="ek.showCenter('{{:code}}')" {{/if}} > {{:name}}</a></li>
{{/for}}
	</ul> {{/if}}</li>
</script>

<script id="tmpl-grid-page" type="text/x-jsrender">
			<div class="col-md-5 col-sm-12">
				<div class="dataTables_info pageResult">Showing {{:from}} to {{:to}} of {{:totalRecord}} entries</div>
			</div>
			<div class="col-md-7 col-sm-12">
				<div class="dataTables_paginate paging_bootstrap_full_number pull-right">
					<ul class="pagination" style="visibility: visible;">
						<li class="prev {{>b1}}"><a href="#" title="First" {{if !b1}} onclick="ek.doChangePage(this,1)"{{/if}}><i class="fa fa-angle-double-left"></i></a></li>
						<li class="prev {{>b2}}"><a href="#" title="Prev" {{if !b2}} onclick="ek.doChangePage(this,{{>prevPage}})"{{/if}}><i class="fa fa-angle-left"></i></a></li>
						{{for pages}}
							<li class="{{>active}}"><a href="###"  onclick="ek.doChangePage(this,{{>index}})">{{>index}}</a></li>
						{{/for}}
						<li class="next {{>b3}}"><a href="#" title="Next"  {{if !b3}} onclick="ek.doChangePage(this,{{>nextPage}})"{{/if}}><i class="fa fa-angle-right"></i></a></li>
						<li class="next {{>b4}}"><a href="#" title="Last" {{if !b4}}  onclick="ek.doChangePage(this,{{>totalPage}})"{{/if}}><i class="fa fa-angle-double-right"></i></a></li>
					</ul>
				</div>
			</div>
</script>
<script id="tmpl-grid-rows-select" type="text/x-jsrender">
<div class="row ekGridRowsSelectContain">
	<div class="col-md-6 col-sm-12">
		<div class="dataTables_length">
			<label> <select class="form-control input-xsmall input-inline ekGridRowsSelectBtn">
				{{for rows}}
					<option value="{{>row}}">{{>row}}</option>
				{{/for}}
			</select> {{>label}}
			</label>
		</div>
	</div>
</div>
</script>

<script id="tmpl-icheck" type="text/x-jsrender">
<label><input type="checkbox" name="{{>name}}" class="icheck" value="{{>value}}" checked="{{>checked}}">{{>text}}</label>
</script>

<script id="tmpl-multi-select" type="text/x-jsrender">
	<div class="icheck-inline">
	{{for data}}
			<input type="{{:#parent.parent.data.type}}" name="{{>name}}" value="{{>value}}" {{if ekValue==value}}checked{{/if}}  class="icheck multi_select_input" id="multi_select_input_{{>id}}" /><label for="multi_select_input_{{>id}}" style="margin-left:2px;margin-right:5px">{{:text}}</label>
		{{/for}}
	</div>
</script>