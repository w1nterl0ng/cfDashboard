<cfcomponent>

	<cfscript>

			function progressBar( w, h, pro, real){
				// Set some basic variables.
				projectedColor = "0161A4";
				realBadColor = "CC4042";
				realGoodColor = "4CBE0E";

				// create a place holder image for the expected overall size
				baseImage = imageNew("",w,h,"argb");

				// place a rectangle for the percent projected completion
				ImageSetDrawingColor(baseImage, projectedColor);
				ImageDrawRect(baseImage, 0, 0, (w * (pro * 0.01)), h,"yes");

				// place a rectangle for the percent of actual completion
				if(real lt pro){
					ImageSetDrawingColor(baseImage, realBadColor);
				}else{
					ImageSetDrawingColor(baseImage, realGoodColor);
				}
				ImageDrawRect(baseImage, 0, ((h / 2)-5), (w * (real * 0.01)), 10,"yes");

				return(baseImage);
			}

	</cfscript>

	<cffunction name="getServerPing" access="remote" returntype="string">
		<cfhttp url="http://www.tenflow.com/pingme.cfm"></cfhttp>
		<cfreturn cfhttp.filecontent />
	</cffunction>

	<cffunction name="getProjects" access="remote" returntype="string">
		<cfquery datasource="cfObjective" name="getP">
			SELECT
				a.id
				,a.name
				,a.image
				,a.currentVersion
				,a.projected
				,a.progress
				,b.image as resourceImage
			FROM
				projects a inner join projectResources p on p.projectID = a.id
				inner join resources b on p.resourceID = b.id
			ORDER BY
				a.id
		</cfquery>
		<cfoutput query="getP" group="id">
		<div class="project">
			<div class="projectBox pbLogo"><img src="images/#image#" /></div>
			<div class="projectBox pbName">#name#</div>
			<div class="projectBox pbProgress">#currentVersion#<br />
				<cfimage action="writetobrowser" source="#progressBar(550,34,projected,progress)#" />
			</div>
			<div class="projectBox pbResources">
				<cfoutput>
					<div class="pbrImage">
						<img src="images/#resourceImage#" class="resImage">
					</div>
				</cfoutput>

			</div>
			<div class="clear"></div>
		</div>
		</cfoutput>

	</cffunction>

	<cffunction name="getDevelopers" access="remote" returntype="string">
		<cfquery datasource="cfObjective" name="getDevs">
			SELECT
				d.name
				,d.image
				,d.last10Builds
				,d.openTickets
				,d.closedTickets
				,d.ticketTrend
			FROM resources d
			WHERE d.position = "Developer"
		</cfquery>
		<cfscript>
			// set params structure for win loss broken build
			sWinLossChart = structNew();
			sWinLossChart.type = "winloss";
			sWinLossChart.backgroundColor = "ffffff";
			sWinLossChart.width = 124;
			sWinLossChart.height = 40;
			sWinLossChart.tickWidth = 10;
			sWinLossChart.gapWidth = 2;
			swinlosschart.backgroundColor = "999999";
			swinlosschart.highColor = "63DB18";
			swinlosschart.lowColor = "B70C13";

			WinLoss = createobject("component","Sparkline").init(argumentCollection = sWinLossChart);

		</cfscript>

		<cfoutput query="getDevs">
			<div class="gridBox width_1 height_2 resource">
				<div class="resImage"><img src="images/#image#" /></div>
				#name#<br />
				<div class="closed">#closedTickets#<img src="images/#ticketTrend#-arrow.png" height="50px"></div>
				#WinLoss.draw(last10Builds)#
			</div>
		</cfoutput>

	</cffunction>

	<cffunction name="getQA" access="remote" returntype="string">
		<cfquery datasource="cfObjective" name="getQ">
			SELECT
				q.name
				,q.image
				,q.last10Builds
				,q.openTickets
				,q.closedTickets
				,q.ticketTrend
			FROM resources q
			WHERE q.position = "QA"
		</cfquery>

		<cfoutput query="getQ">
			<div class="gridBox width_1 height_2 resource">
				<div class="resImage"><img src="images/#image#" /></div>
				#name#<br />
				<div class="closed">#closedTickets#<img src="images/#ticketTrend#-arrow.png" height="50px"></div>
			</div>
		</cfoutput>

	</cffunction>


	<!--- Gets the server date and time --->
	<cffunction name="serverTime" access="remote" returntype="string">
		<cfset var local = {} />

		<cfset local.time = now() />
		<cfset local.result = dateFormat(local.time, "dd mmm yyyy") & " - " & timeFormat(local.time, "hh:mm:ss") />

		<cfreturn local.result />
	</cffunction>

	<cffunction name="getTemp" access="remote" returntype="string">
		<cfhttp url="http://api.wunderground.com/api/e89ea5c609ee8f03/geolookup/conditions/forecast/q/MN/Saint_Paul.json"></cfhttp>
		<cfset weatherStruct = deserializeJSON(cfhttp.filecontent) />
		<cfscript>
			returnHTML = weatherStruct.current_observation.temp_f & 'f' & '<br />';
			returnHTML = returnHTML & '<img src="http://icons-ak.wxug.com/i/c/k/clear.gif" /><br />';
			returnHTML = returnHTML & '<div class="smallDate">' & timeFormat(DateAdd("s",weatherStruct.current_observation.local_epoch,DateConvert("utc2Local", "January 1 1970 00:00")),"h:mm tt") & '<br />';
			returnHTML = returnHTML & dateFormat(DateAdd("s",weatherStruct.current_observation.local_epoch,DateConvert("utc2Local", "January 1 1970 00:00")),"mmmm d") & '</div>';
		</cfscript>
		<cfreturn returnHTML />
	</cffunction>


</cfcomponent>