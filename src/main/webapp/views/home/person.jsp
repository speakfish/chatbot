<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/include/inner.jsp"%>
<div class="row">
	<div class="col-md-12">
		<div class="tabbable tabbable-custom tabbable-noborder">
			<ul class="nav nav-tabs">
				<li class="active"><a href="#tab_1" data-toggle="tab"> 头像设置 </a></li>
				<li><a href="#tab_2" data-toggle="tab"> 登录密码设置 </a></li>
			</ul>
			<div class="tab-content">
				<div class="tab-pane active" id="tab_1">
					<div class="row">
						<div class="col-md-7 responsive-1024">
							<!-- This is the image we're attaching Jcrop to -->
							<img src="<%=path%>/res/images/m_blank.gif" id="head-pic-crop" alt="" />
						</div>
						<div class="col-md-5 responsive-1024">
							<h4>头像选取</h4>
							<p>
								先选择图片,然后拖动选择部分,最后点击确认图片<br>如果不选择,则默认整个图片.Enjoy it!
							</p>
							<form class="headPicUploadForm" action="<%=path%>/person/headpic/upload" method="post" enctype="multipart/form-data">
								<div class="fileinput fileinput-new" data-provides="fileinput">
									<span class="btn default btn-file"> <span class="fileinput-new"> 选择图片 </span> <span class="fileinput-exists">
											选择图片 </span> <input type="file" name="headPicFile">
									</span> <span class="fileinput-filename"> </span> &nbsp; <a href="javascript:;" class="close fileinput-exists"
										data-dismiss="fileinput"> </a>
								</div>
							</form>
							<br />
							<form class="headPicSubmitForm" action="<%=path%>/person/headpic/submit" method="post" style="display: none">
								<input type="hidden" name="rate" /> <input type="hidden" id="crop_x" name="x" /> <input type="hidden" id="crop_y"
									name="y" /> <input type="hidden" id="crop_w" name="w" /> <input type="hidden" id="crop_h" name="h" /> <input
									type="submit" value="确认图片" class="btn btn-large blue headPicSubmitBtn" />
							</form>
						</div>
					</div>
				</div>
				<div class="tab-pane" id="tab_2">
					<div class="row">
						<div class="col-md-12 ">
							<div class="portlet box green">
								<div class="portlet-title">
									<div class="caption">
										<i class="fa fa-gift"></i>密码修改
									</div>
									<!-- <div class="tools">
										<a href="javascript:;" class="collapse"> </a> <a href="#portlet-config" data-toggle="modal" class="config"> </a> <a
											href="javascript:;" class="reload"> </a> <a href="javascript:;" class="remove"> </a>
									</div>  -->
								</div>
								<div class="portlet-body form">
									<!-- BEGIN FORM-->
									<form class="form-horizontal personForm" action="<%=path%>/person/change/password" method="post">
										<div class="form-body">
											<div class="form-group ">
												<label class="col-md-3 control-label">原密码</label>
												<div class="col-md-4">
													<div class="input-group">
														<input type="password" class="form-control input-circle-left" name="oldpassword"> <span
															class="input-group-addon input-circle-right"> <i class="fa fa-user"></i>
														</span>
													</div>
												</div>
											</div>
											<div class="form-group ">
												<label class="col-md-3 control-label">新密码</label>
												<div class="col-md-4">
													<div class="input-group">
														<input type="password" class="form-control input-circle-left" name="newpassword"> <span
															class="input-group-addon input-circle-right"> <i class="fa fa-user"></i>
														</span>
													</div>
												</div>
											</div>
											<div class="form-group last">
												<label class="col-md-3 control-label">确认密码</label>
												<div class="col-md-4">
													<div class="input-group">
														<input type="password" class="form-control input-circle-left" name="retypedpassword"> <span
															class="input-group-addon input-circle-right"> <i class="fa fa-user"></i>
														</span>
													</div>
												</div>
											</div>
										</div>
										<div class="form-actions">
											<div class="row">
												<div class="col-md-offset-3 col-md-9">
													<button type="submit" class="btn btn-circle blue">Submit</button>
												</div>
											</div>
										</div>
									</form>
									<!-- END FORM-->
								</div>
							</div>
						</div>
					</div>

				</div>
			</div>
		</div>
	</div>
</div>