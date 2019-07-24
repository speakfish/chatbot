var ek = ek || $.noop;
$.ajaxSetup({
	cache : false
});

(function($) {
	ek.width = ek.width || 1100;
	ek.menu_data = {};
	ek.page_data = {};
	ek.effect = ek.effect || "off";
	ek.contentEL = ek.contentEL || ".pageContent";
	ek.default_select_option = ek.default_select_option || "-请选择-";
	ek.default_multiselect_loop = ek.default_multiselect_loop || 4;
	ek.default_render_abbreviate_length = ek.default_render_abbreviate_length || 10;

	$.fn.modal.Constructor.DEFAULTS.keyboard = false;

	toastr.options = {
		closeButton : true,
		positionClass : "toast-top-center",
		onclick : null
	};

	$.views.tags("abbreviate", function(value, length, tips) {
		if (value) {
			if (!length) {
				length = ek.default_render_abbreviate_length;
			}
			if (value.length > length) {
				var data = {};
				data.value = value.substr(0, length) + "...";
				data.title = value;
				return $("#tmpl_render_abbreviate").render(data);
			}
			return value;
		} else {
			return "";
		}
	});

	ek.doRemoveResponse = function(e) {
		$(e).closest(".status").remove();
	}

	ek.getUserResource = function(callback) {
		$.ajax({
			url : ctxRoot + "/resource/get",
			success : function(data) {
				$(".menuContain").html($("#tmpl-head-menu").render(data.menu));
				for (var n = 0; n < data.page.length; n++) {
					var d = data.page[n];
					ek.page_data[d["code"]] = d;
				}
				for (var n = 0; n < data.menu.length; n++) {
					var d = data.menu[n];
					if (d.children) {
						for (var i = 0; i < d.children.length; i++) {
							var dd = d.children[i];
							dd.parent = d;
							ek.menu_data[dd["code"]] = dd;
						}
					}
					ek.menu_data[d["code"]] = d;
				}
				if (callback) {
					callback.call();
				}
			}
		});
	}

	ek.doValidForm = function(ob) {
		ob = $(ob)
		var errorImg = "<img  align='absmiddle' src='" + ctxRoot + "/res/images/error.png' />";
		errorImg = "";
		ob.find(".warning,.valid").remove();
		ob.find(".error").removeClass("error");
		var flag = true;
		ob.find("input[require]:visible,select[require]:visible,textarea[require]:visible").each(function() {
			if ($(this).val() == "") {
				$(this).addClass("error");
				flag = false;
				$(this).after("<span class='warning error' title='必填.'>" + errorImg + "必填.</span>");
			}
		});
		ob.find("input[number]:visible").each(function() {
			if (isNaN($(this).val())) {
				$(this).addClass("error");
				flag = false;
				$(this).after("<span class='warning error' title='必须为数字.'>" + errorImg + "必须为数字.</span>");
			}
		});
		ob.find("input[plusNumber]:visible").each(function() {
			if (isNaN($(this).val())) {
				$(this).addClass("error");
				flag = false;
				$(this).after("<span class='warning error' title='必须为数字.'>" + errorImg + "必须为数字.</span>");
			} else if ($(this).val() < 0) {
				$(this).addClass("error");
				flag = false;
				$(this).after("<span class='warning error' title='必须为正数.'>" + errorImg + "必须为正数.</span>");
			}
		});
		ob.find("input[regex]:visible").each(
				function() {
					if ($(this).val() != "") {
						var reg = new RegExp($(this).attr("regex"));
						if (!reg.test($(this).val())) {
							$(this).addClass("error");
							flag = false;
							$(this).after(
									"<span class='warning error' title='" + $(this).attr("msg") + "'>" + errorImg
											+ $(this).attr("msg") + "</span>");
						}
					}
				});
		return flag;
	}

	ek.generateFormData = function(obj) {
		var conditions = obj.find("input[name],select[name],textarea[name]");
		var formdata = {};
		conditions.each(function() {
			var name = $(this).attr("name");
			var val = $(this).val();
			if (val != null) {
				if ($(this).attr("type") == "radio") {
					if ($(this).attr("checked")) {
						formdata[name] = val;
					}
				} else if ($(this).attr("type") == "checkbox") {
				} else {
					formdata[name] = val;
				}
			}
		});
		var d = {};
		obj.find("input[type=checkbox]:checked").each(function() {
			var name = $(this).attr("name");
			var dd = d[name];
			if (!dd) {
				dd = $(this).val();
			} else {
				dd += "," + $(this).val();
			}
			d[name] = dd;
		});
		return $.extend({}, formdata, d);
	}

	ek.converHtml = function(e) {
		if (!e) {
			e = $(document);
		}
		e.find(".ekSubmitBtn").click(function() {
			$(this).closest("form").submit();
			return false;
		})
		e.find(".ekResetBtn").click(function() {
			$(this).closest("form").find(".icheck").iCheck('uncheck');
			$(this).closest("form")[0].reset();
			$(".ekSearchBtn").trigger("click");
			return false;
		});
		e.find(".ekDatepicker").datepicker({
			rtl : Metronic.isRTL(),
			format : 'yyyy-mm-dd',
			autoclose : true
		});
		//
		var dictCodes = [];
		var select = e.find("select[ekDict]:visible");
		if (select.length == 0 && e.attr("ekDict")) {
			select = e;
		}
		select.each(function() {
			dictCodes.push($(this).attr("ekDict"));
		});

		var dfd = $.Deferred();

		var dfd2 = $.Deferred();

		if (dictCodes.length > 0) {
			var tpl_dict = $("#tmpl-select");
			$.ajax({
				url : ctxRoot + "/dict/fill/list.compress",
				data : {
					dictCodes : dictCodes.join(",")
				},
				success : function(data) {
					select.each(function() {
						var $this = $(this);
						var d = data[$this.attr("ekDict")];
						if (d) {
							var v = $this.attr("ekValue");
							if ($this.attr("defaultSelect")) {
								$this.html(tpl_dict.render(d));
								if (v) {
									$this.attr("value", v);
								}
							} else {
								if ($(this).attr("ekMultiselectDefault") == "true") {
									$this.html("<option value=''>" + ek.default_select_option + "</option>");
								}
								$this.append(tpl_dict.render(d));
								$this.attr("value", v);
							}
						}
					});
					dfd.resolve();
				}
			});
		} else {
			dfd.resolve();
		}
		dfd.done(function() {
			e.find("select[ekMultiselect]:visible").each(function() {
				var $this = $(this);
				var loop = $this.attr("ekMultiselectLoop");
				if (!loop) {
					loop = ek.default_multiselect_loop;
				}
				var attr = $this.attr("ekMultiselect");
				var data = [];
				var index = 0;
				$this.find("option").each(function() {
					index++;
					data.push({
						"id" : Math.random(),
						"name" : $this.attr("name"),
						"value" : $(this).val(),
						"text" : $(this).text(),
						"wrap" : (index % loop == 0),
						"ekValue" : $this.attr("ekValue")
					});
				});
				var html = $("#tmpl-multi-select").render({
					"data" : data,
					"loop" : loop,
					"type" : "single" == attr ? "radio" : "checkbox"
				});
				if ($(this).attr("ekSelectEvent") == "default") {
					html = $(html);
					html.find("input").on("ifChanged", function() {
						$(this).closest("form").find(".ekSearchBtn").trigger("click");
					})
				}
				$this.after(html);
				$this.remove();
			});
			e.find("select[ekSelect2]:visible").select2({
				placeholder : "请输入",
				allowClear : true
			});
			e.find('.icheck').each(
					function() {
						var checkboxClass = $(this).attr('data-checkbox') ? $(this).attr('data-checkbox')
								: 'icheckbox_square-orange';
						var radioClass = $(this).attr('data-radio') ? $(this).attr('data-radio')
								: 'iradio_square-orange';
						if ($(this).attr("ekSelectEvent") == "false") {
						} else {
							$(this).on("ifChanged", function() {
								$(this).closest("form").find(".ekSearchBtn").trigger("click");
							})
						}
						$(this).iCheck({
							checkboxClass : checkboxClass,
							radioClass : radioClass
						});
					});
			if (ek.selfConverHtml) {
				ek.selfConverHtml.call(this, e);
			}
			dfd2.resolve();
		})
		return dfd2;
	}

	ek.show = function(el) {
		var dfd = $.Deferred();
		if (ek.effect == "off") {
			el.show();
			dfd.resolve();
		}
		if (ek.effect == "slide") {
			el.show(ek.effect, {
				direction : 'right'
			}, function() {
				dfd.resolve();
			});
		}
		if (ek.effect == "fade") {
			el.fadeIn("fast", function() {
				dfd.resolve();
			});
		}
		return dfd.promise();
	};

	ek.hide = function(el) {
		var dfd = $.Deferred();
		if (ek.effect == "off") {
			el.hide();
			dfd.resolve();
		}
		if (ek.effect == "slide") {
			el.hide(ek.effect, {
				direction : 'right'
			}, function() {
				dfd.resolve();
			});
		}
		if (ek.effect == "fade") {
			el.fadeOut("fast", function() {
				dfd.resolve();
			});
		}
		return dfd.promise();
	};

	ek.showCenter = function(code, callback) {
		var d = ek.menu_data[code];
		if (!d) {
			d = ek.page_data[code];
		}
		if (d) {
			var url = d.text;
			var title = d.name;
			if (url && url != "") {
				ek.mask();
				_current_code = code;
				$.cookie('_current_code', code);
				$(ek.contentEL).load(ctxRoot + url, null, function() {
					$(".pageTitle").html(title);
					if (callback) {
						callback.call();
					}
					ek.unmask();
				});
			}
		}
	}

	ek.op = function(url, title, callback) {
		$("#_sysWin").dialog({
			title : title,
			width : ek.width,
			modal : true,
			position : 'top',
			resizable : false,
			draggable : true,
			minHeight : 400,
			height : 'auto',
			open : function() {
				ek.mask();
				$("#_sysWin").load(url, {}, function() {
					ek.unmask();
					if ($("#_sysWin").height() < 500) {
						$("#_sysWin").height(540);
					}
				});
				if (!title) {
					ek.hideWinTitleBar("#_sysWin");
				}

			},
			buttons : {
				"确定" : function() {
					if (callback) {
						var data = null;
						if (getDialogResult) {
							data = getDialogResult();
						}
						if (data) {
							var result = callback.call(this, data);
							if (result) {
								$("#_sysWin").dialog('close');
							}
							if (data.dfd) {
								dfd.done(function() {
									$("#_sysWin").dialog('close');
								});
							}
						}
					}
				},
				"关闭" : function() {
					$("#_sysWin").dialog('close');
				}
			}
		});
	}

	ek.download = function(fileName, filePath) {
		$("#_downloadFileName").val(fileName);
		$("#_downloadFilePath").val(filePath);
		$("#_downloadForm").submit();
		$("#_downloadFileName").val('');
		$("#_downloadFilePath").val('');
	}
	ek.mask = function(modal) {
		Metronic.blockUI({
			boxed : true
		});
	}
	ek.unmask = function() {
		Metronic.unblockUI();
	}

	ek.notice = function(html, title, lifetime) {
		$("#_notice").notice(html);
	}
	ek.dialog = function(value) {
		$("#_msg").dialog({
			autoOpen : true,
			height : 'auto',
			minHeight : 220,
			width : 300,
			modal : true,
			resizable : false,
			draggable : false,
			stack : true,
			buttons : {
				"关闭" : function() {
					$("#_msg").dialog('close');
				}
			}
		});
		$("#_msg").html(value);
	}

	ek.msg = function(value, type, title, lifetime) {
		alert(value);
	}

	ek.error = function(msg, autoHide, el) {
		if (autoHide) {
			toastr.options.timeOut = autoHide;
		} else {
			toastr.options.timeOut = 5000;
		}
		var $toast = toastr['error'](msg, "异常信息");
	};

	ek.success = function(msg, autoHide, el) {
		if (autoHide) {
			toastr.options.timeOut = autoHide;
		} else {
			toastr.options.timeOut = 2000;
		}
		var $toast = toastr['success'](msg, "提示信息");
	}

	ek.warn = function(msg, autoHide, el) {
		var $toast = toastr['warning'](msg, "警告信息");
	}

	ek.hideWinTitleBar = function(id) {
		$(id).closest('.ui-dialog').find('.ui-dialog-titlebar').hide();
	}

	ek.getTreeCheckedIds = function(tree) {
		var arr = tree.getCheckedNodes();
		var re = [];
		for (var n = 0; n < arr.length; n++) {
			re.push("'" + arr[n]['id'] + "'");
		}
		return re.join(",");
	}

	ek.getTreeCheckedIds2 = function(tree) {
		var arr = tree.getCheckedNodes();
		var re = [];
		for (var n = 0; n < arr.length; n++) {
			re.push(arr[n]['id']);
		}
		return re.join(",");
	}

	ek.getTreeCheckedNames = function(tree) {
		var arr = tree.getCheckedNodes();
		var re = [];
		for (var n = 0; n < arr.length; n++) {
			re.push("'" + arr[n]['name'] + "'");
		}
		return re.join(",");
	}

	ek.replaceAll = function(s, s1, s2) {
		return s.replace(new RegExp(s1, "gm"), s2);
	}
	ek.signThousands = function(num) {
		return num;
	}

	ek.isEncodeHTML = function(str) {
		if (!str) {
			return false;
		}
		if (str.search(/&amp;/g) != -1 || str.search(/&lt;/g) != -1 || str.search(/&gt;/g) != -1)
			return true;
		else
			return false;
	};

	ek.decodeHTML = function(str) {
		if (ek.isEncodeHTML(str))
			return str.replace(/&amp;/g, '&').replace(/&lt;/g, '<').replace(/&gt;/g, '>');
		return str;
	}

	ek.editForm = function(el, data, tmpl) {
		if (tmpl) {
			el.empty();
			el.show();
			el.html(tmpl.render(data));
		} else {
			var ob = {};
			var id = el.attr("_el_id");
			if (!id) {
				if (typeof (_classId) == "undefined") {
					id = Math.random() + "";
				} else {
					id = _classId + Math.random();
				}
				id = id.replace(".", "");
				ob[id] = ek.decodeHTML(el.html());
				$.templates(ob);
				el.attr("_el_id", id);
				el.empty();
				el.show();
			}
			el.html($.templates[id].render(data));
		}
	}

	ek.doEdit = function(target, id) {
		var dfd = $.Deferred();
		var $c = $(target).closest(".ekMainPage");
		var $templetContain = $c.find(".ekPageForm").find(".ekTempletContain");
		if ($templetContain.length == 0) {
			$templetContain = $c.find(".ekPageForm")
		}
		var elId = $templetContain.attr("id");
		var tmpl = $("#tmpl-" + elId);
		if (tmpl.length != 1) {
			tmpl = null;
		}
		if (id) {
			ek.hide($c.find(".ekPage-1")).done(function() {
				ek.show($c.find(".ekPage-2"));
				ek.mask();
				$.ajax({
					url : ctxRoot + _action_uri + "/get/" + id,
					success : function(data) {
						ek.editForm($templetContain, data, tmpl);
						ek.converHtml($templetContain).done(function() {
							ek.unmask();
							dfd.resolve(data);
						});
					}
				});
			});
		} else {
			$c.find(".ekPage-1").hide();
			ek.editForm($templetContain, {}, tmpl);
			$c.find(".ekPage-2").show();
			ek.converHtml($templetContain).done(function() {
				dfd.resolve();
			});
		}
		return dfd;
	}

	ek.doDelete = function(target, id) {
		var $c = $(target).closest(".ekMainPage");
		if (confirm("确认操作？")) {
			ek.mask();
			$.ajax({
				url : ctxRoot + _action_uri + "/delete/" + id,
				success : function(data) {
					if (data.success == true) {
						ek.success(data.msg, 2000);
						$c.find(".ekGrid").grid("load");
					} else {
						ek.error(data.msg);
					}
					ek.unmask();
				}
			});
		}
	}

	ek.fillForm = function(el, data) {
		el = $(el);
		if (data) {
			for ( var e in data) {
				var val = data[e];
				var input = el.find("[name='" + e + "']");
				var type = input.attr("type");
				if (type == "checkbox") {
					input.attr("checked", "true")
				} else {
					input.val(val);
				}
			}
		}
	}

	ek.addTootips = function(el) {
		el.find("span[tooltips]").tinytooltip({
			message : function(tip) {
				return $(this).attr("tooltips");
			}
		});
	}

	ek.showWelcomePage = function(isCookie) {
		ek.mask();
		$.ajax({
			url : ctxRoot + "/person/welcome",
			data : {
				"isCookie" : isCookie,
				"current_code" : $.cookie('_current_code')
			},
			success : function(data) {
				if (data.rd) {
					ek.showCenter(data.rd.code);
				} else {

				}
				ek.unmask();
			}
		});
	}

	ek.initEvn = function() {
		$("#_mask").dialog({
			autoOpen : false,
			height : 200,
			closeOnEscape : false,
			width : 300,
			modal : true,
			resizable : false,
			draggable : false,
			stack : true,
			open : function(event, ui) {
				ek.hideWinTitleBar($(this));
			}
		});
	}

})(jQuery);
