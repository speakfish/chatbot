<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/include/inner.jsp"%>
<div class="portlet light">
	<div class="portlet-title">
		<div class="caption">
			<i class="fa fa-cogs font-green-sharp"></i> <span class="caption-subject font-green-sharp bold uppercase">聊天机器人问答库</span>
		</div>
		<div class="actions">
				<a href="javascript:;" class="ekAddBtn btn btn-circle btn-default"
					ekEditContain=".ekPageForm"> <i class="fa fa-plus"></i> <span>新增笔记</span>
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
										<label class="control-label col-md-2">笔记内容:</label>
										<div class="col-md-10">
											<div class="input-icon">
												<i class="fa fa-search"></i> <input class="form-control" type="text" name="comment">
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
					<tr><th sort="bookName">书名</th>
						<th sort="field">字段</th>
						<th sort="comment">笔记</th>
						<th sort="createDate">创建日期</th>
						<th sort="type">类型</th>
						<th>操作</th>
					</tr>
				</thead>
				<tbody class="ekTempletContain">
					<tr data-id="{{>id}}">
					<td>{{>bookName}}</td>
						<td>{{>field}}</td>
						<td>{{>comment}}</td>
						<td>{{>createDateView}}</td>
						<td>{{if type=='0'}}
										<p style="color: green">金融</p>{{else}} {{/if}} 
							{{if type =='1'}}
										<p style="color: green">文学</p>{{else}} {{/if}}
							{{if type =='2'}}
										<p style="color: green">哲学</p>{{else}} {{/if}}
							{{if type =='3'}}
										<p style="color: green">心理</p>{{else}} {{/if}}</td>
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
						<i class="fa fa-gift"></i>记录心得
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
								<label class="col-md-3 control-label"><span class="require-star">*</span>书名</label>
								<div class="col-md-4">
									<input type="text" name="bookName" value="{{>bookName}}" maxlength="100" class="form-control">
								</div>
							</div>
							<div class="row">
								<label class="col-md-3 control-label"><span class="require-star">*</span>记录</label>
								<div class="col-md-4">
									<input type="text" name="field" value="{{>field}}" maxlength="100" class="form-control">
								</div>
							</div>
							<div class="row">
								<label class="col-md-3 control-label"><span class="require-star">*</span>评论</label>
								<div class="col-md-4">
									<textarea class="form-control" name="comment"  maxlength="2000" ek style="height: 100px; width: 355px;">{{>comment}}</textarea>
								</div>
							</div>
							<div class="row">
								<label class="col-md-3 control-label"><span class="require-star">*</span>类型</label>
									<div class="col-md-4">
										<select ekDict="noteType" name="type"></select>
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