<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<title>Build your Own Dashboard</title>
		<link rel="stylesheet" type="text/css" href="css/dashGrid.css" />
		<link rel="stylesheet" type="text/css" href="css/dashMain.css" />
		<script src="js/jquery-1.7.1.min.js" type="text/javascript"></script>

		<cfajaxproxy cfc="cfo_dash.cfc.proxy" jsclassname="proxyAjax" />

		<script type="text/javascript">
			$(function(){
				ajaxObj = new proxyAjax();


				updateServers();
				updateProjects();
				updateDevelopers();
				updateQA();
				updateWeather();


				setInterval(updateServers,5000);		// every 5 seconds
				setInterval(updateProjects,30000);		// every 30 seconds
				setInterval(updateDevelopers,10000);	// every 10 seconds
				setInterval(updateQA,10000);			// every 10 seconds
				setInterval(updateWeather,900000);		// every 15 minutes


				function updateServers(){
					var seattleVal = ajaxObj.getServerPing();
					var dallasVal = ajaxObj.getServerPing();
					var washdcVal = ajaxObj.getServerPing();
					$('#seattlePing').text(seattleVal + 'ms');
					$('#dallasPing').text(dallasVal + 'ms');
					$('#washdcPing').text(washdcVal + 'ms');
					if(seattleVal < 90){
						$('#seattleMap').css('background-color','#00FF00');
					}else{
						$('#seattleMap').css('background-color','#FF0000');
					}
					if(dallasVal < 90){
						$('#dallasMap').css('background-color','#00FF00');
					}else{
						$('#dallasMap').css('background-color','#FF0000');
					}
					if(washdcVal < 90){
						$('#washdcMap').css('background-color','#00FF00');
					}else{
						$('#washdcMap').css('background-color','#FF0000');
					}
				}

				function updateProjects(){
					$('#projectSection').load('cfc/proxy.cfc?method=getProjects&returnformat=plain');

				}

				function updateDevelopers(){
					$('#developerSection').load('cfc/proxy.cfc?method=getDevelopers&returnformat=plain');
				}

				function updateQA(){
					$('#qaSection').load('cfc/proxy.cfc?method=getQA&returnformat=plain');
				}

				function updateWeather(){
					$.ajax({
					  url: 'cfc/proxy.cfc?method=getTemp&returnformat=plain',
					  success: function(d){
					  	//alert(d);
					  	$('#weatherSection').html(d);
					  }
					});
				}
			});

		</script>

	</head>
<body>
	<div id="grid" class="container">
		<div class="gridBox width_2 height_1">
			<div class="serverBox" id="seattleMap"><img src="images/seattle.png"></div>
			<div class="serverPingBox">
				<span class="region">Seattle</span><br />
				<span class="time" id="seattlePing">--.-ms</span>
			</div>
		</div>
		<div class="gridBox width_2 height_1">
			<div class="serverBox" id="dallasMap"><img src="images/dallas.png"></div>
			<div class="serverPingBox">
				<span class="region">Dallas</span><br />
				<span class="time" id="dallasPing">--.-ms</span>
			</div>
		</div>
		<div class="gridBox width_2 height_1">
			<div class="serverBox" id="washdcMap"><img src="images/washdc.png"></div>
			<div class="serverPingBox">
				<span class="region">Wash DC</span><br />
				<span class="time" id="washdcPing">--.-ms</span>
			</div>
		</div>
		<div class="gridBox width_2 height_1">
			<div class="serverPingBox">
				<span class="region">24hr UpTime</span><br />
				<span class="time">99.92%</span>
			</div>
		</div>

		<div class="clear"></div>

		<div class="width_8" id="projectSection">
		</div>

		<div class="clear"></div>

		<div id="developerSection"></div>
		<div class="weatherBox width_1 height_2" id="weatherSection"></div>
		<div id="qaSection"></div>
	</div>

</body>
</html>