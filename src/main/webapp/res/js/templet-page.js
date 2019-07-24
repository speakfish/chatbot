var _templet_gotopageafterupdate = $root.attr('_templet_gotopageafterupdate');
$grid = $root.find(".ekGrid");
if ($root.attr("_templet_flag") == 'SINGLE_CRUD_PAGE' || $root.attr("_templet_flag") == 'MULTIPLE_CRUD_PAGE') {
	var gridConfig = {
		url : ctxRoot + _action_uri + "/list",
		loadComplete : function(grid, data) {
			$grid.find(".ekEditBtn,.ekViewBtn").click(function() {
				ek.doEdit($(this), $(this).closest("tr").attr("data-id")).done(function(data) {
					$root.find(".ekBackBtn").click(function() {
						$root.find(".ekPage-1").show();
						$root.find(".ekPage-2").hide();
						return false;
					});
					$root.trigger("ekTempletEditConverHtmlEvent", [ $grid, data ]);
				});
				return false;
			})
			$grid.find(".ekDeleteBtn").click(function() {
				ek.doDelete($(this), $(this).closest("tr").attr("data-id"));
				return false;
			})
			$root.trigger("ekTempletGridLoadCompleteEvent", [ $grid, data ]);
		}
	};
	if (_rootConfig.grid) {
		$.extend(gridConfig, _rootConfig.grid);
	}
	$grid.grid(gridConfig).grid("load");

	$root.find(".ekSearchBtn").click(function() {
		var formdata = ek.generateFormData($root.find(".ekSearchCondition"));
		$grid.grid({
			page : 1,
			postData : formdata
		}).grid("load");
		return false;
	});

	$root.find(".ekSearchCondition").find("input[name='searchKey']").on("keydown", function(event) {
		if (event.keyCode == 13) {
			$root.find(".ekSearchBtn").trigger("click");
		}
		return true;
	});
	$root.find(".ekAddBtn").click(function() {
		ek.doEdit($(this)).done(function() {
			$root.find(".ekBackBtn").click(function() {
				$root.find(".ekPage-1").show();
				$root.find(".ekPage-2").hide();
				return false;
			});
			$root.trigger("ekTempletEditConverHtmlEvent", [ $grid ]);
		});
		return false;
	})

	$root.find(".ekBackBtn").click(function() {
		$root.find(".ekPage-1").show();
		$root.find(".ekPage-2").hide();
		$root.trigger("ekTempletBackEvent", [ $grid ]);
		return false;
	});

	$root.find(".ekSearchCondition .icheck").click(function() {
		$root.find(".ekSearchBtn").trigger("click");
		return false;
	})

	$root.on("ekLoadForm", function(event, d) {
		var id = d.id;
		ek.mask();
		var $templetContain = $root.find(".ekTempletContain");
		$.ajax({
			url : ctxRoot + _action_uri + "/get/" + id,
			success : function(data) {
				ek.editForm($templetContain, data);
				$root.trigger("ekTempletEditConverHtmlEvent", [ $grid, data ]);
			}
		});
	})

	$root.find('.ekPageForm').on("ekAfterSubmitEvent", function(event, data) {
		if (_templet_gotopageafterupdate == "PAGE") {
			$root.trigger("ekLoadForm", [ {
				id : data.rd
			} ])
		} else {
			ek.hide($root.find(".ekPage-2")).done(function() {
				$grid.grid("load");
				ek.show($root.find(".ekPage-1"));
			});
		}
	}).on("ekBeforeSerializeEvent", function(event, data) {
	}).ajaxForm({
		url : ctxRoot + _action_uri + "/update",
		beforeSerialize : function(form, options) {
			$root.find('.ekPageForm').trigger("ekBeforeSerializeEvent", [ form ]);
			return true;
		},
		beforeSubmit : function(arr, form, options) {
			if (ek.doValidForm(form)) {
				ek.mask();
				return true;
			}
			return false;
		},
		success : function(data) {
			if (data.success == true) {
				ek.success(data.msg, 2000);
				$root.find('.ekPageForm').trigger("ekAfterSubmitEvent", [ data ]);
			} else {
				ek.error(data.msg);
			}
			ek.unmask();
		}
	});

	ek.converHtml($root);
}
