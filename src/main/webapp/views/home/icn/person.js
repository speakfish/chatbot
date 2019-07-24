$(function() {
	var jcrop_api;

	$('.headPicUploadForm').ajaxForm({
		beforeSerialize : function($form, options) {
			return true;
		},
		beforeSubmit : function(arr, $form, options) {
			ek.mask();
			return true;
		},
		error : function() {
			ek.error("文件异常,可能超过大小")
			ek.unmask();
		},
		success : function(data) {
			data = $.parseJSON(data);
			if (data.success == true) {
				if (jcrop_api) {
					jcrop_api.destroy();
				}
				$("#head-pic-crop").attr("src", ctxRoot + "/person/head-pic/temp?a=" + Math.random());
				$("#head-pic-crop").css("width", data.rd[0]);
				$("#head-pic-crop").css("height", data.rd[1]);
				$(".headPicSubmitForm").find("input[name='rate']").val(data.rd[2]);

				$('#head-pic-crop').Jcrop({
					setSelect : [ 0, 0, 147, 206 ],
					onSelect : function(c) {
						$('#crop_x').val(c.x);
						$('#crop_y').val(c.y);
						$('#crop_w').val(c.w);
						$('#crop_h').val(c.h);
					},
					onRelease : function() {
						$('#crop_x').val('');
						$('#crop_y').val('');
						$('#crop_w').val('');
						$('#crop_h').val('');
					}
				}, function() {
					jcrop_api = this;
					$(".headPicSubmitForm").show();
					ek.unmask();
				});
			} else {
				ek.error(data.msg)
				ek.unmask();
			}
		}
	});

	$('.headPicSubmitForm').ajaxForm({
		beforeSerialize : function($form, options) {
			return true;
		},
		beforeSubmit : function(arr, $form, options) {
			ek.mask();
			return true;
		},
		success : function(data) {
			if (data.success == true) {
				location.reload();
			} else {
				alert(data.msg)
			}
			ek.unmask();
		}
	});

	$("input[name='headPicFile']").on("change", function() {
		$('.headPicUploadForm').submit();
	})

	$('.personForm').ajaxForm({
		beforeSerialize : function($form, options) {
			return true;
		},
		beforeSubmit : function(arr, $form, options) {
			ek.mask();
			return true;
		},
		success : function(data) {
			if (data.success == true) {
				ek.success(data.msg);
			} else {
				ek.error(data.msg);
			}
			ek.unmask();
		}
	});

});
