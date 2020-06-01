/**
 * @fileoverview 
 * File 업로드 관련 Source
 * Trex.Tool.File - UI,
 * Trex.Attacher.File,
 * Trex.Attachment.File,
 * default configuration를 포함하고 있다.
 */
TrexConfig.addTool(
	"movie",
	{
		disabledonmobile: _TRUE,
		wysiwygonly: _TRUE,
		sync: _FALSE,
		status: _FALSE
	}
);

TrexMessage.addMsg({
	'@movie.title': "동영상"
});

/**
 * Trex.Tool.File
 * @class
 * @extends Trex.Tool
 */
Trex.Tool.Movie = Trex.Class.create({
	/** ignore */
	$const: {
		__Identity: 'movie'
	},
	/** ignore */
	$extend: Trex.Tool,
	oninitialized: function() {
		var _editor = this.editor;
		this.weave.bind(this)(
			new Trex.Button(this.buttonCfg), 
			_NULL,
			function() {
				_editor.getSidebar().getAttacher("movie").execute();
			}
		);
	}
});

TrexConfig.addAttacher(
	"movie",
	{
		multiple: _TRUE,
		multipleuse: _FALSE,
		checksize: _FALSE,
		boxonly: _FALSE,
		wysiwygonly: _FALSE,
		features: { left:250, top:65, width:450, height:404 },
		popPageUrl: "#host#path/pages/trex/movie.html"
	},
	function(root){
		var _config = TrexConfig.getAttacher("movie", root);
		_config.popPageUrl = TrexConfig.getUrl(_config.popPageUrl);
		_config.features = TrexConfig.getPopFeatures(_config.features);
	}
);

/**
 * Trex.Attacher.File
 * @class
 * @extends Trex.Attacher
 */
Trex.Attacher.Movie = Trex.Class.create({
	/** @ignore */
	$const: {
		__Identity: 'movie'
	},
	/** @ignore */
	$extend: Trex.Attacher,
	name: 'movie',
	title: TXMSG("@movie.title"),
	canModified: _TRUE,
	canResized: _FALSE,
	oninitialized: function() {
	},
	getKey: function(data) {
		return data.key || data.ukey;
	},
	/**
	 * data를 editor에 맞게 parsing할때 불리는 methond
	 * @memberOf Trex.Attacher.File.prototype
	 * @param {Object} data
	 */
	getDataForEntry: function(data) {
		if(!data.dispElId) {
			data.dispElId = Trex.Util.getDispElId();
		}
		var _seq = ((data.tmpSeq)? this.entryBox.syncSeq(data.tmpSeq): this.entryBox.newSeq());
		var _ext = data.filename.split(".").pop().toLowerCase();
		var _thumburl;
		switch(_ext){
			case "jpg":
			case "gif":
			case "png":
			case "bmp":
				_thumburl = data.attachurl.replace("/attach/", "/thumbnail/");
				break;
			default :
				_thumburl = Trex.Util.thumburl(_ext);
		}
		var _data = Object.extend({
			dataSeq: _seq,
			thumburl: _thumburl,
			prevurl: Trex.Util.prevurl(data.filename.split(".").pop().toLowerCase())
		}, data); //NOTE: Cuz IE
		return _data;
	}
});

/**
 * Trex.Attachment.File 
 * 
 *  @example
 *  	data = {
 *			attachurl: "string",
 *			filename: "string",
 *			filesize: number,
 *			filemime: "string"
 *		}
 * @class
 * @extends Trex.Attachment
 */
Trex.Attachment.Movie = Trex.Class.create({
	/** @ignore */
	$const: {
		__Identity: 'movie'
	},
	/** @ignore */
	$extend: Trex.Attachment,
	getFieldAttr: function(data) {
		return {
			name: 'tx_attach_movie',
			value: [data.ukey, data.ukey, data.filename].join('|')
		};
	},
	getBoxAttr: function(data) {
		var _nameMaxLength = 56;
		var _filename = data.filename;
		if(_filename.getRealLength() > _nameMaxLength) {
			var _nameArr = _filename.split(".");
			var _ext = _nameArr.pop();
			var _name = _nameArr.join(".").cutRealLength(_nameMaxLength - 2);
			_filename = _name + "." + _ext;
		}
		return {
			//name: _filename + " (" + data.filesize.toByteUnit() + ")",
			name: _filename + " (동영상파일)",
			//image: data.thumburl
			image: "http://localhost:8080/jnitcms/images/thumb.jpg"
		};
	},
	/**
	 * object의 style 값을 가져온다.
	 * @function
	 */
	getObjectStyle: function(data) {
		var _objstyle = {};
		if(this.actor.config.objstyle) {
			_objstyle = Object.extend(_objstyle, this.actor.config.objstyle);
		}
		if(data.imagealign) {
			var _objectStyle = {
				"L": Trex.Tool.AlignLeft,
				"C": Trex.Tool.AlignCenter,
				"FL": Trex.Tool.AlignRight,
				"FR": Trex.Tool.AlignFull
			}[data.imagealign];
			if (_objectStyle && _objectStyle.__TextModeProps && _objectStyle.__TextModeProps['image']) {
				_objstyle = Object.extend(_objstyle, _objectStyle.__TextModeProps['button']['style']);
			}
		}
		return _objstyle;
	},
	/**
	 * object를 감싸고 있는 paragraph tag 의 style 값을 가져온다.
	 * @function
	 */
	getParaStyle: function(data) {
		var _parastyle = Object.extend({}, this.actor.config.parastyle || this.actor.config.defaultstyle);
		if(data.imagealign) {
			var _objectStyle = {
				"L": Trex.Tool.AlignLeft,
				"C": Trex.Tool.AlignCenter,
				"FL": Trex.Tool.AlignFull,
				"FR": Trex.Tool.AlignRight
			}[data.imagealign];
			if (_objectStyle && _objectStyle.__TextModeProps && _objectStyle.__TextModeProps['paragraph']) {
				_parastyle = Object.extend(_parastyle, _objectStyle.__TextModeProps['paragraph']['style']);
			}
		}
		return _parastyle;
	},
	getSaveHtml: function(data) {
		
		return "<object classid=\"clsid:d27cdb6e-ae6d-11cf-96b8-444553540000\" codebase=\"http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=7,0,0,0\" class=\"jnitPlayer\" width=\"550\" height=\"400\"><param name=\"movie\" value=\"_player/Player.swf?key="+ data.ukey +"\"><object type=\"application/x-shockwave-flash\" data=\"_player/Player.swf?key="+ data.ukey +"\" width=\"550\" height=\"400\"></object></object>";
		//return "<a href=\"" + data.attachurl + "\"><img src=\"" + data.prevurl + "\"/> " + data.filename + "</a>";
	},
	getDispHtml: function(data) {
		return "<button id=\"" + data.dispElId + "\" class=\"txc-file\"><img class=\"tx-unresizable\" src=\"" + data.prevurl + "\" ld=\"" + data.attachurl + "\"/> " + data.filename + "</button>";
	},
	getDispText: function(data) {
		return "[" + TXMSG("@movie.title") + ":" + data.dataSeq + "]";
	},
	getRegLoad: function(data) {
		return new RegExp("<(?:object classid=\"clsid:d27cdb6e-ae6d-11cf-96b8-444553540000\" codebase=\"http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=7,0,0,0\" class=\"jnitPlayer\" width=\"550\" height=\"400\"><param name=\"allowNetworking\" value=\"internal\"><param name=\"movie\" value=\"_player/Player.swf\?key=)" + data.ukey.getRegExp() + "(?:\"><object type=\"application/x-shockwave-flash\" data=\"_player/Player.swf\?key=)" + data.ukey.getRegExp() + "\" width=\"550\" height=\"400\"></object></object>", "gm");
	},
	getRegHtml: function(data) {
		return new RegExp("<(?:button|BUTTON)[^>]*id=\"?" + data.dispElId + "\"?[^>]*>[\\S\\s]*?" + data.attachurl.getRegExp() + "[\\S\\s]*?<\/(?:button|BUTTON)>", "gm");
	},
	getRegText: function(data) {
		return new RegExp("\\[" + TXMSG("@movie.title") + ":" + data.dataSeq + "\\]", "gm");
	}
});