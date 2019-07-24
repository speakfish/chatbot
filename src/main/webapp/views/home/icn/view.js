var checkin_object;
var _current_code;
$(function() {
	ek.getUserResource(function() {
		Metronic.init(); // init metronic core components
		Layout.init(); // init current layout
	});

	setTimeout(function() {
		ek.showWelcomePage();
	}, 200)
});