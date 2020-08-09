<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/include/inner.jsp"%>
<div class="portlet light">
	<div class="portlet-title">
		<div class="caption">
			<i class="fa fa-cogs font-green-sharp"></i> <span class="caption-subject font-green-sharp bold uppercase">聊天机器人问答库</span>
		</div>
		<div class="actions">
				<a href="javascript:;" class="ekAddBtn btn btn-circle btn-default"
					ekEditContain=".ekPageForm"> <i class="fa fa-plus"></i> <span>新增逻辑</span>
				</a>
			</div>
	</div>
	<div class="portlet-body">
		<div class="ekPage-1">
			<div class="table-toolbar">
				<div class="row">
					<div class="col-md-12">
						<form class="ekSearchCondition alert alert-warning alert-borderless">
							<div class="row form-group">
								<div class="col-md-9">
									<div class="form-group">
										<label class="control-label col-md-2">gdm中的字段:</label>
										<div class="col-md-10">
											<div class="input-icon">
												<i class="fa fa-search"></i> <input class="form-control" type="text" name="fieldGdmName">
											</div>
										</div>
										<label class="control-label col-md-2">ldm中的字段:</label>
										<div class="col-md-10">
											<div class="input-icon">
												<i class="fa fa-search"></i> <input class="form-control" type="text" name="fieldLdmName">
											</div>
										</div>
										<label class="control-label col-md-2">报表名称:</label>
										<div class="col-md-10">
											<div class="input-icon">
												<i class="fa fa-search"></i> <input class="form-control" type="text" name="reportName">
											</div>
										</div>
										<label class="control-label col-md-2">logic:</label>
										<div class="col-md-10">
											<div class="input-icon">
												<i class="fa fa-search"></i> <input class="form-control" type="text" name="logic">
											</div>
										</div>
									</div>
								</div>
							</div>
							<div class="row form-group">
								<div class="col-md-6">
									<div class="form-group">
										<label class="control-label col-md-3">创建时间:</label>
										<div class="col-md-9">
											<div class="input-group input-large date-picker input-daterange" data-date-format="yyyy-mm-dd">
												<input type="text" class="form-control ekDatepicker" name="startDate"> <span class="input-group-addon">&nbsp;至&nbsp;</span>
												<input type="text" class="form-control ekDatepicker" name="endDate">
											</div>
										</div>
									</div>
								</div>
							</div>
							<div class="input-group1">
								<div class="input-cont1">
									<button type="button" class="btn green-haze ekSearchBtn">
										<i class="fa fa-search"></i>&nbsp;Search
									</button>
								</div>
							</div>
						</form>
					</div>
				</div>
			</div>
			<table class="ekGrid table table-striped table-bordered table-hover">
				<thead>
					<tr>
						<th sort="reportName">报表名称</th>
						<th sort="cellLogicName">报表栏位</th>
						<th sort="fieldGdmName">fieldGdmName</th>
						<th sort="fieldLdmName">fieldLdmName</th>
						<th sort="selfComment">批注</th>
						<th sort="logic">logic</th>
						<th sort="createDate">创建日期</th>
						<th>操作</th>
					</tr>
				</thead>
				<tbody class="ekTempletContain">
					<tr data-id="{{>id}}">
						<td>{{>reportName}}</td>
						<td>{{>cellLogicName}}</td>
						<td>{{>fieldGdmName}}</td>
						<td>{{>fieldLdmName}}</td>
						<td>{{>selfComment}}</td>
						<td>{{>logic}}</td>
						<td>{{>createDateView}}</td>
						<td><a href="###" class="ekEditBtn">修改</a>|<a href="###"
								class="ekDeleteBtn">删除</a></td>
					</tr>
				</tbody>
			</table>
		</div>
		<div class="ekPage-2" style="display: none">
			<div class="portlet box blue-hoki">
				<div class="portlet-title">
					<div class="caption">
						<i class="fa fa-gift"></i>新增逻辑
					</div>
				</div>
				<div class="portlet-body form">
					<form method="post" class="ekPageForm form-horizontal">
						<div class="form-actions top">
							<div class="row">
								<div class="col-md-offset-3 col-md-9">
									<button type="button" class="btn default ekBackBtn">
										<i class="fa fa-chevron-left"></i>&nbsp;Back
									</button>
									<button type="button" class="btn green ekSubmitBtn">
										<i class="fa fa-check"></i>&nbsp;Submit
									</button>
								</div>
							</div>
						</div>
						<div class="ekTempletContain form-body">
							<input type="hidden" name="id" value="{{>id}}" />
							<div class="form-group">
							<div class="row">
								<label class="col-md-3 control-label"><span class="require-star">*</span>报表名称</label>
								<div class="col-md-4">
									<input type="text" name="reportName" value="{{>reportName}}" maxlength="100" class="form-control">
								</div>
							</div>
							<div class="row">
								<label class="col-md-3 control-label"><span class="require-star">*</span>报表栏位</label>
								<div class="col-md-4">
									<input type="text" name="cellLogicName" value="{{>cellLogicName}}" maxlength="100" class="form-control">
								</div>
							</div>
							<div class="row">
								<label class="col-md-3 control-label"><span class="require-star">*</span>fieldGdmName</label>
								<div class="col-md-4">
									<input type="text" name="fieldGdmName" value="{{>fieldGdmName}}" maxlength="100" class="form-control">
								</div>
							</div>
							<div class="row">
								<label class="col-md-3 control-label"><span class="require-star">*</span>fieldLdmName</label>
								<div class="col-md-4">
									<input type="text" name="fieldLdmName" value="{{>fieldLdmName}}" maxlength="100" class="form-control">
								</div>
							</div>
							<div class="row">
								<label class="col-md-3 control-label"><span class="require-star">*</span>selfCommet</label>
								<div class="col-md-4">
									<input type="text" name="selfCommet" value="{{>selfCommet}}" maxlength="100" class="form-control">
								</div>
							</div>
							<div class="row">
								<label class="col-md-3 control-label"><span class="require-star">*</span>logic</label>
								<div class="col-md-8">
								<textarea class="form-control" name="logic"  maxlength="2000" ek style="height: 100px; width: 355px;">{{>logic}}</textarea>
								</div>
							</div>
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</div>