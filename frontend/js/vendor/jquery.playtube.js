// make playlist youtube, niconico

$.fn.playTube = function (config) {
	var defaults = {
		width  : 400,
		height : 300,
		thumb  : false,	// insert thumbnail image automatically (* youtube/nicovideo)
		target : null,	// target element to insert movie
		dialog : null,	// class name if use dialog (ex: movie-dialog-window)
		autoplay  : false,	// auto play on call movie
		readyplay : false,	// auto play on ready movie
		firstset  : true,	// set first video to target
		keeptext  : false,	// keep link text
		transparent : true,	// wmode=transparent
		hd_mode : true,	// (youtube) HD mode
		not_rel : true,	// (youtube) not relative movie
		html5 : true,	// add <video>

		debug : false,	// debug mode (append HTML source to target)

		// player type by extention type
		player_type : {
			// wmp: windows media player, qt: quick time, rp: real player
			mp4 : 'wmp',
			flv : 'flv_player',
			wmv : 'wmp', asf : 'wmp', wmx : 'wmp', wvx : 'wmp', wma : 'wmp', wax : 'wmp', 
			divx : 'divx', xvid : 'wmp',
			mpeg : 'wmp', mp2t : 'wmp',
			quicktime : 'qt', '3gpp' : 'qt', '3gpp2' : 'qt',
			realvideo  : 'rp', realaudio  : 'rp',
			ogg : 'wmp',
			webm : 'wmp'
		},
		// extention type (.xxx : video/***)
		ext_type : {
			mp4: 'mp4',
			flv: 'flv',
			wmv: 'wmv', asf: 'asf', asx: 'asf',
			wmx: 'wmx', wvx: 'wvx', wma: 'wma', wax: 'wmv',
			avi: 'divx', divx: 'divx',
			mkv: 'xvid',
			mpg: 'mpeg', mpe: 'mpeg', mpeg: 'mpeg', ts: 'mp2t',
			mov: 'quicktime', qt: 'quicktime', '3gp': '3gpp', '3g2': '3gpp2',
			rm:  'realvideo',   rmvb: 'realvideo', ra: 'realaudio', ram: 'realaudio', rpm: 'realaudio',
			ogm: 'ogg', ogg: 'ogg', ogx: 'ogg', ogv: 'ogg', oga: 'ogg',
			webm: 'webm'
		},
		// player config by player type
		player : {
			// windows media player
			wmp : {
				type : 'application/x-mplayer2',
				plugin : 'http://www.microsoft.com/Windows/MediaPlayer/',
				classid : '6BF52A52-394A-11d3-B153-00C04F79FAA6',
				addheight : 20,
				standby : 'Loading Windows Media Player components...',
				src_name : 'url',
				autoplay : 'autostart',
				attr : {
					autorewind   : 1,
					allowchangedisplaysize : 1,
					autosize     : 1,
					displaysize  : 1,
					controller     : 'true',
					hidden         : 'false',
					playcount      : 1,
					playeveryframe : 'false',
					showaudiocontrols : 1,
					showcontrols   : 1,
					showdisplay    : 1,
					showgotobar    : 0,
					showpositioncontrols : 1,
					showstatusbar  : 1,
					showtracker    : 1,
					volume         : '100',
					uimode         : 'full',
				'':''}
			},
			// quicktime
   			qt : {
				// http://support.apple.com/kb/TA26486?viewlocale=ja_JP
				type : 'video/quicktime',
				plugin : 'http://www.apple.com/quicktime/download',
				classid : '02BF25D5-8C17-4B23-BC80-D3488ABDDC6B',
				codebase : 'http://www.apple.com/qtactivex/qtplugin.cab',
				addheight : 16,
				attr : {
					autohref : 'false',
					bgcolor  : '000000',
					controller : 'true',
					cache    : 'true',
					scale    : 'aspect',	// tofit, aspect, 1
					volume   : '100',
				'':''}
			}, 
			// divx player
			divx :  {
				type : 'video/divx',
				plugin : 'http://go.divx.com/plugin/download/',
				classid : '67DABFBF-D0AB-41fa-9C46-CC0F21721616',
				codebase : 'http://go.divx.com/plugin/DivXBrowserPlugin.cab',
				addheight : 20,
				attr : {
					custommode : 'none',
				'':''}
			},
			// real player plugin
			rp :  {
				type : 'audio/x-pn-realaudio-plugin',
				plugin : 'http://www.real.com/',
				classid : 'CFCDAA03-8BE4-11CF-B84B-0020AFBBCCFA',
				addheight : 20,
				src_name : 'href',
				autoplay : 'autostart',
				attr : {
					controls : 'imagewindow,controlpanel',
				'':''}
			},
			// FLVPlayer Progressive (in Adobe DreamWeaver)
			flvplayer : {
				swf : 'FLVPlayer_Progressive.swf',
				type : 'application/x-shockwave-flash',
				plugin : 'http://get.adobe.com/flashplayer/',
				classid : 'D27CDB6E-AE6D-11cf-96B8-444553540000',
				src_name : 'streamName',	// not in param but in flashvars
				autoplay : 'autoPlay',
				flashvars : {
					skinName : 'Clear_Skin_3',
					autoRewind : 'true',
				'':''},
				attr : {
					quality : 'high',
					scale : 'noscale',
					allowfullscreen : 'true',
				'':''}
			},
			// FLV Player (http://flv-player.net/)
			flv_player : {
				swf : 'player_flv_multi.swf',
				type : 'application/x-shockwave-flash',
				plugin : 'http://get.adobe.com/flashplayer/',
				classid : 'D27CDB6E-AE6D-11cf-96B8-444553540000',
				src_name : 'flv',	// not in param but in flashvars
				autoplay_num : true,	// autoplay is written by number
				flashvars : {
					config : 'flv_config_multi.txt',
				'':''},
				attr : {
					quality : 'high',
					allowfullscreen : 'true',
				'':''}
			},
			// fladance (http://www.streaming.jp/fladance/)
			fladance : {
				swf : 'fladance.swf',
				type : 'application/x-shockwave-flash',
				plugin : 'http://get.adobe.com/flashplayer/',
				classid : 'D27CDB6E-AE6D-11cf-96B8-444553540000',
				src_name : 'video_file',	// not in param but in flashvars
				flashvars : {
					vol : '1',
					controllbar : 'true',
				'':''},
				attr : {
					quality : 'high',
					allowfullscreen : 'true',
				'':''}
			}
		}
	};
	var op = $.extend(defaults, config);

	// UA
	var userAgent = window.navigator.userAgent.toLowerCase();
	var isGecko   = userAgent.indexOf('gecko') != -1 && userAgent.indexOf('chrome') == -1;

	// stock
	document._write = document.write;

	// set
	var first = op.firstset;
	this.not('.alt').each( function (suffix) {
		var $this = $(this);
		var title = $this.text();
		var url   = $this.attr('href') || '';
		var type  = $this.attr('type') || '';
			type  = type.replace(/^(video|audio)\/(?:x-)?(?:ms-)?(?:pn-)?/i, '').toLowerCase();
		var ext   = url.match(/\.(\w+)$/i) ? RegExp.$1.toLowerCase() : '';
		var videoId, thumb, src;

		// youtube ?
		if (url.match(/^http:\/\/(?:(?:www\.)?youtube\.com\/watch\?.*v=|youtu\.be\/)([-\w]+)/)) {
			type = 'youtube';
			videoId = RegExp.$1;
			thumb = 'http://img.youtube.com/vi/' + videoId + '/default.jpg';
			src   = 'http://www.youtube.com/embed/'+ videoId;
		}
		// nicovideo ?
		else if (url.match(/^http:\/\/(?:(?:www\.)?nicovideo\.jp\/watch|nico\.ms)\/([a-z][a-z](\d+))$/)) {
			type = 'nicovideo';
			videoId  = RegExp.$1;
			var num  = RegExp.$2;
			var host = parseInt( num ) % 4 + 1;
			src = 'http://ext.nicovideo.jp/thumb_watch/'+ videoId;
			thumb = 'http://tn-skr' + host + '.smilevideo.jp/smile?i='+ num;
		}
		// mime type ?
		else if (type && op.player_config[type]) {
			src = url;
		}
		// other player ?
		else if (ext && op.ext_type[ext]) {
			src = url, type = op.ext_type[ext];
		}
		if (!src) return;

		// add class
		if (type) $this.parent().addClass(type);

		// stock
		$this.data('options', op).data('src', src).data('type', type)
		     .data('title', title).data('videoId', videoId);

		// add thumb image
		if (!op.keeptext) $this.empty();
		if (op.thumb && thumb) {
			$this.prepend('<img src="'+ thumb +'" alt="'+ title +'" title="'+ title +'"/>');
		}
		// append ?
		var is_append = false;

		// dialog
		if (op.dialog) {
			// make clone
			var $div = $('<div id="playtube-'+ suffix +'" class="playtube dialog"></div>');
			$this.data('target', $div.get(0));
			$('body').append($div);

			// effect to show dialog
			var effect = ['blind', 'clip', 'drop', 'explode', 'puff', 'scale', 'slide']
			             [ Math.floor( 7 * Math.random() ) ];
			$div.dialog({
				autoOpen: false,
				title : title,
				width:  op.width,
//				height: op.height,
				dialogClass: op.dialog,
				show: effect,
				hide: effect,
				position : ['center', 'center'],
				draggable: true,
				resize : resize_dialog,
				beforeclose : function () { $(this).empty(); }
			});
		}
		// replace target
		else if (op.target) {
			$this.data('target', op.target);
			if (first) is_append = true;	// first video
			first = false;
		}
		// inline
		else {
			var $div = $('<div id="playtube-'+ suffix +'" class="playtube inline"></div>');
			$this.data('target', $div.get(0));
			$this.before( $div );
			is_append = true;
		}
		$this.data('is_first', is_append);	// is first play

		// youtube
		if (type == 'youtube') {
			if (is_append) call_youtube.apply(this);
			$this.click( call_youtube );
		}
		// nicovideo
		else if (type == 'nicovideo') {
			if (is_append) call_niovideo.apply(this);
			$this.click( call_niovideo );
		}
		// is type ?
		else {
			if (is_append) call_player.apply(this);
			$this.click( call_player );
		}
		$this.data('is_first', false);	// not first play

		// remove this element?
		if (!op.thumb && !op.keeptext) $this.remove();
	});

	// close by right click
	if (op.dialog) $('div.'+ op.dialog.replace(/\s+/, '.')).bind('contextmenu', function (e) {
		$(this).find('div.dialog').dialog('close');
		return false;
	});

	// call youtube
	function resize_dialog () {
		var $this = $(this);
		var width = parseInt($this.width()), height = parseInt($this.height());
		$this.find('iframe,embed,object').attr('width', width).attr('height', height);
	}

	// prepare open movie
	function prepare_open_target () {
		var $this = $(this);
		var op = $this.data('options');

		// target box, object box
		var $target = $( $this.data('target') );
		var $object = $target.find('object,embed');
			$object.each(function () {
				if (this.controls) this.controls.stop();
			}).css({ position: 'absolute', left: '-10000px' }).appendTo('body').hide();

		// append dummy box
		$target.empty();
		$target.html('<div class="dummy-movie" style="width:'+ op.width +'px; height:'+ op.height +'px;"></div>');

		// remove object
		$object.remove();

		// open dialog ?
		if (op.dialog) $target.dialog('open');

		return $target;
	}

	// after open movie
	function after_open_target () {
		var $this = $(this);
		var op = $this.data('options');
		var $target = $( $this.data('target') );

		if (op.dialog) setTimeout(function () { resize_dialog.apply($target); }, 500);	// resize
		return false;
	}

	// call youtube
	function call_youtube (e) {
		var $this = $(this);
		var op = $this.data('options');
		var $target = prepare_open_target.apply(this);	// prepare open movie
		var is_autoplay = $this.data('is_first') ? op.readyplay : op.autoplay;

		// query parameter
		var query = {
			wmode    : op.transparent ? 'transparent' : null,
			hd       : op.hd_mode  ? 1 : null,
			autoplay : is_autoplay ? 1 : null,
			rel      : op.not_rel  ? 0 : null
		};

		// source
		var iframe = '<iframe src="'+ $this.data('src') + make_query(query, '?') +'" width="'+ op.width +'" height="'+ op.height +'" frameborder="0" allowfullscreen="allowfullscreen"></iframe>';

		// append
		$target.html( iframe );
		if (op.debug) $('<div><code></code></div>').text( iframe ).appendTo( $target );	// debug

		return after_open_target.apply(this);	// after open movie
	}

	// call niovideo
	function call_niovideo (e) {
		var $this = $(this);
		var op = $this.data('options');
		var $target = prepare_open_target.apply(this);	// prepare open movie

		// src
		var src = $this.data('src') +'?w='+ op.width +'&h='+ op.height +'&tr=1';

		// read niovideo
		if (op.dialog || op.target) {
			var output = [];
			document.write = function (v) { output.push(v); }
			jQuery.getScript(src, function () {
				document.write = document._write;
				// append
				$target.html( output.join('') );
				if (op.debug) $('<div><code></code></div>').text( iframe ).appendTo( $target );	// debug
				output = [];
				return after_open_target.apply(this);	// after open movie
			});
		} else {
			// source
			var  iframe = '<iframe width="'+ op.width +'" height="'+ op.height +'" frameborder="0"></iframe>';
			var $iframe = $(iframe);

			// append source
			$target.html($iframe);
			if (op.debug) $('<pre></pre>').text( iframe ).appendTo( $target );	// debug

			// src
			var d = $iframe.contents().get(0);
			d.open();
			d.write('<html><head><title>'+ $this.data('title') +'</title></head>'+
				'<body style="margin:0; padding:0; background-color:#000;">'+
				'<div style="margin:0; padding:0;">'+
				'<script type="text/javascript" src="'+ src +'"></script>'+
				'</div></body></html>');
			//d.close();
		}
		return false;
	}

	// call player
	function call_player (e) {
		var $this = $(this);
		var op = $this.data('options');
		var $target = prepare_open_target.apply(this);	// prepare open movie

		// source
		var source = make_object_html.apply(this);

		// append source
		$target.html( source );
		if (op.debug) $('<div><code></code></div>').text( source ).appendTo( $target );	// debug

		return after_open_target.apply(this);	// after open movie
	}


	// make object html
	function make_object_html () {
		var $this = $(this);
		var op     = $this.data('options');
		var player = $this.data('type')
			      && op.player[ $this.data('type') ]
		          || op.player[ op.player_type[ $this.data('type') ] ];
		if (!player) return;
		var is_autoplay = $this.data('is_first') ? op.readyplay : op.autoplay;

		// object attributes
		var object_attr = {
			data         : $this.data('src'),
			classid      : player.classid && 'clsid:'+ player.classid || null,
			codebase     : player.codebase || null,
			type         : player.type     || null,
			width        : op.width,
			height       : op.height + (player.addheight || 0),
			standby      : player.standby  || null
		};
		// object param attributes
		var param_attr = {
			wmode        : op.transparent ? 'transparent' : 'opaque'
		};
		// embed attributes
		var embed_attr = {
			src          : $this.data('src'),
			type         : player.type   || null,
			pluginspage  : player.plugin || null,
			width        : op.width,
			height       : op.height + (player.addheight || 0),
			wmode        : 'opaque'
		};
		// common attributes
		var common_attr = player.attr;

		// not flash ?
		if (!player.swf) {
			// source, auto play start ?
			param_attr[ player.src_name || 'src' ]      = $this.data('src');
			param_attr[ player.autoplay || 'autoplay' ] =
			embed_attr[ player.autoplay || 'autoplay' ] = is_autoplay ? 'true' : 'false';
		}
		// flash ?
		else {
			// flashvars parameter
			var flash_attr = {
				width  : op.width,
				height : op.height
			};
			// swf
			object_attr.data =
			param_attr.movie =
			embed_attr.src   = player.swf;

			// source, auto play start ?
			flash_attr[ player.src_name || 'src' ]      = $this.data('src');
			flash_attr[ player.autoplay || 'autoplay' ] =
			            player.autoplay_num ? (is_autoplay ? '1'    : '0'    ) :
			                                  (is_autoplay ? 'true' : 'false');
			// make flashvars
			param_attr.flashvars =
			embed_attr.flashvars = make_query(flash_attr) + make_query(player.flashvars, '&');
		}

		// make embed
		var embed = '<embed'+ make_attributes(embed_attr) + make_attributes(common_attr) +'/>\n';

		// make object
		return '<object'+ make_attributes(object_attr) +'>\n'
		     + make_params(param_attr) + make_params(common_attr)
		     + embed
		     + '</object>\n';
	}
	// make attributes in HTML element
	function make_attributes (attr) {
		var attr_str = '';
		for (var k in attr) {
			if (k && attr[k] != null) attr_str += ' '+ k +'='+ '"'+ attr[k] +'"';
		}
		return attr_str;
	}
	// make <param> for <object>
	function make_params (param) {
		var param_str = '';
		for (var k in param) {
			if (k && param[k] != null) param_str += '<param name="'+ k +'" value="'+ param[k] +'" />\n';
		}
		return param_str;
	}
	// make query parameters
	function make_query (param, amp) {
		var tmp = [];
		for (var k in param) {
			if (k && param[k] != null) tmp.push(k +'='+ param[k]);
		}
		return (amp && tmp.length ? amp : '') + tmp.join('&');
	}
};
