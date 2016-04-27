var STICKIES = (function () {
	var initStickies = function initStickies() {
		$("<div />", { 
			text : "+", 
			"class" : "add-sticky",
			click : function () { createSticky(); }
		}).prependTo(document.body);
		initStickies = null;
		alert(typeof document.getElementsByClassName('add-sticky'))
	},
	openStickies = function openStickies() {
		initStickies && initStickies();
		for (var i = 0; i < localStorage.length; i++) {
			createSticky(JSON.parse(localStorage.getItem(localStorage.key(i))));
		}
	},
	createSticky = function createSticky(data) {
		data = data || { id : +new Date(), top : "40px", left : "40px", text : "Note Here" }
		
		return $("<div />", { 
			"class" : "sticky",
			'id' : data.id
			 })
			.prepend($("<div />", { "class" : "sticky-header"} )
				.append($("<span />", { 
					"class" : "sticky-status" 
				}))
				.append($("<span />", { 
					"class" : "close-sticky", 
					text : "trash", 
					click : function () { deleteSticky($(this).parents(".sticky").attr("id")); }
				}))
			)
			.append($("<div />", { 
				html : data.text, 
				contentEditable : true, 
				"class" : "sticky-content"
 			}))
		.draggable({ 
			handle : "div.sticky-header", 
			stack : ".sticky"
		 })
		.css({
			position: "absolute",
			"top" : data.top,
			"left": data.left
		})
		.appendTo(document.body);
	},
	deleteSticky = function deleteSticky(id) {
		localStorage.removeItem("sticky-" + id);
		$("#" + id).fadeOut(200, function () { $(this).remove(); });
	}
	return {
		open   : openStickies,
		init   : initStickies,
		"new"  : createSticky,
		remove : deleteSticky 
	};
}());
