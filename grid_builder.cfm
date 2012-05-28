<!DOCTYPE html>
<html>
	<head>
	<title>For The Love Of Grid</title>
	<script src="js/jquery-1.7.1.min.js"></script>
	<style type="text/css">
		body {
			background-color: #FFF;
			font-family: Arial,Tahoma, Geneva, sans-serif;
			color: #000;
		}

		.clear {
			clear: both;
			display: block;
			overflow: hidden;
			visibility: hidden;
			width: 0;
			height: 0;
		}
		.rotate {
			float:left;
			-webkit-transform: rotate(-90deg); -moz-transform:rotate(-90deg);
		}
		.calcField {
			background-color: #ccc;
		}
		.previewBox {
			background-color:  #666;
			float: left;
		}

		/* Code Box */
		#codeBox {
		  display: none;
		  position: absolute;
		  width: 860px;
		  height: 500px;
		  top: 100px;
		  left: 0;
		  right: 0;
		  margin: 0 auto;
		  padding-left: 20px;
		  color: gray;
		  background-color: #ddd;
		  -webkit-box-shadow: 0 10px 30px rgba(0, 0, 0, 0.4);
		  -moz-box-shadow: 0 5px 10px rgba(0, 0, 0, 0.5);
		  box-shadow: 0 5px 10px rgba(0, 0, 0, 0.5); }

		#codeText {
		  width: 820px;
		  height: 400px;
		  padding: 10px;
		  font-size: 14px;
		  color: #999;
		  border: none;
		  background-image: -webkit-gradient(linear, 0% 0%, 0% 1%, from(#999999), to(white));
		  background-image: -moz-linear-gradient(0% 1% 90deg, white, #999999);
		  background-color: #fff; }

		.codeInstructions {
		  display: block;
		  float: left;
		  color: #666;
		  padding-left: 10px; }

		.closeWindow {
		  display: block;
		  float: right;
		  margin: 8px 20px 0 0;
		  color: gray;
		  font-size: 24px;
		  -webkit-user-select: none;
		  -khtml-user-select: none;
		  -moz-user-select: none;
		  -o-user-select: none;
		  user-select: none;
		  cursor: default; }

		.closeWindow:hover {
		  color: black;
		  -webkit-user-select: none;
		  -khtml-user-select: none;
		  -moz-user-select: none;
		  -o-user-select: none;
		  user-select: none; }


		.fade {
		  height: 0;
		  opacity: 0; }


	</style>

	<script type="text/javascript">
		var devices = [
			{
				"id":"1",
				"description":"WideScreen Home PC",
				"width":"1680",
				"height":"1050",
				"margin":"0",
				"columns":"8"
			},
			{
				"id":"2",
				"description":"HiRes Home PC",
				"width":"1280",
				"height":"1024",
				"margin":"0",
				"columns":"8"
			},
			{
				"id":"3",
				"description":"LowRes Home PC",
				"width":"1024",
				"height":"768",
				"margin":"0",
				"columns":"8"
			},
			{
				"id":"4",
				"description":"Laptop MacBook",
				"width":"1440",
				"height":"900",
				"margin":"0",
				"columns":"8"
			},
			{
				"id":"4",
				"description":"Laptop",
				"width":"1280",
				"height":"800",
				"margin":"0",
				"columns":"8"
			},
			{
				"id":"5",
				"description":"HD 720",
				"width":"1280",
				"height":"720",
				"margin":"0",
				"columns":"8"
			},
			{
				"id":"6",
				"description":"HD 1080",
				"width":"1920",
				"height":"1080",
				"margin":"0",
				"columns":"8"
			},
			{
				"id":"7",
				"description":"iPhone Portrait",
				"width":"320",
				"height":"480",
				"margin":"0",
				"columns":"3"
			},
			{
				"id":"8",
				"description":"iPhone Landscape",
				"width":"480",
				"height":"320",
				"margin":"0",
				"columns":"5"
			},
			{
				"id":"9",
				"description":"iPhone Retina Portrait",
				"width":"640",
				"height":"960",
				"margin":"0",
				"columns":"3"
			},
			{
				"id":"10",
				"description":"iPhone Retina Landscape",
				"width":"960",
				"height":"640",
				"margin":"0",
				"columns":"6"
			},
			{
				"id":"11",
				"description":"iPad Portrait",
				"width":"768",
				"height":"1024",
				"margin":"0",
				"columns":"4"
			},
			{
				"id":"12",
				"description":"iPad Landscape",
				"width":"1024",
				"height":"768",
				"margin":"0",
				"columns":"6"
			},
			{
				"id":"13",
				"description":"iPad Retina Portrait",
				"width":"1536",
				"height":"2048",
				"margin":"0",
				"columns":"6"
			},
			{
				"id":"14",
				"description":"iPad Retina Landscape",
				"width":"2048",
				"height":"1536",
				"margin":"0",
				"columns":"8"
			}
		];

		$(function(){
		 	// this is the ready state
			$.each(devices, function(i, option) {
				$('#selDevice').append($('<option/>').attr("value", option.id).text(option.description));
			});
			$('#selDevice').change(function(){
				// change form values
				var selID = $(this).val();
				$.each(devices, function(i, struct){
					if(struct.id == selID){
						//alert(struct.description);
						$('#sx').val(struct.width);
						$('#sy').val(struct.height);
						$('#marg').val(struct.margin);
						$('#cols').val(struct.columns);
						callculateGridInfo();
						// Fill the preview with our grid

						return false;
					}
				});
			});

			$("input").blur(function() {
				callculateGridInfo();
			});

			$('#showCode').click( showCodeBox );
			$('#codeBox .closeWindow').click( hideCodeBox );



			$("#btnBox").click(function() {
				$('#txtCSS').empty();
				$('#txtCSS').append('/* Grids */\n'+
					'\n'+
					'body {\n'+
					'	min-width: '+$('#sx').val()+'px;\n'+
					'}\n'+
					'\n'+
					'.container {\n'+
					'	margin-left: auto;\n'+
					'	margin-right: auto;\n'+
					'	width: '+$('#sx').val()+'px;\n'+
					'}\n'+
					'/* Grid >> Global */\n');
				for(var c = 1; c <= $('#cols').val(); c++){
					if(c != $('#cols').val()){
						$('#txtCSS').append('.width_'+c+',\n');
					}else{
						$('#txtCSS').append('.width_'+c+' {');
					}
				}
				$('#txtCSS').append('\n'+
					'	display:inline;\n'+
					'	float: left;\n'+
					'	position: relative;\n'+
					'	margin: '+$('#marg').val()+'px;\n'+
					'}\n'+
					'\n');
				for(var c = 1; c <= $('#cols').val(); c++){
					$('#txtCSS').append('.width_'+c+' {	width:'+((c * $('#bloxSize').val()) - ($('#marg').val() * 2 ))+'px;}\n');
				}
				$('#txtCSS').append('\n');
				for(var r = 1; r <= $('#rows').val(); r++){
					$('#txtCSS').append('.height_'+r+' {	height:'+((r * $('#bloxSize').val()) - ($('#marg').val() * 2 ))+'px;}\n');
				}

				$('#txtCSS').append('\n'+
					'/* http://sonspring.com/journal/clearing-floats */\n'+
					'.clear {\n'+
					'	clear: both;\n'+
					'	display: block;\n'+
					'	overflow: hidden;\n'+
					'	visibility: hidden;\n'+
					'	width: 0;\n'+
					'	height: 0;\n'+
					'}\n'+
					'\n'+
					'/* http://www.yuiblog.com/blog/2010/09/27/clearfix-reloaded-overflowhidden-demystified */\n'+
					'.clearfix:before,\n'+
					'.clearfix:after {\n'+
					'	content: \'\\0020\';\n'+
					'	display: block;\n'+
					'	overflow: hidden;\n'+
					'	visibility: hidden;\n'+
					'	width: 0;\n'+
					'	height: 0;\n'+
					'}\n'+
					'\n'+
					'.clearfix:after {\n'+
					'	clear: both;\n'+
					'}\n'+
					'\n'+
					'.clearfix {\n'+
					'	zoom: 1;\n'+
					'}\n'+
					'\n');
			});

		});

		var showCodeBox = function(){
		  //$('#codeText').val( template( $('#workingGrid').html() ) );
			$('#codeText').empty();
			$('#codeText').append('/* Grids */\n'+
				'\n'+
				'body {\n'+
				'	min-width: '+$('#sx').val()+'px;\n'+
				'}\n'+
				'\n'+
				'.container {\n'+
				'	margin-left: auto;\n'+
				'	margin-right: auto;\n'+
				'	width: '+$('#sx').val()+'px;\n'+
				'}\n'+
				'/* Grid >> Global */\n');
			for(var c = 1; c <= $('#cols').val(); c++){
				if(c != $('#cols').val()){
					$('#codeText').append('.width_'+c+',\n');
				}else{
					$('#codeText').append('.width_'+c+' {');
				}
			}
			$('#codeText').append('\n'+
				'	display:inline;\n'+
				'	float: left;\n'+
				'	position: relative;\n'+
				'	margin: '+$('#marg').val()+'px;\n'+
				'}\n'+
				'\n');
			for(var c = 1; c <= $('#cols').val(); c++){
				$('#codeText').append('.width_'+c+' {	width:'+((c * $('#bloxSize').val()) - ($('#marg').val() * 2 ))+'px;}\n');
			}
			$('#codeText').append('\n');
			for(var r = 1; r <= $('#rows').val(); r++){
				$('#codeText').append('.height_'+r+' {	height:'+((r * $('#bloxSize').val()) - ($('#marg').val() * 2 ))+'px;}\n');
			}
	
			$('#codeText').append('\n'+
				'/* http://sonspring.com/journal/clearing-floats */\n'+
				'.clear {\n'+
				'	clear: both;\n'+
				'	display: block;\n'+
				'	overflow: hidden;\n'+
				'	visibility: hidden;\n'+
				'	width: 0;\n'+
				'	height: 0;\n'+
				'}\n'+
				'\n'+
				'/* http://www.yuiblog.com/blog/2010/09/27/clearfix-reloaded-overflowhidden-demystified */\n'+
				'.clearfix:before,\n'+
				'.clearfix:after {\n'+
				'	content: \'\\0020\';\n'+
				'	display: block;\n'+
				'	overflow: hidden;\n'+
				'	visibility: hidden;\n'+
				'	width: 0;\n'+
				'	height: 0;\n'+
				'}\n'+
				'\n'+
				'.clearfix:after {\n'+
				'	clear: both;\n'+
				'}\n'+
				'\n'+
				'.clearfix {\n'+
				'	zoom: 1;\n'+
				'}\n'+
				'\n');
	

			$('#codeBox').fadeIn('fast');
		}

		var hideCodeBox = function(){
		  $('#codeBox').fadeOut('fast', function(){
			$('#codeText').val( '' );
		  });
		}

		function callculateGridInfo(){
			// FLOOR(HEIGHT/(WIDTH/COLUMNS),1)
			$('#rows').val(Math.floor( $('#sy').val() / ($('#sx').val() / $('#cols').val() ),1));
			// FLOOR(WIDTH/COLUMNS,1)
			// attempt to compensate for margin
			$('#bloxSize').val(Math.floor(($('#sx').val() / $('#cols').val() ),1));
			// MOD(HEIGHT,BLOCKSIZE)
			$('#fillerSize').val($('#sy').val() % Math.floor(($('#sx').val() / $('#cols').val() ),1));
			buildPreview();
		}
		function buildPreview(){
			$('#previewGridBox').empty();
			$('#previewGridBox').width($('#sx').val()/2).height($('#sy').val()/2);
			for(var r = 1; r <= $('#rows').val(); r++){
				for(var c = 1; c <= $('#cols').val(); c++){
					$('#previewGridBox').append('<div class="previewBox">'+r+':'+c+'</div>');
				}
				$('#previewGridBox').append('<div class="clear" />');

			}
			$('.previewBox').css("margin",2);
			$('.previewBox').css("width",($('#bloxSize').val()/2)-4);
			$('.previewBox').css("height",($('#bloxSize').val()/2)-4);
		}
		
		function isNumber(n) {
		  return !isNaN(parseFloat(n)) && isFinite(n);
		}


	</script>
	</head>
	<body>
		<div style="float: left;">
			<form action="page_02.cfm" name="frmGridInfo" id="gridInfo" method="post">
				<div id="ipForm" name="ipForm">
					<select id="selDevice">
						<option value="0">Select a Screen Format</option>
					</select>
					<br />
					<table summary="foo">
						<tr>
							<td>Screen Width:</td>
							<td><input type="text" id="sx" name="sx" value="" /></td>
						</tr>
						<tr>
							<td>Screen Height:</td>
							<td><input type="text" id="sy" name="sy" value="" /></td>
						</tr>
						<tr>
							<td>Columns:</td>
							<td><input type="text" id="cols" name="cols" value="" /></td>
						</tr>
						<tr>
							<td>Rows:</td>
							<td><input type="text" id="rows" name="rows" value="" readonly="true" class="calcField" /></td>
						</tr>
						<tr>
							<td>Margin:</td>
							<td><input type="text" id="marg" name="marg" value="" /></td>
						</tr>
						<tr>
							<td>Blox Size:</td>
							<td><input type="text" id="bloxSize" name="bloxSize" value="" readonly="true" class="calcField" /></td>
						</tr>
						<tr>
							<td>Filler Size:</td>
							<td><input type="text" id="fillerSize" name="fillerSize" value="" readonly="true" class="calcField" /></td>
						</tr>
						<!---
						<tr>
							<td colspan="2"><button type="button" id="btnBox" name="btnBox">Show CSS</button></td>
						</tr>
						--->
						<tr>
							<td colspan="2"><button type="button" id="showCode" name="showCode">Show me the code</button></td>
						</tr>
			
						<!---
						<tr>
							<td colspan="2"><button type="button" id="btnClear" name="btnClear">Clear CSS</button></td>
						</tr>
						<tr>
							<td colspan="2"><input type="submit" id="btnSubmit" value="Next Page" /></td>
						</tr>
						--->
					</table>
				</div>
			</form>
		</div>
		<div style="float: left; border:  1px Solid #000;" id="previewGridBox"></div>
		<!---
		<div id="cssPreview">
			<textarea name="txtCSS" id="txtCSS" cols="80" rows="30"></textarea>
		</div>
		--->
		<div id="codeBox">
			<p class="codeInstructions">Paste this code into your html editor</p>
			<span class="closeWindow">&times;</span>
			<form>
				<textarea id="codeText" name="text">html goes here</textarea>
			</form>
		</div>

	</body>
</html>

