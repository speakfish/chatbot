<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/include/inner.jsp"%>
<div class="row">
	<div class="col-md-12">
		<div class="portlet light tasks-widget">
			<div class="portlet-title">
				<div class="caption caption-md">
					<i class="icon-bar-chart theme-font hide"></i> <span class="caption-subject font-blue-madison bold ">eCOM
						2016年年会记录</span>
				</div>
			</div>
			<div class="portlet-body">
				<div class="task-content">
					<div class="" style="height: 300px;">
						<div class="general-item-list  ">
							<div class="item">
								<div class="item-body">
									<a href="###" onclick="ek.showCenter('406')"><img class="item-pic "
										src="/otherdocument/2016dinner/title.jpg"
										style="border-radius: 6px; width: 100%; height: 310px;margin-top:-20px" /> </a>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="task-footer">
					<div class="btn-arrow-link pull-right">
						<a href="javascript:;" onclick="ek.showCenter('406')">查看所有</a>
					</div>
				</div>
			</div>
		</div>
	</div>


	<div class="col-md-6">
		<div class="portlet light tasks-widget">
			<div class="portlet-title">
				<div class="caption caption-md">
					<i class="icon-bar-chart theme-font hide"></i> <span class="caption-subject font-blue-madison bold uppercase">每日简报</span>
					<!-- <span class="caption-helper">45 pending</span> -->
				</div>
			</div>
			<div class="portlet-body">
				<div class="task-content">
					<div class="scroller" style="height: 305px;">
						<div class="general-item-list ek-portlet-contain ekTempletContain"
							url="/otherdoc/list?sidx=id&sord=desc&rows=1&auto=true">
							<div class="item">
								<div class="item-head">
									<div class="item-details">
										<a href="###" class=" primary-link" onclick="ek.showCenter('405',function(){doView('{{>id}}')})">{{>title}}</a>
									</div>
									<div>
										<img class="item-pic " src="/otherdocument/{{>key}}/title.jpg"
											style="border-radius: 6px; width: 260px; height: 180px" />
									</div>
								</div>
								<div class="item-body">{{:subTitle}}</div>
							</div>
						</div>
					</div>
				</div>
				<div class="task-footer">
					<div class="btn-arrow-link pull-right">
						<a href="javascript:;" onclick="ek.showCenter('405')">查看所有</a>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="col-md-6">
		<!-- BEGIN PORTLET -->
		<div class="portlet light tasks-widget">
			<div class="portlet-title">
				<div class="caption caption-md">
					<i class="icon-bar-chart theme-font hide"></i> <span class="caption-subject font-blue-madison bold uppercase">留言板</span>
					<!-- <span class="caption-helper">45 pending</span> -->
				</div>
				<div class="inputs">
					<div class="portlet-input input-inline input-small ">
						<div class="input-icon right">
							<a class="btn blue default btn-sm" data-toggle="modal" href="#messageDialog" style="float: right"> 发布留言 </a>
							<!-- <i class="icon-magnifier"></i> <input type="text" class="form-control form-control-solid" placeholder="search..."> -->
						</div>
					</div>
				</div>
			</div>
			<div class="portlet-body">
				<div class="task-content">
					<div class="scroller" style="height: 305px;" data-always-visible="1" data-rail-visible1="0" data-handle-color="#D7DCE2">
						<div class="general-item-list ek-portlet-contain ekTempletContain" url="/message/list?sidx=id&sord=desc">
							<div class="item">
								<div class="item-head">
									<div class="item-details">
										<img class="item-pic headPicTooltipsObj" src="<%=path%>/person/head-pic/s/{{>loginName}}"
											tooltips-value="{{>loginName}}" /> <a href="" class="item-name primary-link">{{>userName}}</a> <span
											class="item-label">{{>createDateView}}</span>
									</div>
									<span class="item-status"><span class="badge badge-empty badge-success"></span> Open</span>
								</div>
								<div class="item-body">{{:message}}</div>
							</div>
						</div>
					</div>
				</div>
				<div class="task-footer">
					<div class="btn-arrow-link pull-right">
						<a href="javascript:;" onclick="ek.showCenter('300')">See All Message</a>
					</div>
				</div>
			</div>
		</div>
		<!-- END PORTLET -->
	</div>
</div>
<div class="row">
	<div class="col-md-6" style="display: none">
		<!-- BEGIN PORTLET -->
		<div class="portlet light tasks-widget">
			<div class="portlet-title">
				<div class="caption caption-md">
					<i class="icon-bar-chart theme-font hide"></i> <span class="caption-subject font-blue-madison bold uppercase">新版OA满意度调查结果</span>
					<span class="caption-helper responseNumContain"></span>
				</div>
			</div>
			<div class="portlet-body">
				<div class="task-content" id="question1ReportContain" style="height: 304px"></div>
				<div class="task-footer">
					<div class="btn-arrow-link pull-right">
						<a href="javascript:;" onclick="ek.showCenter('400')">填写问卷</a>
					</div>
				</div>
			</div>
		</div>
		<!-- END PORTLET -->
	</div>
</div>
