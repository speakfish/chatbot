var ek = ek || $.noop;
ek.grid_rows = ek.grid_rows || 15;
ek.grid_rows_data = ek.grid_rows_data || {
	rows : [ {
		row : 15
	}, {
		row : 30
	}, {
		row : 50
	}, {
		row : 100
	}, {
		row : 200
	} ],
	label : "records"
};
$.widget("ui.grid",
		{
			options : {
				id : "gridId",
				url : null,
				itemTmpl : null,
				sidx : "id",
				sord : "desc",
				page : 1,
				rows : null,
				pager : true,
				isPageRowsSelect : false,
				multiselect : false,
				singleselect : false,
				postData : {},
				tooltips : false,
				highlight : false,
				altRows : true,
				rownumbers : false,
				onSelectRow : $.noop,
				gridComplete : $.noop,
				loadComplete : $.noop,
				autoScroll : false,
				data : {},
				grid_rows_data : ek.grid_rows_data,
				userdata : {}
			},
			load : function() {
				var self = this;
				var grid = $(self.element);
				var t = self.getGridBody();

				var postData = this.options.postData || {};
				postData.sidx = this.options.sidx;
				postData.sord = this.options.sord;
				postData.page = this.options.page;
				postData.rows = this.options.rows ? this.options.rows : ek.grid_rows;
				t.empty();
				var isPager = this.options.pager;
				ek.mask(false);
				$.ajax({
					url : this.options.url,
					cache : false,
					data : postData,
					type : "POST",
					error : function() {
						ek.error("operation error.");
						ek.unmask();
					},
					success : function(data) {
						if (data) {
							if (data.success == false) {
								t.empty();
								ek.error(data.msg);
							} else {
								self.options.data = data;
								if (self.options.itemTmpl) {
									if (self.options.rownumbers == true) {
										var pix = (postData.page - 1) * postData.rows;
										for (var n = 0; n < data.rows.length; n++) {
											data.rows[n]["_index"] = pix + n + 1;
										}
									}
									t.html($.templates[self.options.id].render(data.rows));
									if (self.options.multiselect == true) {
										grid.find("thead").find("input[type='checkbox']").removeAttr("checked");
									}
									if (isPager) {
										self.generatePager(data);
									}
									var trs = grid.find("tr");
									if (self.options.highlight) {
										trs.click(function() {
											self.highlightRow($(this));
											if (self.options.onSelectRow) {
												self.options.onSelectRow.call(self);
											}
										})
									} else {
										if (self.options.onSelectRow) {
											trs.click(self.options.onSelectRow)
										}
									}
									if (self.options.altRows) {
										grid.find("tr:odd").addClass("odd");
									}
									if (self.options.tooltips == true) {
										ek.addTootips(t);
									}
									t.show();
									self.options.loadComplete.call(self, grid, data);
								}
							}
							ek.unmask();
						}
					}
				});
			},
			destroy : function() {
				$.Widget.prototype.destroy.call(this);
			},
			_create : function() {
				var self = this;
				var grid = $(self.element);
				self.options.id = Math.random() + "";
				if (self.options.isPageRowsSelect) {
					var html = $($("#tmpl-grid-rows-select").render(self.options.grid_rows_data));
					html.find(".ekGridRowsSelectBtn").on("change", function() {
						self.options.rows = $(this).val();
						self.options.page = 1;
						self.load();
					})
					grid.before(html);
				}

				if (self.options.autoScroll == true) {
					grid.wrap("<div class='table-scrollable'></div>");
				}
				var thead = grid.find("thead");
				var th = thead.find("th[sort]");
				th.each(function() {
					var sn = $(this).attr("sort");
					if (sn) {
						var d = $(this).html();
						$(this).html("<a href='###'>" + d + "</a>");
					}
				});
				th.find("a").click(function() {
					self.doSort($(this));
				});

				var wrapElement = "tbody";
				if (grid.find("tbody").length == 0) {
					wrapElement = "div";
				}
				if (!self.options.itemTmpl || self.options.itemTmpl.length == 0) {
					self.options.itemTmpl = $("<" + wrapElement + ">" + self.getGridBody().html() + "</" + wrapElement
							+ ">");

				} else {
					self.options.itemTmpl = $("<" + wrapElement + ">" + self.options.itemTmpl.html() + "</"
							+ wrapElement + ">");
				}
				if (self.options.multiselect == true) {
					var checkAllBtn = $("<input type='checkbox'/>");
					checkAllBtn.click(function() {
						if ($(this).attr("checked")) {
							grid.find("._check_input").attr("checked", "checked");
						} else {
							grid.find("._check_input").removeAttr("checked");
						}
					})
					var th = $("<th style='width:12px;text-align:center;'></th>");
					th.append(checkAllBtn)
					thead.find("tr").prepend(th);
					//
					self.options.itemTmpl.find("tr").prepend("<td><input type='checkbox' class='_check_input' /></td>")
				}
				if (self.options.singleselect == true) {
					var th = $("<th style='width:12px;text-align:center;'></th>");
					thead.find("tr").prepend(th);
					//
					self.options.itemTmpl.find("tr").prepend(
							"<td><input type='radio' class='_single_check_input' name='_single_check_input_"
									+ grid.attr("id") + "'/></td>")
				}
				if (self.options.rownumbers == true) {
					var th = $("<th style='text-align:center;width:26px'></th>");
					thead.find("tr").prepend(th);
					//
					self.options.itemTmpl.find("tr").prepend("<td style='text-align:center;'>{{>_index}}</td>");
				}
				var ob = {};
				ob[self.options.id] = ek.decodeHTML(self.options.itemTmpl.html());
				$.templates(ob);
				self.options.gridComplete.call(self);
			},
			getGridBody : function() {
				var self = this;
				var grid = $(self.element);
				var tbody = grid.find("tbody");
				if (tbody.length == 0) {
					tbody = grid;
				}
				return tbody;
			},
			generatePager : function(p) {
				var self = this;
				var grid = $(self.element);
				if (self.options.autoScroll == true) {
					grid = grid.closest(".table-scrollable");
				}
				var $div = grid.next("div .pageContain");
				if ($div.length < 1) {
					$div = $("<div class='row pageContain'></div>")
					grid.after($div);
				}
				//
				var currentPage = p.page;
				var totalRecord = p.records;
				var pageSize = p.pageSize;
				var totalPage = p.total;
				var from = p.startIndex + 1;
				var to = p.startIndex + pageSize;
				if (to > totalRecord) {
					to = totalRecord;
				}

				var data = {
					"from" : from,
					"to" : to,
					"totalRecord" : totalRecord,
					"prevPage" : currentPage - 1,
					"nextPage" : currentPage + 1,
					"totalPage" : totalPage
				};
				var pages = [];
				if (currentPage > 2 && currentPage < (totalPage - 2)) {
					for (var n = 0; n < 5; n++) {
						pages[n] = {
							"index" : currentPage - 2 + n
						}
						if (n == 2) {
							pages[n].active = "active";
						}
					}
				} else {
					if (currentPage < 3) {
						for (var n = 0; n < Math.min(5, totalPage); n++) {
							var ob = {
								"index" : n + 1
							};
							if (currentPage == ob.index) {
								ob.active = "active"
							}
							pages.push(ob);
						}
					} else if (currentPage > (totalPage - 3)) {
						for (var n = 0; n < 5; n++) {
							var ob = {
								"index" : totalPage - 4 + n
							};
							if (currentPage == ob.index) {
								ob.active = "active"
							}
							pages.push(ob);
						}
					}
				}
				if (currentPage == 1) {
					data.b1 = "disabled";
					data.b2 = "disabled";
				}
				if (currentPage == totalPage) {
					data.b3 = "disabled";
					data.b4 = "disabled";
				}
				data.pages = pages;
				$div.html($("#tmpl-grid-page").render(data));

			},
			doSort : function(e) {
				e.closest("thead").find("span").empty();
				var sord = e.attr("sord");
				if ("asc" == sord) {
					sord = "desc";
				} else {
					sord = "asc";
				}
				e.attr("sord", sord);
				var sidx = e.closest("th").attr("sort");
				if (e.find("span").length == 0) {
					e.append("<span/>");
				}
				if ("asc" == sord) {
					e.find("span").html("▲");
				} else {
					e.find("span").html("▼");
				}
				var t = $(this.element);
				t.grid({
					sidx : sidx,
					sord : sord
				}).grid("load");
			},
			getRadioId : function() {
				var self = this;
				var grid = $(self.element);
				var id = null;
				var tr = self.getGridBody().find("input[class='_single_check_input']:checked").closest("tr");
				if (tr.length > 0) {
					id = tr.attr("data-id");
				}
				return id;
			},
			setRadioId : function(id) {
				var self = this;
				if (self.options.singleselect) {
					var grid = $(self.element);
					grid.find("tr[data-id='" + id + "']").find("input[class='_single_check_input']").attr("checked",
							true);
					self.highlightRow(self);
				}
			},
			clearRadio : function() {
				var self = this;
				var grid = $(self.element);
				grid.find("tr").removeClass("active");
				if (self.options.singleselect) {
					grid.find("input[class='_single_check_input']").attr("checked", false);
				}
			},
			getCheckedIds : function() {
				var self = this;
				var grid = $(self.element);
				var ids = [];
				self.getGridBody().find("input[class='_check_input']:checked").each(function() {
					var id = $(this).closest("tr").attr("data-id");
					if (id) {
						ids.push(id);
					}
				});
				return ids;
			},
			setCheckedIds : function(ids) {
				var self = this;
				if (self.options.multiselect) {
					var grid = $(self.element);
					for (var n = 0; n < ids.length; n++) {
						grid.find("tr[data-id='" + ids[n] + "']").find("input[class='_check_input']").attr("checked",
								true);
					}
					self.highlightRow(self);
				}
			},
			highlightRow : function(tr) {
				var self = this;
				var grid = $(self.element);
				var trs = grid.find("tr");
				trs.removeClass("active");
				if (self.options.multiselect == true) {
					grid.find("input[class='_check_input']:checked").each(function() {
						$(this).closest("tr").addClass("active");
					})
				} else {
					if (tr) {
						tr.addClass("active");
					}
				}
			},
			clearChecked : function() {
				var self = this;
				var grid = $(self.element);
				grid.find("tr").removeClass("active");
				if (self.options.multiselect) {
					grid.find("input[class='_check_input']").attr("checked", false);
				}
			},
			getRowDataById : function(rowId) {
				var self = this;
				if (self.options.data) {
					for (var n = 0; n < self.options.data.rows.length; n++) {
						if (rowId == self.options.data.rows[n]['id']) {
							return self.options.data.rows[n];
						}
					}
				}
				return null;
			},
			getCurrentRowId : function(el) {
				return $(el).closest("tr").attr("data-id");
			},
			getCurrentRowData : function(el) {
				var self = this;
				return self.getRowDataById(self.getCurrentRowId(el));
			},
			getUserdata : function() {
				var self = this;
				return self.options.userdata;
			}
		});

ek.doChangePage = function(ob, page) {
	var t = $(ob).closest("div .pageContain").prev(".ekGrid");
	if (t.length == 0) {
		t = $(ob).closest("div .pageContain").prev(".table-scrollable").find(".ekGrid");
	}
	t.grid({
		page : page
	}).grid("load");
}

ek.doChangeGridPageSize = function(ob) {
	var t = $(ob).closest("div .pageContain").prev(".ekGrid");
	if (t.length == 0) {
		t = $(ob).closest("div .pageContain").prev(".table-scrollable").find(".ekGrid");
	}
	t.grid({
		page : 1,
		rows : $(ob).val()
	}).grid("load");
}

function _buildPage(index, page) {
	if (index == page) {
		return "<span class='current'>" + index + "</span>";
	} else {
		return "<a href='###' onclick='doChangePage(this," + index + ")'>" + index + "</a>";
	}
}

function getName() {
	return "abc";
}