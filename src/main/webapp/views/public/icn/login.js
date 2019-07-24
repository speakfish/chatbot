function doValidLogin() {
	var username = jQuery("#username");
	var password = jQuery("#password");
	if (username.val() == "") {
		_showError("请输入用户名.");
		username.focus();
		return false;
	}
	if (password.val() == "") {
		_showError("请输入密码.");
		password.focus();
		return false;
	}
	// $(".submitBtn").addClass("disabled");
	return true;
}

function _showError(msg) {
	$(".captchaContain").show();
	$("#errorContain").html(msg);
	$("#errorContain").closest("div").show();
}

function _hideError() {
	$("#errorContain").empty();
	$("#errorContain").closest("div").hide();
}

$(function() {
	$("#username").focus();
	$('#kaptchaImage').click(function() {// 生成验证码
		$(this).hide().attr('src', ctxRoot + '/public/captcha-image?' + Math.floor(Math.random() * 100)).fadeIn();
		return false;
	});

	$(".close").click(function() {
		_hideError();
		return false;
	})

	$("input").on('keyup', function(event) {
		if (event.which == 13) {
			$('.login-form').submit();
		}
	})

	$('.login-form').ajaxForm({
		beforeSerialize : function($form, options) {
			return true;
		},
		beforeSubmit : function(arr, $form, options) {
			_hideError();
			var flag = doValidLogin();
			if (flag) {
				// ek.mask();
			}
			return flag;
		},
		success : function(data) {
			data = $.parseJSON(data);
			if (data.success == true) {
				location.replace(ctxRoot + data.msg);
			} else {
				_showError(data.msg);
			}
			// ek.unmask();
		}
	});

	jQuery(".moreBtn").toggle(function() {
		jQuery(".more").show();
		jQuery(".moreBtn").html("Hide More");
	}, function() {
		jQuery(".more").hide();
		jQuery(".moreBtn").html("Show More");
	});
})
