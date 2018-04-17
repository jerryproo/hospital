/*--传入宽度和高度弹出层--*/
function layer_show(w, h, title, url) {
	if (w == null || w == '') {
		w = 800;
	}
	;
	if (h == null || h == '') {
		h = ($(window).height() - 50);
	}
	;
	if (title == null || title == '') {
		title = false;
	}
	;
	if (url == null || url == '') {
		url = "404.html";
	}
	;
	layer.open({
		type : 2,
		title : title,
		maxmin : true,
		area : [ w + 'px', h + 'px' ],
		content : url,
		end : function() {

		}
	});
}
/*--使用form表单方法跳转新的页面 --*/
function openPost(URL, PARAMS) {
	var temp_form = document.createElement("form");
	temp_form.action = URL;
	temp_form.target = "_parent";
	temp_form.method = "post";
	temp_form.style.display = "none";
	for ( var x in PARAMS) {
		var opt = document.createElement("textarea");
		opt.name = x;
		opt.value = PARAMS[x];
		temp_form.appendChild(opt);
	}
	document.body.appendChild(temp_form);
	temp_form.submit();
}