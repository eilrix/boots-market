

function get_oct_popup_found_cheaper(product_id) {
	setTimeout(function () {
		$.magnificPopup.open({
			tLoading: '<img src="catalog/view/theme/oct_techstore/image/ring-alt.svg" />',
			items: {
				src: 'index.php?route=extension/module/oct_popup_found_cheaper&product_id=' + product_id,
				type: 'ajax'
			},
			midClick: true,
			removalDelay: 200
		});
	}, 1);
}

function get_oct_popup_purchase(product_id) {
	setTimeout(function () {
		$.magnificPopup.open({
			tLoading: '<img src="catalog/view/theme/oct_techstore/image/ring-alt.svg" />',
			items: {
				src: 'index.php?route=extension/module/oct_popup_purchase&product_id=' + product_id,
				type: 'ajax'
			},
			midClick: true,
			removalDelay: 200
		});
	}, 1);
}

function get_oct_popup_subscribe() {
	$.magnificPopup.open({
		tLoading: '<img src="catalog/view/theme/oct_techstore/image/ring-alt.svg" />',
		items: {
			src: 'index.php?route=extension/module/oct_popup_subscribe',
			type: 'ajax'
		},
		midClick: true,
		removalDelay: 200
	});
}

function get_oct_popup_call_phone() {
	$.magnificPopup.open({
		tLoading: '<img src="catalog/view/theme/oct_techstore/image/ring-alt.svg" />',
		items: {
			src: 'index.php?route=extension/module/oct_popup_call_phone',
			type: 'ajax'
		},
		midClick: true,
		removalDelay: 200
	});
}

function get_oct_product_preorder(product_id) {
	$.magnificPopup.open({
		tLoading: '<img src="catalog/view/theme/oct_techstore/image/ring-alt.svg" />',
		items: {
			src: 'index.php?route=extension/module/oct_product_preorder&product_id=' + product_id,
			type: 'ajax'
		},
		midClick: true,
		removalDelay: 200
	});
}

function oct_get_product_id(data) {
	var product_id = 0;
	var arr = data.split("&");

	for (var i = 0; i < arr.length; i++) {
		var product_id = arr[i].split("=");
		if (product_id[0] === "product_id") {
			return product_id[1];
		}
	}
}

function get_oct_popup_product_options(product_id) {
	$.magnificPopup.open({
		tLoading: '<img src="catalog/view/theme/oct_techstore/image/ring-alt.svg" />',
		items: {
			src: "index.php?route=extension/module/oct_popup_product_options&product_id=" + product_id,
			type: "ajax"
		},
		midClick: true,
		removalDelay: 200
	});
}

function get_oct_popup_product_view(product_id) {
	$.magnificPopup.open({
		tLoading: '<img src="catalog/view/theme/oct_techstore/image/ring-alt.svg" />',
		items: {
			src: "index.php?route=extension/module/oct_popup_view&product_id=" + product_id,
			type: "ajax"
		},
		midClick: true,
		removalDelay: 200
	});
}

function get_oct_popup_login() {
	$.magnificPopup.open({
		tLoading: '<img src="catalog/view/theme/oct_techstore/image/ring-alt.svg" />',
		items: {
			src: "index.php?route=extension/module/oct_popup_login",
			type: "ajax"
		},
		midClick: true,
		removalDelay: 200
	});
}
var flagFirst = false;
var flagSecond = false;
function get_oct_popup_add_to_wishlist(product_id) {
	$.ajax({
		url: "index.php?route=account/wishlist/add",
		type: "post",
		data: "product_id=" + product_id,
		dataType: "json",
		success: function (json) {
            $('#prodAddedToWishlist').css({'display':'block'});
            $('#CloseProdAddedToWishlist').on('click',()=>{
                event.stopPropagation();
                $('#prodAddedToWishlist').css({'display':'none'});
			})
            if (flagFirst) flagSecond = true;
            if (!flagFirst) flagFirst = true;

            setTimeout( ()=> {
            	if (!flagSecond){
                $('#prodAddedToWishlist').css({'display':'none'});
                flagFirst = false;
                flagSecond = false;
			}
            if (flagSecond){
                flagSecond = false;
			}

        }, 3000);


            $.ajax({
				url: 'index.php?route=extension/module/oct_page_bar/update_html',
				type: 'get',
				dataType: 'json',
				success: function (json) {
					$("#oct-favorite-quantity").html(json['total_wishlist']);
				}
			});

		},
		error: function (xhr, ajaxOptions, thrownError) {
			alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		}
	});
}

function remove_wishlist(product_id) {
	$.ajax({
		url: "index.php?route=extension/module/oct_page_bar/remove_wishlist&remove=" + product_id,
		type: "get",
		dataType: "json",
		success: function (json) {
			$.ajax({
				url: 'index.php?route=extension/module/oct_page_bar/update_html',
				type: 'get',
				dataType: 'json',
				success: function (json) {
					$("#oct-favorite-quantity").html(json['total_wishlist']);
				}
			});

			$('#oct-favorite-content').load('index.php?route=extension/module/oct_page_bar/block_wishlist');
		},
		error: function (xhr, ajaxOptions, thrownError) {
			alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		}
	});
}

function get_oct_popup_add_to_compare(product_id) {
	$.ajax({
		url: "index.php?route=product/compare/add",
		type: "post",
		data: "product_id=" + product_id,
		dataType: "json",
		success: function (json) {
			$.magnificPopup.open({
				tLoading: '<img src="catalog/view/theme/oct_techstore/image/ring-alt.svg" />',
				items: {
					src: "index.php?route=extension/module/oct_popup_add_to_compare&product_id=" + product_id,
					type: "ajax"
				},
				midClick: true,
				removalDelay: 200
			});

			$("#compare-total").html(json['total']);

			$.ajax({
				url: 'index.php?route=extension/module/oct_page_bar/update_html',
				type: 'get',
				dataType: 'json',
				success: function (json) {
					$("#oct-compare-quantity").html(json['total_compare']);
				}
			});
		},
		error: function (xhr, ajaxOptions, thrownError) {
			alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		}
	});
}

function remove_compare(product_id) {
	$.ajax({
		url: "index.php?route=extension/module/oct_page_bar/remove_compare&remove=" + product_id,
		type: "get",
		dataType: "json",
		success: function (json) {
			$.ajax({
				url: 'index.php?route=extension/module/oct_page_bar/update_html',
				type: 'get',
				dataType: 'json',
				success: function (json) {
					$("#oct-compare-quantity").html(json['total_compare']);
				}
			});

			$('#oct-compare-content').load('index.php?route=extension/module/oct_page_bar/block_compare');
		},
		error: function (xhr, ajaxOptions, thrownError) {
			alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		}
	});
}

function get_oct_popup_cart() {
	$.magnificPopup.open({
		tLoading: '<img src="catalog/view/theme/oct_techstore/image/ring-alt.svg" />',
		items: {
			src: "index.php?route=extension/module/oct_popup_cart",
			type: "ajax"
		},
		midClick: !0,
		removalDelay: 200
	})
}

function get_oct_popup_add_to_cart(product_id, quantity) {
	$.ajax({
		url: "index.php?route=checkout/cart/add",
		type: "post",
		data: "product_id=" + product_id + "&quantity=" + ("undefined" != typeof quantity ? quantity : 1),
		dataType: "json",
		success: function (json) {
			if (json['redirect']) {
				location = json['redirect'];
			}

			if (json['success']) {
				// $.magnificPopup.open({
				//   tLoading: '<img src="catalog/view/theme/oct_techstore/image/ring-alt.svg" />',
				//   items: {
				//    src: "index.php?route=extension/module/oct_popup_add_to_cart&product_id=" + product_id,
				//    type: "ajax"
				//   },
				// midClick: true,
				// removalDelay: 200
				// });

				get_oct_popup_cart();

				$("#cart-total").html(json['total']);
				$('#cart > ul').load('index.php?route=common/cart/info ul li');

				$.ajax({
					url: 'index.php?route=extension/module/oct_page_bar/update_html',
					type: 'get',
					dataType: 'json',
					success: function (json) {
						$("#oct-bottom-cart-quantity").html(json['total_cart']);
					}
				});
			}
		},
		error: function (xhr, ajaxOptions, thrownError) {
			alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		}
	});
}

function validate(input) {
	input.value = input.value.replace(/[^\d,]/g, '');
}

function doLiveSearch(a, b) {
	return 38 != a.keyCode && 40 != a.keyCode && ($("#livesearch_search_results").remove(), updown = -1, !("" == b || b.length < 3 || (b = encodeURI(b), $.ajax({
		url: $("base").attr("href") + "index.php?route=product/search/ajax&keyword=" + b + "&filter_category_id=" + $('#search input[name=category_id]').val(),
		dataType: "json",
		success: function (a) {
			if (a.length > 0) {
				var c = document.createElement("ul");
				c.id = "livesearch_search_results";
				var d, e;
				for (var f in a) {
					if (d = document.createElement("li"), eListHr = document.createElement("hr"), eListDiv = document.createElement("div"), eListDiv.setAttribute("style", "height: 10px; clear: both;"), eListDivpr = document.createElement("span"), eListDivpr.innerHTML = (a[f].price) ? a[f].price : '', eListDivpr.setAttribute("style", "height: 14px; color: #147927;"), eListDivprspec = document.createElement("span"), eListDivprspec.innerHTML = a[f].special, eListDivprspec.setAttribute("style", "font-weight: bold; margin-left: 8px; color: #a70d0d; font-size: 16px;"), eListImg = document.createElement("img"), eListImg.src = a[f].image, eListImg.setAttribute("style", "margin-right: 10px;"), eListImg.align = "left", eListDivstatus = document.createElement("span"), eListDivstatus.innerHTML = a[f].stock, eListDivstatus.setAttribute("style", "height: 14px; color: #337ab7; margin-left: 15px; font-weight: bold;"), e = document.createElement("a"), e.setAttribute("style", "display: block;"), e.appendChild(document.createTextNode(a[f].name)), "undefined" != typeof a[f].href) {
						"" != a[f].special && eListDivpr.setAttribute("style", "text-decoration: line-through;");
						var g = decodeURIComponent(a[f].href);
						
						e.href = g.replace('&amp;', "&");
					} else e.href = $("base").attr("href") + "index.php?route=product/product&product_id=" + a[f].product_id + "&keyword=" + b;
					d.appendChild(e), c.appendChild(eListImg), c.appendChild(d), c.appendChild(eListDivpr), "" != a[f].special && c.appendChild(eListDivprspec), c.appendChild(eListDivstatus), c.appendChild(eListHr), c.appendChild(eListDiv)
				}
				$("#livesearch_search_results").length > 0 && $("#livesearch_search_results").remove(), $("#search").append(c), $("#livesearch_search_results").css("display", "none"), $("#livesearch_search_results").slideDown("slow"), $("#livesearch_search_results").animate({
					backgroundColor: "rgba(255, 255, 255, 0.98)"
				}, 2e3)
			}
		}
	}), 0)))
}

function doLiveSearchMobile(ev, keywords) {
	if (ev.keyCode == 38 || ev.keyCode == 40) {
		return false;
	}

	$('#livesearch_search_results').remove();
	updown = -1;

	if (keywords == '' || keywords.length < 3) {
		return false;
	}
	keywords = encodeURI(keywords);

	$.ajax({
		url: $('base').attr('href') + 'index.php?route=product/search/ajax&keyword=' + keywords,
		dataType: 'json',
		success: function (result) {
			if (result.length > 0) {
				var eList = document.createElement('ul');
				eList.id = 'msearchresults';
				var eListElem;
				var eLink;
				for (var i in result) {
					eListElem = document.createElement('li');

					eListDiv = document.createElement('div');
					eListDiv.setAttribute("style", "height: 10px; clear: both;");

					eListDivpr = document.createElement("span");
					eListDivpr.innerHTML = result[i].price;
					eListDivpr.setAttribute("style", "height: 14px; color: #147927;");
					"" != result[i].special && eListDivpr.setAttribute("style", "text-decoration: line-through;");

					eListDivprspec = document.createElement("span");
					eListDivprspec.innerHTML = result[i].special;
					eListDivprspec.setAttribute("style", "font-weight: bold; margin-left: 8px; color: #a70d0d; font-size: 16px;");

					eListDivstatus = document.createElement("span");
					eListDivstatus.innerHTML = result[i].stock;
					eListDivstatus.setAttribute("style", "height: 14px; color: #337ab7; margin-left: 15px; font-weight: bold;");

					eListImg = document.createElement('img');
					eListImg.src = result[i].image;
					eListImg.setAttribute("style", "margin-right: 10px;");
					eListImg.align = 'left';

					eLink = document.createElement('a');
					eLink.setAttribute("style", "display: block;");
					eLink.appendChild(document.createTextNode(result[i].name));
					if (typeof (result[i].href) != 'undefined') {
						var convertlink = decodeURIComponent(result[i].href);
						eLink.href = convertlink.replace('&amp;', "&");

					} else {
						eLink.href = $('base').attr('href') + 'index.php?route=product/product&product_id=' + result[i].product_id + '&keyword=' + keywords;
					}
					eListElem.appendChild(eLink);
					eList.appendChild(eListImg);
					eList.appendChild(eListElem);
					eList.appendChild(eListDivpr);
					"" != result[i].special && eList.appendChild(eListDivprspec);
					eList.appendChild(eListDivstatus);
					eList.appendChild(eListDiv);
				}
				if ($('#msearchresults').length > 0) {
					$('#msearchresults').remove();
				}
				$('#searchm').append(eList);
			}
		}
	});

	return true;
}

function upDownEvent(a) {
	var b = document.getElementById("livesearch_search_results");
	if ($("#search").find("[name=search]").first(), b) {
		var c = b.childNodes.length - 1;
		if (updown != -1 && "undefined" != typeof b.childNodes[updown] && $(b.childNodes[updown]).removeClass("highlighted"), 38 == a.keyCode ? updown = updown > 0 ? --updown : updown : 40 == a.keyCode && (updown = updown < c ? ++updown : updown), updown >= 0 && updown <= c) {
			$(b.childNodes[updown]).addClass("highlighted");
			var d = b.childNodes[updown].childNodes[0].text;
			"undefined" == typeof d && (d = b.childNodes[updown].childNodes[0].innerText), $("#search").find("[name=search]").first().val(new String(d).replace(/(\s\(.*?\))$/, ""))
		}
	}
	return !1
}

function viewport() {
	var e = window,
		a = 'inner';
	if (!('innerWidth' in window)) {
		a = 'client';
		e = document.documentElement || document.body;
	}
	return {
		width: e[a + 'Width'],
		height: e[a + 'Height']
	};
}

function hidePanel() {
	$('#hide-slide-panel').fadeOut();
	$('#oct-slide-panel .oct-slide-panel-content').removeClass('oct-slide-panel-content-opened');
	$('#oct-bluring-box').removeClass('oct-bluring');
	$('.oct-slide-panel-item-content').removeClass('oct-panel-active');
	$('.oct-panel-link-active').removeClass('oct-panel-link-active');
}

$(document).ready(function () {
	
	var menuResp = viewport().width;
	
	var sheight = $(window).height();
	
	if (menuResp <= 992) {
		$("#menu-mobile-box").prepend( $( "#menu" ) );
	} else {
		$('ul.menu.flex').flexMenu();
		$("ul.flexMenu-popup").mouseleave(function() {
			$(".flexMenu-popup").css("display", "none");
		});
	}
	
	$('#menu-mobile-toggle').on('click', function() {
		$('#menu-mobile').slideToggle(50, "swing");
		$('html').toggleClass('noscroll');
		$('#oct-bluring-box').css("height",sheight);
	});
	
	$('.megamenu-toggle-a').on('click', function() {
		$(this).parent().toggleClass("open");
	});
	
	$(".parent-title-toggle").on("click", function(t) {
		$(this).toggleClass("opened"), $(this).next().toggleClass("megamenu-ischild-opened"), t.preventDefault(), t.stopPropagation()
	});
		
	$("#menu .navbar-header").on("click", function(t) {
		$(this).next().toggleClass("in"), t.preventDefault(), t.stopPropagation()
	});
	
	$("#back-top").hide(), $(function () {
		$(window).scroll(function () {
			$(this).scrollTop() > 450 ? $("#back-top").fadeIn() : $("#back-top").fadeOut()
		}), $("#back-top a").click(function () {
			return $("body,html").animate({
				scrollTop: 0
			}, 800), !1
		})
	});
	
	$("#search").find("[name=search]").first().keyup(function (a) {
		doLiveSearch(a, this.value)
	}).focus(function (a) {
		doLiveSearch(a, this.value)
	}).keydown(function (a) {
		upDownEvent(a)
	}).blur(function () {
		window.setTimeout("$('#livesearch_search_results').remove();updown=0;", 1500)
	}), $(document).bind("keydown", function (a) {
		try {
			13 == a.keyCode && $(".highlighted").length > 0 && (document.location.href = $(".highlighted").find("a").first().attr("href"))
		} catch (a) {}
	});

	$('.navbar-nav > li > .dropdown-toggle').click(function () {
		if ($(this).attr('href') === undefined) {
			//return false;
		} else {
			window.location = $(this).attr('href');
		}
	});

	$("#msrch").find("[name=search]").first().keyup(function (ev) {
		doLiveSearchMobile(ev, this.value);
	}).focus(function (ev) {
		doLiveSearchMobile(ev, this.value);
	}).keydown(function (ev) {
		upDownEvent(ev);
	}).blur(function () {});
	$(document).bind('keydown', function (ev) {
		try {
			if (ev.keyCode == 13 && $('.highlighted').length > 0) {
				document.location.href = $('.highlighted').find('a').first().attr('href');
			}
		} catch (e) {}
	});

	$('#oct-m-search-button').on('click', function () {
		srchurl = $('base').attr('href') + 'index.php?route=product/search';
		var input_value = $('input[name=\'search\']').val();
		if (input_value.length <= 0) {
			return false;
		}
		if (input_value) {
			srchurl += '&search=' + encodeURIComponent(input_value);
		}
		location = srchurl;
	});
	
	$("#oct-mobile-search-box input[name='search']").on("keydown", function (a) {
		if (13 == a.keyCode) {
			var b = $("input[name='search']").val();
			if (b.length <= 0) return !1;
			$("#oct-m-search-button").trigger("click");
		}
	});

	$("#oct-search-button").on("click", function () {
		srchurl = $("base").attr("href") + "index.php?route=product/search";
		var a = $("#search input[name='search']").val();
		if (a.length <= 0) return !1;
		a && (srchurl += "&search=" + encodeURIComponent(a));
		var b = $("input[name='category_id']").prop("value");
		b > 0 && (srchurl += "&sub_category=true&category_id=" + encodeURIComponent(b)), location = srchurl
	});
	
	$("#search input[name='search']").on("keydown", function (a) {
		if (13 == a.keyCode) {
			var b = $("input[name='search']").val();
			if (b.length <= 0) return !1;
			$("#oct-search-button").trigger("click");
		}
	});
	
	$("#search a").on('click', function () {
		$(".cats-button").html('<span class="category-name">' + $(this).html() + ' </span><i class="fa fa-caret-down" aria-hidden="true"></i>');
		$(".selected_oct_cat").val($(this).attr("id"));
	});


	$('#search .dropdown').on('click', function () {
		$(this).toggleClass('open-dropdown');
	});

	$("#search .dropdown").mouseleave(function () {
		$(this).removeClass('open-dropdown');
	});


	$('.thumbnails a').on('click', function (e) {
		$(".thumbnails a").removeClass("selected-thumb");
		$(this).addClass("selected-thumb");
	});

	//cat-menu
	$('#sstore-3-level li.active').addClass('open').children('ul').show();
	$('#sstore-3-level li.has-sub>a.toggle-a').on('click', function () {
		$(this).removeAttr('href');
		var element = $(this).parent('li');
		if (element.hasClass('open')) {
			element.removeClass('open');
			element.find('li').removeClass('open');
			element.find('ul').slideUp(200);
		} else {
			element.addClass('open');
			element.children('ul').slideDown(200);
			element.siblings('li').children('ul').slideUp(200);
			element.siblings('li').removeClass('open');
			element.siblings('li').find('li').removeClass('open');
			element.siblings('li').find('ul').slideUp(200);
		}
	});

	var url = document.location.toString();
	$("a").filter(function () {
		return url.indexOf(this.href) != -1;
	}).addClass("current-link");

	// bottom-slide-panel
	$('.oct-panel-link').on('click', function () {
		if ($(this).parent().hasClass('oct-panel-link-active')) {
			$(this).parent().removeClass('oct-panel-link-active');
			hidePanel();
		} else {
			$('#hide-slide-panel').fadeIn();
			$("#oct-bluring-box").addClass('oct-bluring');
			$("#oct-slide-panel .oct-slide-panel-content").addClass('oct-slide-panel-content-opened');
			$('.oct-slide-panel-heading > .container > div').removeClass('oct-panel-link-active');
			$(this).parent().addClass('oct-panel-link-active');
			$('.oct-slide-panel-item-content').removeClass('oct-panel-active');
			var linkId = $(this).parent()[0].id;
			if (linkId === 'oct-last-seen-link') {
				$('#oct-last-seen-content').toggleClass('oct-panel-active').load('index.php?route=extension/module/oct_page_bar/block_viewed');
			} else if (linkId === 'oct-favorite-link') {
				$('#oct-favorite-content').toggleClass("oct-panel-active").load('index.php?route=extension/module/oct_page_bar/block_wishlist');
			} else if (linkId === 'oct-compare-link') {
				$('#oct-compare-content').toggleClass("oct-panel-active").load('index.php?route=extension/module/oct_page_bar/block_compare');
			} else if (linkId === 'oct-bottom-cart-link') {
				$('#oct-bottom-cart-content').toggleClass("oct-panel-active").load('index.php?route=extension/module/oct_page_bar/block_cart');
			}
		}
	});

    $('#oct-favorite-link-top').on('click', function () {
        event.stopPropagation();
        $('#hide-slide-panel').fadeIn();
        $("#oct-bluring-box").addClass('oct-bluring');
        $("#oct-slide-panel .oct-slide-panel-content").addClass('oct-slide-panel-content-opened');
        $('.oct-slide-panel-heading > .container > div').removeClass('oct-panel-link-active');
        //$(this).parent().addClass('oct-panel-link-active');
        $('.oct-slide-panel-item-content').removeClass('oct-panel-active');$('#oct-favorite-content').toggleClass("oct-panel-active").load('index.php?route=extension/module/oct_page_bar/block_wishlist');

    });

    $('#oct-favorite-link-header').on('click', function () {
        event.stopPropagation();
        $('#hide-slide-panel').fadeIn();
        $("#oct-bluring-box").addClass('oct-bluring');
        $("#oct-slide-panel .oct-slide-panel-content").addClass('oct-slide-panel-content-opened');
        $('.oct-slide-panel-heading > .container > div').removeClass('oct-panel-link-active');
        //$(this).parent().addClass('oct-panel-link-active');
        $('.oct-slide-panel-item-content').removeClass('oct-panel-active');
        $('#oct-favorite-content').toggleClass("oct-panel-active").load('index.php?route=extension/module/oct_page_bar/block_wishlist');

    });

    $('#oct-lastseen-link-header').on('click', function () {
        event.stopPropagation();
        $('#hide-slide-panel').fadeIn();
        $("#oct-bluring-box").addClass('oct-bluring');
        $("#oct-slide-panel .oct-slide-panel-content").addClass('oct-slide-panel-content-opened');
        $('.oct-slide-panel-heading > .container > div').removeClass('oct-panel-link-active');
        //$(this).parent().addClass('oct-panel-link-active');
        $('.oct-slide-panel-item-content').removeClass('oct-panel-active');
        $('#oct-last-seen-content').toggleClass('oct-panel-active').load('index.php?route=extension/module/oct_page_bar/block_viewed');

    });
    $('#prodAddedToWishlist').on('click', function () {
        event.stopPropagation();
        $('#hide-slide-panel').fadeIn();
        $("#oct-bluring-box").addClass('oct-bluring');
        $("#oct-slide-panel .oct-slide-panel-content").addClass('oct-slide-panel-content-opened');
        $('.oct-slide-panel-heading > .container > div').removeClass('oct-panel-link-active');
        //$(this).parent().addClass('oct-panel-link-active');
        $('.oct-slide-panel-item-content').removeClass('oct-panel-active');
        $('#oct-favorite-content').toggleClass("oct-panel-active").load('index.php?route=extension/module/oct_page_bar/block_wishlist');

    });

	document.getElementById('oct-bluring-box').addEventListener('click', hidePanel);
    document.getElementById('hide-slide-panel').addEventListener('click', hidePanel);

    let seachInputStr = document.querySelector('#search .input-lg');
    seachInputStr.addEventListener('click', ()=>{
        event.stopPropagation();
})
    seachInputStr.addEventListener('focus', ()=>{
        event.stopPropagation();
//$("#search .input-lg").addClass('bluring-search');
    seachInputStr.style.position = 'absolute';
    seachInputStr.style.zIndex = '9999';
    seachInputStr.style.width = '30vw';
    $("#oct-bluring-box").addClass('oct-bluring');

});
    document.querySelector('#search .input-lg').addEventListener('blur', ()=>{
       // $("#search .input-lg").removeClass('bluring-search');
        seachInputStr.style.position = 'static';
    seachInputStr.style.zIndex = '1';
    seachInputStr.style.width = '100%';
});


	$('#oct-bluring-box, #hide-slide-panel').click(function () {
		hidePanel();
	});

	$('#info-mobile-toggle').on('click', function () {
		$('#info-mobile').slideToggle(50, "swing");
		$('html').toggleClass('noscroll');
	});
	$('#search-mobile-toggle').on('click', function () {
		$('.oct-m-search').slideToggle(50, "swing");
		$('html').toggleClass('noscroll');
	});

	$('#oct-menu-box').css('overflow', 'visible');

});


$(function () {
	
	var sheight = $(window).height();

	$('.dropdown-menu button').click(function (e) {
		e.stopPropagation();
	});


	var sulheight = $(window).height() - 58;
	var m4 = viewport().width;
	var $fclone = $('.footer-contacts-ul').clone();

	$(".closempanel").click(function () {
		$(".m-panel-box").fadeOut("fast");
		$('#oct-bluring-box').removeAttr("style");
		$('html').removeClass('noscroll');
	});

	if (m4 <= 992) {
		$('#m-wishlist').append($('#oct-favorite-quantity'));
		$('#m-compare').append($('#oct-compare-quantity'));
		$('#m-cart').append($('#oct-bottom-cart-quantity'));
		$('.product-thumb').bind('touchmove', true);
		$(".product-buttons-box a").removeAttr("data-toggle");
		$('#info-mobile-box').html($fclone);
		$('#info-mobile ul').prepend($('.top-left-info-links li'));
		$('#oct-mobile-search-box, #menu-mobile-box, #info-mobile-box').css("height", sulheight);
		$('#info-mobile .footer-contacts-ul').prepend($('#language'));
		$('#info-mobile .footer-contacts-ul').prepend($('#currency'));
	} else {
		$('ul.menu.flex').flexMenu();
	}

	if (m4 < 768) {
		$('.content-row .left-info').prepend($('.product-header'));
		$('#content').prepend($('.oct-news-panel'));

		$('footer .third-row .h5').on('click', function () {
			$(this).next().slideToggle();
			$(this).toggleClass('open');
		});
	}

	$(window).on('resize', function () {
		var win = $(this);
		if (win.width() <= 992) {
			$('#m-wishlist').append($('#oct-favorite-quantity'));
			$('#m-compare').append($('#oct-compare-quantity'));
			$('#m-cart').append($('#oct-bottom-cart-quantity'));
			$('#info-mobile-box').html($fclone);
			$('#info-mobile ul').append($('.top-left-info-links li.apppli'));
			$('#info-mobile .footer-contacts-ul').prepend($('#language'));
			$('#info-mobile .footer-contacts-ul').prepend($('#currency'));
			$("#menu-mobile-box").prepend($("#menu"));
			var sulheight = $(window).height() - 58; 
			$('#oct-mobile-search-box, #menu-mobile-box, #info-mobile-box').css("height", sulheight);
		} else {
			$('#oct-favorite-link .oct-panel-link').append($('#oct-favorite-quantity'));
			$('#oct-compare-link .oct-panel-link').append($('#oct-compare-quantity'));
			$('#oct-bottom-cart-link .oct-panel-link').append($('#oct-bottom-cart-quantity'));
			$('#top-left-links ul').append($('#info-mobile ul li.apppli'));
			$('.language-currency').prepend($('#currency'));
			$('.language-currency').prepend($('#language'));
			$("#oct-menu-box").prepend($("#menu"));
			$('ul.menu.flex').flexMenu();
			var sulheight = $(window).height() - 58; 
			$('#oct-mobile-search-box, #menu-mobile-box, #info-mobile-box').css("height", sulheight);
		}

		if (win.width() < 768) {
			$('.content-row .left-info').prepend($('.product-header'));
		} else {
			$('#product-info-right').prepend($('.product-header'));
		}
	});
});

jQuery.browser = {};
(function () {
	jQuery.browser.msie = false;
	jQuery.browser.version = 0;

	if (navigator.userAgent.match(/MSIE ([0-9]+)\./)) {
		jQuery.browser.msie = true;
		jQuery.browser.version = RegExp.$1;
	}
})();






/*!
 * classie - class helper functions
 * from bonzo https://github.com/ded/bonzo
 *
 * classie.has( elem, 'my-class' ) -> true/false
 * classie.add( elem, 'my-new-class' )
 * classie.remove( elem, 'my-unwanted-class' )
 * classie.toggle( elem, 'my-class' )
 */

/*jshint browser: true, strict: true, undef: true */
/*global define: false */

( function( window ) {

    'use strict';

// class helper functions from bonzo https://github.com/ded/bonzo

    function classReg( className ) {
        return new RegExp("(^|\\s+)" + className + "(\\s+|$)");
    }

// classList support for class management
// altho to be fair, the api sucks because it won't accept multiple classes at once
    var hasClass, addClass, removeClass;

    if ( 'classList' in document.documentElement ) {
        hasClass = function( elem, c ) {
            return elem.classList.contains( c );
        };
        addClass = function( elem, c ) {
            elem.classList.add( c );
        };
        removeClass = function( elem, c ) {
            elem.classList.remove( c );
        };
    }
    else {
        hasClass = function( elem, c ) {
            return classReg( c ).test( elem.className );
        };
        addClass = function( elem, c ) {
            if ( !hasClass( elem, c ) ) {
                elem.className = elem.className + ' ' + c;
            }
        };
        removeClass = function( elem, c ) {
            elem.className = elem.className.replace( classReg( c ), ' ' );
        };
    }

    function toggleClass( elem, c ) {
        var fn = hasClass( elem, c ) ? removeClass : addClass;
        fn( elem, c );
    }

    var classie = {
        // full names
        hasClass: hasClass,
        addClass: addClass,
        removeClass: removeClass,
        toggleClass: toggleClass,
        // short names
        has: hasClass,
        add: addClass,
        remove: removeClass,
        toggle: toggleClass
    };

// transport
    if ( typeof define === 'function' && define.amd ) {
        // AMD
        define( classie );
    } else {
        // browser global
        window.classie = classie;
    }

})( window );


;window.Modernizr=function(a,b,c){function x(a){j.cssText=a}function y(a,b){return x(prefixes.join(a+";")+(b||""))}function z(a,b){return typeof a===b}function A(a,b){return!!~(""+a).indexOf(b)}function B(a,b){for(var d in a){var e=a[d];if(!A(e,"-")&&j[e]!==c)return b=="pfx"?e:!0}return!1}function C(a,b,d){for(var e in a){var f=b[a[e]];if(f!==c)return d===!1?a[e]:z(f,"function")?f.bind(d||b):f}return!1}function D(a,b,c){var d=a.charAt(0).toUpperCase()+a.slice(1),e=(a+" "+n.join(d+" ")+d).split(" ");return z(b,"string")||z(b,"undefined")?B(e,b):(e=(a+" "+o.join(d+" ")+d).split(" "),C(e,b,c))}var d="2.8.3",e={},f=!0,g=b.documentElement,h="modernizr",i=b.createElement(h),j=i.style,k,l={}.toString,m="Webkit Moz O ms",n=m.split(" "),o=m.toLowerCase().split(" "),p={},q={},r={},s=[],t=s.slice,u,v={}.hasOwnProperty,w;!z(v,"undefined")&&!z(v.call,"undefined")?w=function(a,b){return v.call(a,b)}:w=function(a,b){return b in a&&z(a.constructor.prototype[b],"undefined")},Function.prototype.bind||(Function.prototype.bind=function(b){var c=this;if(typeof c!="function")throw new TypeError;var d=t.call(arguments,1),e=function(){if(this instanceof e){var a=function(){};a.prototype=c.prototype;var f=new a,g=c.apply(f,d.concat(t.call(arguments)));return Object(g)===g?g:f}return c.apply(b,d.concat(t.call(arguments)))};return e}),p.cssanimations=function(){return D("animationName")};for(var E in p)w(p,E)&&(u=E.toLowerCase(),e[u]=p[E](),s.push((e[u]?"":"no-")+u));return e.addTest=function(a,b){if(typeof a=="object")for(var d in a)w(a,d)&&e.addTest(d,a[d]);else{a=a.toLowerCase();if(e[a]!==c)return e;b=typeof b=="function"?b():b,typeof f!="undefined"&&f&&(g.className+=" "+(b?"":"no-")+a),e[a]=b}return e},x(""),i=k=null,function(a,b){function l(a,b){var c=a.createElement("p"),d=a.getElementsByTagName("head")[0]||a.documentElement;return c.innerHTML="x<style>"+b+"</style>",d.insertBefore(c.lastChild,d.firstChild)}function m(){var a=s.elements;return typeof a=="string"?a.split(" "):a}function n(a){var b=j[a[h]];return b||(b={},i++,a[h]=i,j[i]=b),b}function o(a,c,d){c||(c=b);if(k)return c.createElement(a);d||(d=n(c));var g;return d.cache[a]?g=d.cache[a].cloneNode():f.test(a)?g=(d.cache[a]=d.createElem(a)).cloneNode():g=d.createElem(a),g.canHaveChildren&&!e.test(a)&&!g.tagUrn?d.frag.appendChild(g):g}function p(a,c){a||(a=b);if(k)return a.createDocumentFragment();c=c||n(a);var d=c.frag.cloneNode(),e=0,f=m(),g=f.length;for(;e<g;e++)d.createElement(f[e]);return d}function q(a,b){b.cache||(b.cache={},b.createElem=a.createElement,b.createFrag=a.createDocumentFragment,b.frag=b.createFrag()),a.createElement=function(c){return s.shivMethods?o(c,a,b):b.createElem(c)},a.createDocumentFragment=Function("h,f","return function(){var n=f.cloneNode(),c=n.createElement;h.shivMethods&&("+m().join().replace(/[\w\-]+/g,function(a){return b.createElem(a),b.frag.createElement(a),'c("'+a+'")'})+");return n}")(s,b.frag)}function r(a){a||(a=b);var c=n(a);return s.shivCSS&&!g&&!c.hasCSS&&(c.hasCSS=!!l(a,"article,aside,dialog,figcaption,figure,footer,header,hgroup,main,nav,section{display:block}mark{background:#FF0;color:#000}template{display:none}")),k||q(a,c),a}var c="3.7.0",d=a.html5||{},e=/^<|^(?:button|map|select|textarea|object|iframe|option|optgroup)$/i,f=/^(?:a|b|code|div|fieldset|h1|h2|h3|h4|h5|h6|i|label|li|ol|p|q|span|strong|style|table|tbody|td|th|tr|ul)$/i,g,h="_html5shiv",i=0,j={},k;(function(){try{var a=b.createElement("a");a.innerHTML="<xyz></xyz>",g="hidden"in a,k=a.childNodes.length==1||function(){b.createElement("a");var a=b.createDocumentFragment();return typeof a.cloneNode=="undefined"||typeof a.createDocumentFragment=="undefined"||typeof a.createElement=="undefined"}()}catch(c){g=!0,k=!0}})();var s={elements:d.elements||"abbr article aside audio bdi canvas data datalist details dialog figcaption figure footer header hgroup main mark meter nav output progress section summary template time video",version:c,shivCSS:d.shivCSS!==!1,supportsUnknownElements:k,shivMethods:d.shivMethods!==!1,type:"default",shivDocument:r,createElement:o,createDocumentFragment:p};a.html5=s,r(b)}(this,b),e._version=d,e._domPrefixes=o,e._cssomPrefixes=n,e.testProp=function(a){return B([a])},e.testAllProps=D,e.prefixed=function(a,b,c){return b?D(a,b,c):D(a,"pfx")},g.className=g.className.replace(/(^|\s)no-js(\s|$)/,"$1$2")+(f?" js "+s.join(" "):""),e}(this,this.document),function(a,b,c){function d(a){return"[object Function]"==o.call(a)}function e(a){return"string"==typeof a}function f(){}function g(a){return!a||"loaded"==a||"complete"==a||"uninitialized"==a}function h(){var a=p.shift();q=1,a?a.t?m(function(){("c"==a.t?B.injectCss:B.injectJs)(a.s,0,a.a,a.x,a.e,1)},0):(a(),h()):q=0}function i(a,c,d,e,f,i,j){function k(b){if(!o&&g(l.readyState)&&(u.r=o=1,!q&&h(),l.onload=l.onreadystatechange=null,b)){"img"!=a&&m(function(){t.removeChild(l)},50);for(var d in y[c])y[c].hasOwnProperty(d)&&y[c][d].onload()}}var j=j||B.errorTimeout,l=b.createElement(a),o=0,r=0,u={t:d,s:c,e:f,a:i,x:j};1===y[c]&&(r=1,y[c]=[]),"object"==a?l.data=c:(l.src=c,l.type=a),l.width=l.height="0",l.onerror=l.onload=l.onreadystatechange=function(){k.call(this,r)},p.splice(e,0,u),"img"!=a&&(r||2===y[c]?(t.insertBefore(l,s?null:n),m(k,j)):y[c].push(l))}function j(a,b,c,d,f){return q=0,b=b||"j",e(a)?i("c"==b?v:u,a,b,this.i++,c,d,f):(p.splice(this.i++,0,a),1==p.length&&h()),this}function k(){var a=B;return a.loader={load:j,i:0},a}var l=b.documentElement,m=a.setTimeout,n=b.getElementsByTagName("script")[0],o={}.toString,p=[],q=0,r="MozAppearance"in l.style,s=r&&!!b.createRange().compareNode,t=s?l:n.parentNode,l=a.opera&&"[object Opera]"==o.call(a.opera),l=!!b.attachEvent&&!l,u=r?"object":l?"script":"img",v=l?"script":u,w=Array.isArray||function(a){return"[object Array]"==o.call(a)},x=[],y={},z={timeout:function(a,b){return b.length&&(a.timeout=b[0]),a}},A,B;B=function(a){function b(a){var a=a.split("!"),b=x.length,c=a.pop(),d=a.length,c={url:c,origUrl:c,prefixes:a},e,f,g;for(f=0;f<d;f++)g=a[f].split("="),(e=z[g.shift()])&&(c=e(c,g));for(f=0;f<b;f++)c=x[f](c);return c}function g(a,e,f,g,h){var i=b(a),j=i.autoCallback;i.url.split(".").pop().split("?").shift(),i.bypass||(e&&(e=d(e)?e:e[a]||e[g]||e[a.split("/").pop().split("?")[0]]),i.instead?i.instead(a,e,f,g,h):(y[i.url]?i.noexec=!0:y[i.url]=1,f.load(i.url,i.forceCSS||!i.forceJS&&"css"==i.url.split(".").pop().split("?").shift()?"c":c,i.noexec,i.attrs,i.timeout),(d(e)||d(j))&&f.load(function(){k(),e&&e(i.origUrl,h,g),j&&j(i.origUrl,h,g),y[i.url]=2})))}function h(a,b){function c(a,c){if(a){if(e(a))c||(j=function(){var a=[].slice.call(arguments);k.apply(this,a),l()}),g(a,j,b,0,h);else if(Object(a)===a)for(n in m=function(){var b=0,c;for(c in a)a.hasOwnProperty(c)&&b++;return b}(),a)a.hasOwnProperty(n)&&(!c&&!--m&&(d(j)?j=function(){var a=[].slice.call(arguments);k.apply(this,a),l()}:j[n]=function(a){return function(){var b=[].slice.call(arguments);a&&a.apply(this,b),l()}}(k[n])),g(a[n],j,b,n,h))}else!c&&l()}var h=!!a.test,i=a.load||a.both,j=a.callback||f,k=j,l=a.complete||f,m,n;c(h?a.yep:a.nope,!!i),i&&c(i)}var i,j,l=this.yepnope.loader;if(e(a))g(a,0,l,0);else if(w(a))for(i=0;i<a.length;i++)j=a[i],e(j)?g(j,0,l,0):w(j)?B(j):Object(j)===j&&h(j,l);else Object(a)===a&&h(a,l)},B.addPrefix=function(a,b){z[a]=b},B.addFilter=function(a){x.push(a)},B.errorTimeout=1e4,null==b.readyState&&b.addEventListener&&(b.readyState="loading",b.addEventListener("DOMContentLoaded",A=function(){b.removeEventListener("DOMContentLoaded",A,0),b.readyState="complete"},0)),a.yepnope=k(),a.yepnope.executeStack=h,a.yepnope.injectJs=function(a,c,d,e,i,j){var k=b.createElement("script"),l,o,e=e||B.errorTimeout;k.src=a;for(o in d)k.setAttribute(o,d[o]);c=j?h:c||f,k.onreadystatechange=k.onload=function(){!l&&g(k.readyState)&&(l=1,c(),k.onload=k.onreadystatechange=null)},m(function(){l||(l=1,c(1))},e),i?k.onload():n.parentNode.insertBefore(k,n)},a.yepnope.injectCss=function(a,c,d,e,g,i){var e=b.createElement("link"),j,c=i?h:c||f;e.href=a,e.rel="stylesheet",e.type="text/css";for(j in d)e.setAttribute(j,d[j]);g||(n.parentNode.insertBefore(e,n),m(c,0))}}(this,document),Modernizr.load=function(){yepnope.apply(window,[].slice.call(arguments,0))};

function bindEffectForCButton() {
    (function () {
        function mobilecheck() {
            var check = false;
            (function (a) {
                if (/(android|ipad|playbook|silk|bb\d+|meego).+mobile|avantgo|bada\/|blackberry|blazer|compal|elaine|fennec|hiptop|iemobile|ip(hone|od)|iris|kindle|lge |maemo|midp|mmp|netfront|opera m(ob|in)i|palm( os)?|phone|p(ixi|re)\/|plucker|pocket|psp|series(4|6)0|symbian|treo|up\.(browser|link)|vodafone|wap|windows (ce|phone)|xda|xiino/i.test(a) || /1207|6310|6590|3gso|4thp|50[1-6]i|770s|802s|a wa|abac|ac(er|oo|s\-)|ai(ko|rn)|al(av|ca|co)|amoi|an(ex|ny|yw)|aptu|ar(ch|go)|as(te|us)|attw|au(di|\-m|r |s )|avan|be(ck|ll|nq)|bi(lb|rd)|bl(ac|az)|br(e|v)w|bumb|bw\-(n|u)|c55\/|capi|ccwa|cdm\-|cell|chtm|cldc|cmd\-|co(mp|nd)|craw|da(it|ll|ng)|dbte|dc\-s|devi|dica|dmob|do(c|p)o|ds(12|\-d)|el(49|ai)|em(l2|ul)|er(ic|k0)|esl8|ez([4-7]0|os|wa|ze)|fetc|fly(\-|_)|g1 u|g560|gene|gf\-5|g\-mo|go(\.w|od)|gr(ad|un)|haie|hcit|hd\-(m|p|t)|hei\-|hi(pt|ta)|hp( i|ip)|hs\-c|ht(c(\-| |_|a|g|p|s|t)|tp)|hu(aw|tc)|i\-(20|go|ma)|i230|iac( |\-|\/)|ibro|idea|ig01|ikom|im1k|inno|ipaq|iris|ja(t|v)a|jbro|jemu|jigs|kddi|keji|kgt( |\/)|klon|kpt |kwc\-|kyo(c|k)|le(no|xi)|lg( g|\/(k|l|u)|50|54|\-[a-w])|libw|lynx|m1\-w|m3ga|m50\/|ma(te|ui|xo)|mc(01|21|ca)|m\-cr|me(rc|ri)|mi(o8|oa|ts)|mmef|mo(01|02|bi|de|do|t(\-| |o|v)|zz)|mt(50|p1|v )|mwbp|mywa|n10[0-2]|n20[2-3]|n30(0|2)|n50(0|2|5)|n7(0(0|1)|10)|ne((c|m)\-|on|tf|wf|wg|wt)|nok(6|i)|nzph|o2im|op(ti|wv)|oran|owg1|p800|pan(a|d|t)|pdxg|pg(13|\-([1-8]|c))|phil|pire|pl(ay|uc)|pn\-2|po(ck|rt|se)|prox|psio|pt\-g|qa\-a|qc(07|12|21|32|60|\-[2-7]|i\-)|qtek|r380|r600|raks|rim9|ro(ve|zo)|s55\/|sa(ge|ma|mm|ms|ny|va)|sc(01|h\-|oo|p\-)|sdk\/|se(c(\-|0|1)|47|mc|nd|ri)|sgh\-|shar|sie(\-|m)|sk\-0|sl(45|id)|sm(al|ar|b3|it|t5)|so(ft|ny)|sp(01|h\-|v\-|v )|sy(01|mb)|t2(18|50)|t6(00|10|18)|ta(gt|lk)|tcl\-|tdg\-|tel(i|m)|tim\-|t\-mo|to(pl|sh)|ts(70|m\-|m3|m5)|tx\-9|up(\.b|g1|si)|utst|v400|v750|veri|vi(rg|te)|vk(40|5[0-3]|\-v)|vm40|voda|vulc|vx(52|53|60|61|70|80|81|83|85|98)|w3c(\-| )|webc|whit|wi(g |nc|nw)|wmlb|wonu|x700|yas\-|your|zeto|zte\-/i.test(a.substr(0, 4))) check = true
            })(navigator.userAgent || navigator.vendor || window.opera);
            return check;
        }

        var support = {animations: Modernizr.cssanimations},
            animEndEventNames = {
                'WebkitAnimation': 'webkitAnimationEnd',
                'OAnimation': 'oAnimationEnd',
                'msAnimation': 'MSAnimationEnd',
                'animation': 'animationend'
            },
            animEndEventName = animEndEventNames[Modernizr.prefixed('animation')],
            onEndAnimation = function (el, callback) {
                var onEndCallbackFn = function (ev) {
                    if (this.id == 'autofeaturedWishlist' || this.classList.contains('wishlist')) {
                        this.style.background = "#ff5d68";
                        this.style.color = "#fff";
                    }


                    if (support.animations) {
                        if (ev.target != this) return;
                        this.removeEventListener(animEndEventName, onEndCallbackFn);
                    }
                    if (callback && typeof callback === 'function') {
                        callback.call();
                    }
                };
                if (support.animations) {
                    el.addEventListener(animEndEventName, onEndCallbackFn);
                }
                else {
                    onEndCallbackFn();
                }
            },
            eventtype = mobilecheck() ? 'touchstart' : 'click';

        [].slice.call(document.querySelectorAll('.cbutton')).forEach(function (el) {
            el.addEventListener(eventtype, function (ev) {
                classie.add(el, 'cbutton--click');
                onEndAnimation(classie.has(el, 'cbutton--complex') ? el.querySelector('.cbutton__helper') : el, function () {
                    classie.remove(el, 'cbutton--click');
                });
            });
        });
    })();
}

setTimeout( ()=> {

    $('.owl-prev').addClass('cbutton--effect-nikola'); $('.owl-prev').addClass('cbutton');
$('.owl-next').addClass('cbutton--effect-nikola'); $('.owl-next').addClass('cbutton');
$('.wishlist.oct-button').addClass('cbutton--effect-nikola'); $('.wishlist.oct-button').addClass('cbutton');
bindEffectForCButton()

}, 2000);