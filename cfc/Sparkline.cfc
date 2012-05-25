<cfcomponent>

	<cfset variables.instance = {}>
	
	<!--- Initialization --->
	
	<cffunction name="init" output="no" access="public" returntype="Component">
		<cfargument name="type" type="string" default="">
		<cfargument name="width" type="string" default="20">
		<cfargument name="height" type="string" default="20">
		<cfargument name="foregroundColors" type="string" default="000030">
		<cfargument name="backgroundColor" type="string" default="ffffff">
		<cfargument name="borderColor" type="string" default="000030">
		<cfargument name="highColor" type="string" default="00009C">
		<cfargument name="lowColor" type="string" default="8B0000">
		<cfargument name="borderWidth" type="string" default="1">
		<cfargument name="tickWidth" type="string" default="2">
		<cfargument name="gapWidth" type="string" default="1">
		<cfargument name="position" type="string" default="">
		<cfargument name="showHighLow" type="boolean" default="false">
		<cfargument name="showDataLabels" type="boolean" default="false">
		<cfargument name="qualitativeRanges" type="string" default="200">
		<cfargument name="qualitativeColors" type="string" default="BBBBBB">
		<cfargument name="referencePoints" type="string" default="">
		<cfargument name="referenceColors" type="string" default="000030">
		<cfargument name="performanceDot" type="boolean" default="false">
		<cfset setDefaultType(type)>
		<cfset setDefaultWidth(width)>
		<cfset setDefaultHeight(height)>
		<cfset setDefaultForegroundColors(foregroundColors)>
		<cfset setDefaultBackgroundColor(backgroundColor)>
		<cfset setDefaultBorderColor(borderColor)>
		<cfset setDefaultHighColor(highColor)>
		<cfset setDefaultLowColor(lowColor)>
		<cfset setDefaultBorderWidth(borderWidth)>
		<cfset setDefaultTickWidth(tickWidth)>
		<cfset setDefaultGapWidth(gapWidth)>
		<cfset setDefaultPosition(position)>
		<cfset setDefaultShowHighLow(showHighLow)>
		<cfset setDefaultShowDataLabels(showDataLabels)>
		<cfset setDefaultQualitativeRanges(qualitativeRanges)>
		<cfset setDefaultQualitativeColors(qualitativeColors)>
		<cfset setDefaultReferencePoints(referencePoints)>
		<cfset setDefaultReferenceColors(referenceColors)>
		<cfset setDefaultPerformanceDot(performanceDot)>
		<cfreturn this>
	</cffunction>

	<!--- Main --->
	
	<cffunction name="draw" output="no" access="public" returntype="string">
		<cfargument name="data" type="any" required="yes">
		<cfargument name="type" type="string" default="#getDefaultType()#">
		<cfargument name="width" type="numeric" default="#getDefaultWidth()#">
		<cfargument name="height" type="numeric" default="#getDefaultHeight()#">
		<cfargument name="foregroundColors" type="string" default="#getDefaultForegroundColors()#">
		<cfargument name="backgroundColor" type="string" default="#getDefaultBackgroundColor()#">
		<cfargument name="borderColor" type="string" default="#getDefaultBorderColor()#">
		<cfargument name="highColor" type="string" default="#getDefaultHighColor()#">
		<cfargument name="lowColor" type="string" default="#getDefaultLowColor()#">
		<cfargument name="borderWidth" type="string" default="#getDefaultBorderWidth()#">
		<cfargument name="tickWidth" type="string" default="#getDefaultTickWidth()#">
		<cfargument name="gapWidth" type="string" default="#getDefaultGapWidth()#">
		<cfargument name="position" type="string" default="#getDefaultPosition()#">
		<cfargument name="showHighLow" type="boolean" default="#getDefaultShowHighLow()#">
		<cfargument name="showDataLabels" type="boolean" default="#getDefaultShowDataLabels()#">
		<cfargument name="qualitativeRanges" type="string" default="#getDefaultQualitativeRanges()#">
		<cfargument name="qualitativeColors" type="string" default="#getDefaultQualitativeColors()#">
		<cfargument name="referencePoints" type="string" default="#getDefaultReferencePoints()#">
		<cfargument name="referenceColors" type="string" default="#getDefaultReferenceColors()#">
		<cfargument name="performanceDot" type="boolean" default="#getDefaultPerformanceDot()#">
		<cfswitch expression="#type#">
			<cfcase value="bulletgraph">
				<cfreturn bulletgraph(argumentcollection=arguments)>
			</cfcase>
			<cfcase value="column">
				<cfreturn column(argumentcollection=arguments)>
			</cfcase>
			<cfcase value="stackedbar">
				<cfreturn stackedbar(argumentcollection=arguments)>
			</cfcase>
			<cfcase value="fullstackedbar">
				<cfreturn fullstackedbar(argumentcollection=arguments)>
			</cfcase>
			<cfcase value="pie">
				<cfreturn pie(argumentcollection=arguments)>
			</cfcase>
			<cfcase value="winloss">
				<cfreturn winloss(argumentcollection=arguments)>
			</cfcase>
			<cfdefaultcase>
				<cfthrow message="Chart type unknown: #type#">
			</cfdefaultcase>
		</cfswitch>
	</cffunction>
	
	<!--- Charts --->
	
	<cffunction name="column" output="no" access="public" returntype="string">
		<cfargument name="data" type="any" required="yes">
		<cfargument name="showHighLow" type="boolean" default="#getDefaultShowHighLow()#">
		<cfargument name="width" type="numeric" default="#getDefaultWidth()#">
		<cfargument name="height" type="numeric" default="#getDefaultWidth()#">
		<cfargument name="foregroundColors" type="any" default="#getDefaultForegroundColors()#">
		<cfargument name="backgroundColor" type="string" default="#getDefaultBackgroundColor()#">
		<cfargument name="highColor" type="string" default="#getDefaultHighColor()#">
		<cfargument name="lowColor" type="string" default="#getDefaultLowColor()#">
		<cfargument name="tickWidth" type="string" default="#getDefaultTickWidth()#">
		<cfargument name="gapWidth" type="string" default="#getDefaultGapWidth()#">
		
		<cfset var myImage = ImageNew("", (listLen(data) * (tickWidth + (gapWidth * 2)) - (gapWidth)), height, "rgb", backgroundColor)>
		<cfset var primaryColor = listGetAt(foregroundColors, 1)>
		<cfset var tickHeight = height / 2>
		<cfset var xPosition = "">
		<cfset var maxValue = arrayMax(listToArray(data))>
		<cfset var minValue = arrayMin(listToArray(data))>
		
		<cfloop from="1" to="#listLen(data)#" index="i">
			<cfset xPosition = (i-1) * (tickWidth + (gapWidth * 2))>
			<cfset thisValue = listGetAt(data, i)>
			<cfset ImageSetDrawingColor(myImage, primaryColor)>
			
			<cfif showHighLow>
				<cfif thisValue eq maxValue>
					<cfset ImageSetDrawingColor(myImage, highColor)>
				<cfelseif thisValue eq minValue>
					<cfset ImageSetDrawingColor(myImage, lowColor)>
				</cfif>			
			</cfif>

			<cfset ImageDrawRect(myImage, xPosition, 20-thisValue, tickWidth, height, "yes")>
		</cfloop>
		<cfreturn generateImage(myImage)>
	</cffunction>
	
	<cffunction name="stackedbar" output="no" access="public" returntype="string">
		<cfargument name="data" type="any" required="yes">
		<cfargument name="width" type="numeric" default="#getDefaultWidth()#">
		<cfargument name="height" type="numeric" default="#getDefaultWidth()#">
		<cfargument name="foregroundColors" type="string" default="#getDefaultForegroundColors()#">
		<cfargument name="backgroundColor" type="string" default="#getDefaultBackgroundColor()#">
		<cfargument name="position" type="string" default="#getDefaultPosition()#">
		<cfargument name="showDataLabels" type="boolean" default="#getDefaultShowDataLabels()#">
		
		<cfset var myImage = ImageNew("", width, height, "rgb", backgroundColor)>
		<cfset var percentageTotal = width>
		<cfset var dataPosition = "">
		<cfset var dataPercentage = "">
		<cfset var dataTotal = arraySum(listToArray(data))>
		
		<cfif listLen(foregroundColors, "...") eq 2>
			<cfset foregroundColors = generateFadeList(foregroundColors, listLen(data))>
		</cfif>
		
		<cfswitch expression="#position#">
			<cfcase value="right">
				<cfset dataPosition = width>
				<cfloop from="1" to="#listLen(data)#" index="i">
					<cfset dataPercentage = (width * (listGetAt(data, i) / percentageTotal))>
					<cfset ImageSetDrawingColor(myImage, listGetAt(foregroundColors, i))>
					<cfset ImageDrawRect(myImage, dataPosition-dataPercentage, 0, dataPercentage, width,"yes")>
					<cfset dataPosition -= dataPercentage>
				</cfloop>
				<cfif showDataLabels>
					<cfset fontSize = 16>
					<cfset attr = {size=fontSize}>
					<cfset ImageDrawText(myImage, dataTotal, width - dataTotal - 30, int(height / 1.30), attr)>
				</cfif>
			</cfcase>
			
			<cfcase value="">
				<cfset dataPosition = 0>
				<cfloop from="1" to="#listLen(data)#" index="i">
					<cfset dataPercentage = (listGetAt(data,i) / percentageTotal)>
					<cfset ImageSetDrawingColor(myImage, listGetAt(foregroundColors, i))>
					<cfset ImageDrawRect(myImage,(dataPosition * width),0,(width * dataPercentage), height,"yes")>
					<cfset dataPosition += dataPercentage>
				</cfloop>
				
				<cfif showDataLabels>
					<cfset fontSize = 16>
					<cfset attr = {size=fontSize}>
					<cfset ImageDrawText(myImage, dataTotal, dataTotal + 5 , int(height / 1.30), attr)>				
				</cfif>
			</cfcase>
			<cfdefaultcase>
				<cfthrow message="Position is not recognized: ""#position#""">
			</cfdefaultcase>
		</cfswitch>
		
		<cfreturn generateImage(myImage)>
	</cffunction>
	
	<cffunction name="fullstackedbar" output="no" access="public" returntype="string">
		<cfargument name="data" type="any" required="yes">
		<cfargument name="width" type="numeric" default="#getDefaultWidth()#">
		<cfargument name="height" type="numeric" default="#getDefaultWidth()#">
		<cfargument name="foregroundColors" type="string" default="#getDefaultForegroundColors()#">
		<cfargument name="backgroundColor" type="string" default="#getDefaultBackgroundColor()#">
				
		<cfset var myImage = ImageNew("", width, height, "rgb", backgroundColor)>
		<cfset var percentageTotal = arraySum(listToArray(data))>
		<cfset var dataPosition = 0>
		<cfset var dataPercentage = "">

		<cfif listLen(foregroundColors, "...") eq 2>
			<cfset foregroundColors = generateFadeList(foregroundColors, listLen(data))>
		</cfif>
		
		<cfloop from="1" to="#listLen(data)#" index="i">
			<cfset dataPercentage = (listGetAt(data, i) / percentageTotal)>
			<cfset ImageSetDrawingColor(myImage, listGetAt(foregroundColors, i))>
			<cfset ImageDrawRect(myImage, (dataPosition * width), 0, (width * dataPercentage), height,"yes")>
			<cfset dataPosition += dataPercentage>
		</cfloop>
			
		<cfreturn generateImage(myImage)>
	</cffunction>
	
	<cffunction name="pie" output="no" access="public" returntype="string">
		<cfargument name="data" type="any" required="yes">
		<cfargument name="width" type="numeric" default="#getDefaultWidth()#">
		<cfargument name="height" type="numeric" default="#getDefaultWidth()#">
		<cfargument name="foregroundColors" type="string" default="#getDefaultForegroundColors()#">
		<cfargument name="backgroundColor" type="string" default="#getDefaultBackgroundColor()#">
		<cfargument name="borderColor" type="string" default="#getDefaultBorderColor()#">
		<cfargument name="borderWidth" type="numeric" default="#getDefaultBorderWidth()#">
		
		<cfset var myImage = ImageNew("", width, height, "rgb", backgroundColor)>
		<cfset var percentageTotal = arraySum(listToArray(data))>
		<cfset var dataPosition = "">
		<cfset var dataPercentage = "">
		<cfset var arcStart = 90>

		<cfif listLen(foregroundColors, "...") eq 2>
			<cfset foregroundColors = generateFadeList(foregroundColors, listLen(data))>
		</cfif>
		
		<cfset ImageSetAntialiasing(myImage)>
		
		<cfloop from="1" to="#listLen(data)#" index="i">
			<cfset dataPercentage = (-360 * (listGetAt(data, i) / percentageTotal))>
			<cfset ImageSetDrawingColor(myImage, listGetAt(foregroundColors, i))>
			<cfset ImageDrawArc(myImage, 0, 0, width, height, arcStart, dataPercentage-2, "yes")>
			<cfset arcStart += dataPercentage>
		</cfloop>
		
		<cfif borderWidth gt 0>
			<cfscript>
				attr=StructNew();
				attr.width = borderWidth;				
				ImageSetDrawingStroke(myImage, attr);
				ImageSetDrawingColor(myImage, borderColor);
				ImageDrawOval(myImage, 0, 0, (width -1), (height -1));
			</cfscript>
		</cfif>
		<cfreturn generateImage(myImage)>
	</cffunction>
	
	<cffunction name="winloss" output="no" access="public" returntype="string">
		<cfargument name="data" type="any" required="yes">
		<cfargument name="width" type="numeric" default="#getDefaultWidth()#">
		<cfargument name="height" type="numeric" default="#getDefaultWidth()#">
		<cfargument name="highColor" type="string" default="#getDefaultHighColor()#">
		<cfargument name="lowColor" type="string" default="#getDefaultLowColor()#">
		<cfargument name="backgroundColor" type="string" default="#getDefaultBackgroundColor()#">
		<cfargument name="borderColor" type="string" default="#getDefaultBorderColor()#">
		<cfargument name="tickWidth" type="string" default="#getDefaultTickWidth()#">
		<cfargument name="gapWidth" type="string" default="#getDefaultGapWidth()#">
		
		<cfset var myImage = "">
		<cfset var tickHeight = height / 2>
		<cfset var xPosition = "">
		
		<cfset width = (listLen(data) * (tickWidth + (gapWidth * 2)) - (gapWidth))>
		
		<cfset myImage = ImageNew("", width, height, "rgb", backgroundColor)>
		
		<cfloop from="1" to="#listLen(data)#" index="i">
			<cfset xPosition = (i-1) * (tickWidth + (gapWidth * 2))>
			<cfswitch expression="#listGetAt(data, i)#">
				<cfcase value="1">
					<cfset ImageSetDrawingColor(myImage, highColor)>
					<cfset ImageDrawRect(myImage, xPosition, 0, tickWidth, tickHeight, "yes")>
				</cfcase>
				<cfcase value="-1">
					<cfset ImageSetDrawingColor(myImage, lowColor)>
					<cfset ImageDrawRect(myImage, xPosition, tickHeight, tickWidth, tickHeight, "yes")>
				</cfcase>
				<cfcase value="0">
					<cfset ImageSetDrawingColor(myImage, "black")>
					<cfset ImageDrawRect(myImage, xPosition-1, tickHeight, tickWidth+2, 0, "yes")>				
				</cfcase>
			</cfswitch>
		</cfloop>
		
		<cfreturn generateImage(myImage)>
	</cffunction>
	
	<cffunction name="bulletgraph" output="no" access="public" returntype="string">
		<cfargument name="data" type="any" required="yes">
		<cfargument name="width" type="numeric" default="#getDefaultWidth()#">
		<cfargument name="height" type="numeric" default="#getDefaultWidth()#">
		<cfargument name="foregroundColors" type="string" default="#getDefaultForegroundColors()#">
		<cfargument name="backgroundColor" type="string" default="#getDefaultBackgroundColor()#">
		<cfargument name="qualitativeRanges" type="string" default="#getDefaultQualitativeRanges()#">
		<cfargument name="qualitativeColors" type="string" default="#getDefaultQualitativeColors()#">
		<cfargument name="referencePoints" type="string" default="#getDefaultReferencePoints()#">
		<cfargument name="referenceColors" type="string" default="#getDefaultReferenceColors()#">
		<cfargument name="performanceDot" type="boolean" default="#getDefaultPerformanceDot()#">

				
		<cfset var myImage = ImageNew("", width, height, "rgb", backgroundColor)>
		<cfset var percentageTotal = listLast(arguments.qualitativeRanges)>
		<cfset var dataPosition = 0>
		<cfset var dataPercentage = "">
<!--- 

		<cfif listLen(foregroundColors, "...") eq 2>
			<cfset foregroundColors = generateFadeList(foregroundColors, listLen(data))>
		</cfif>
 --->
		<!--- Draw Qualitative Ranges --->		
		<cfloop from="1" to="#listLen(arguments.qualitativeRanges)#" index="i">
			<cfset dataPercentage = ((listGetAt(arguments.qualitativeRanges, i) / percentageTotal) - dataPosition)>
			<cfset ImageSetDrawingColor(myImage, listGetAt(arguments.qualitativeColors, i))>
			<cfset ImageDrawRect(myImage, (dataPosition * width), 0, (width * dataPercentage), height,"yes")>
			<cfset dataPosition += dataPercentage>
		</cfloop>
		<!--- Drop Reference Markers Here --->
		<cfloop from="1" to="#listLen(arguments.referencePoints)#" index="i">
			<cfif listLen(arguments.referenceColors) gte i>
				<cfset ImageSetDrawingColor(myImage, listGetAt(arguments.referenceColors, i))>
			</cfif>
			<cfset ImageDrawRect(myImage, width * (listGetAt(arguments.referencePoints, i) / percentageTotal), height * 0.1, (width * 0.005), height * 0.8,"yes")>
		</cfloop>
		
		<!--- Draw Performance bar --->
		<cfset dataPosition = 0>
		<cfset dataPercentage = "">
		<cfloop from="1" to="#listLen(data)#" index="i">
			<cfset dataPercentage = (listGetAt(data, i) / percentageTotal)>
			<cfset ImageSetDrawingColor(myImage, listGetAt(arguments.foregroundColors, i))>
			<cfif arguments.performanceDot>
				<cfset ImageDrawRect(myImage, ((width * dataPercentage) - (width * 0.02)), height * 0.4, (width * 0.02), height * 0.2,"yes")>
			<cfelse>
				<cfset dataPercentage -= dataPosition>
				<cfset ImageDrawRect(myImage, (dataPosition * width), height * 0.4, (width * dataPercentage), height * 0.2,"yes")>
			</cfif>
			<cfset dataPosition += dataPercentage>
		</cfloop>
		<cfreturn generateImage(myImage)>
	</cffunction>


	<!--- Private --->
	
	<cffunction name="generateImage" output="no" access="private" returntype="string">
		<cfargument name="image" required="yes">
		<cfset var imagePath = "">
		<cfsavecontent variable="imagePath">
			<cfimage action="writeToBrowser" source="#image#">
		</cfsavecontent>
		<cfreturn imagePath>
	</cffunction>	

	<cffunction name="generateFadeList" output="no" access="private" returntype="string">
		<cfargument name="colors" type="string" required="true">
		<cfargument name="steps" type="numeric" required="true">
		<cfset var startColor = listGetAt(colors, 1, "...")>
		<cfset var endColor = listGetAt(colors, 2, "...")>
		<cfscript>
			var outlist=startcolor;
			var decr=0;
			var decg=0;
			var decb=0;
			var newr=0;
			var newg=0;
			var newb=0;
			var ix = 1;
		
			steps=steps-1;
			decr=(inputbasen(left(startcolor,2),16)-inputbasen(left(endcolor,2),16))/steps;
			decg=(inputbasen(mid(startcolor,3,2),16)-inputbasen(mid(endcolor,3,2),16))/steps;
			decb=(inputbasen(right(startcolor,2),16)-inputbasen(right(endcolor,2),16))/steps;
			for (ix=1;ix lte steps;ix=ix+1) {
				newr=formatbasen(int(inputbasen(left(startcolor,2),16)-(ix*decr)),16);
				if (len(newr) eq 1) {newr="0"&newr;}
				newg=formatbasen(int(inputbasen(mid(startcolor,3,2),16)-(ix*decg)),16);
				if (len(newg) eq 1) {newg="0"&newg;}
				newb=formatbasen(int(inputbasen(right(startcolor,2),16)-(ix*decb)),16);
				if (len(newb) eq 1) {newb="0"&newb;}
				outlist=outlist&","&newr&newg&newb;
			}
			return outlist & "," & endcolor;
		</cfscript>
	</cffunction>

	<!--- Getters/Setters --->

	<cffunction name="getDefaultType" output="no" access="public" returntype="string">
		<cfreturn variables.instance.defaultType>
	</cffunction>
	<cffunction name="setDefaultType" output="no" access="public" returntype="void">
		<cfargument name="defaultType" type="string" required="true">
		<cfset variables.instance.defaultType = arguments.defaultType>
	</cffunction>

	<cffunction name="getDefaultWidth" output="no" access="public" returntype="numeric">
		<cfreturn variables.instance.defaultWidth>
	</cffunction>
	<cffunction name="setDefaultWidth" output="no" access="public" returntype="void">
		<cfargument name="defaultWidth" type="numeric" required="true">
		<cfset variables.instance.defaultWidth = arguments.defaultWidth>
	</cffunction>

	<cffunction name="getDefaultHeight" output="no" access="public" returntype="numeric">
		<cfreturn variables.instance.defaultHeight>
	</cffunction>
	<cffunction name="setDefaultHeight" output="no" access="public" returntype="void">
		<cfargument name="defaultHeight" type="numeric" required="true">
		<cfset variables.instance.defaultHeight = arguments.defaultHeight>
	</cffunction>

	<cffunction name="getDefaultForegroundColors" output="no" access="public" returntype="string">
		<cfreturn variables.instance.defaultForegroundColors>
	</cffunction>
	<cffunction name="setDefaultForegroundColors" output="no" access="public" returntype="void">
		<cfargument name="defaultForegroundColors" type="string" required="true">
		<cfset variables.instance.defaultForegroundColors = arguments.defaultForegroundColors>
	</cffunction>

	<cffunction name="getDefaultBackgroundColor" output="no" access="public" returntype="string">
		<cfreturn variables.instance.defaultBackgroundColor>
	</cffunction>
	<cffunction name="setDefaultBackgroundColor" output="no" access="public" returntype="void">
		<cfargument name="defaultBackgroundColor" type="string" required="true">
		<cfset variables.instance.defaultBackgroundColor = arguments.defaultBackgroundColor>
	</cffunction>

	<cffunction name="getDefaultBorderColor" output="no" access="public" returntype="string">
		<cfreturn variables.instance.defaultBorderColor>
	</cffunction>
	<cffunction name="setDefaultBorderColor" output="no" access="public" returntype="void">
		<cfargument name="defaultBorderColor" type="string" required="true">
		<cfset variables.instance.defaultBorderColor = arguments.defaultBorderColor>
	</cffunction>
	
	<cffunction name="getDefaultLowColor" output="no" access="public" returntype="string">
		<cfreturn variables.instance.defaultLowColor>
	</cffunction>
	<cffunction name="setDefaultLowColor" output="no" access="public" returntype="void">
		<cfargument name="defaultLowColor" type="string" required="true">
		<cfset variables.instance.defaultLowColor = arguments.defaultLowColor>
	</cffunction>
	
	<cffunction name="getDefaultHighColor" output="no" access="public" returntype="string">
		<cfreturn variables.instance.defaultHighColor>
	</cffunction>
	<cffunction name="setDefaultHighColor" output="no" access="public" returntype="void">
		<cfargument name="defaultHighColor" type="string" required="true">
		<cfset variables.instance.defaultHighColor = arguments.defaultHighColor>
	</cffunction>
	
	<cffunction name="getDefaultBorderWidth" output="no" access="public" returntype="numeric">
		<cfreturn variables.instance.borderWidth>
	</cffunction>
	<cffunction name="setDefaultBorderWidth" output="no" access="public" returntype="void">
		<cfargument name="borderWidth" type="numeric" required="true">
		<cfset variables.instance.borderWidth = arguments.borderWidth>
	</cffunction>

	<cffunction name="getDefaultTickWidth" output="no" access="public" returntype="numeric">
		<cfreturn variables.instance.tickWidth>
	</cffunction>
	<cffunction name="setDefaultTickWidth" output="no" access="public" returntype="void">
		<cfargument name="tickWidth" type="numeric" required="true">
		<cfset variables.instance.tickWidth = arguments.tickWidth>
	</cffunction>

	<cffunction name="getDefaultGapWidth" output="no" access="public" returntype="numeric">
		<cfreturn variables.instance.gapWidth>
	</cffunction>
	<cffunction name="setDefaultGapWidth" output="no" access="public" returntype="void">
		<cfargument name="gapWidth" type="numeric" required="true">
		<cfset variables.instance.gapWidth = arguments.gapWidth>
	</cffunction>

	<cffunction name="getDefaultPosition" output="no" access="public" returntype="string">
		<cfreturn variables.instance.position>
	</cffunction>
	<cffunction name="setDefaultPosition" output="no" access="public" returntype="void">
		<cfargument name="position" type="string" required="true">
		<cfset variables.instance.position = arguments.position>
	</cffunction>

	<cffunction name="getDefaultShowHighLow" output="no" access="public" returntype="boolean">
		<cfreturn variables.instance.showHighLow>
	</cffunction>
	<cffunction name="setDefaultShowHighLow" output="no" access="public" returntype="void">
		<cfargument name="showHighLow" type="boolean" required="true">
		<cfset variables.instance.showHighLow = arguments.showHighLow>
	</cffunction>

	<cffunction name="getDefaultShowDataLabels" output="no" access="public" returntype="boolean">
		<cfreturn variables.instance.showDataLabels>
	</cffunction>
	<cffunction name="setDefaultShowDataLabels" output="no" access="public" returntype="void">
		<cfargument name="showDataLabels" type="boolean" required="true">
		<cfset variables.instance.showDataLabels = arguments.showDataLabels>
	</cffunction>

	<cffunction name="getDefaultQualitativeRanges" output="no" access="public" returntype="string">
		<cfreturn variables.instance.qualitativeRanges>
	</cffunction>
	<cffunction name="setDefaultQualitativeRanges" output="no" access="public" returntype="void">
		<cfargument name="qualitativeRanges" type="string" required="true">
		<cfset variables.instance.qualitativeRanges = arguments.qualitativeRanges>
	</cffunction>

	<cffunction name="getDefaultQualitativeColors" output="no" access="public" returntype="string">
		<cfreturn variables.instance.qualitativeColors>
	</cffunction>
	<cffunction name="setDefaultQualitativeColors" output="no" access="public" returntype="void">
		<cfargument name="qualitativeColors" type="string" required="true">
		<cfset variables.instance.qualitativeColors = arguments.qualitativeColors>
	</cffunction>

	<cffunction name="getDefaultReferencePoints" output="no" access="public" returntype="string">
		<cfreturn variables.instance.referencePoints>
	</cffunction>
	<cffunction name="setDefaultReferencePoints" output="no" access="public" returntype="void">
		<cfargument name="referencePoints" type="string" required="true">
		<cfset variables.instance.referencePoints = arguments.referencePoints>
	</cffunction>

	<cffunction name="getDefaultReferenceColors" output="no" access="public" returntype="string">
		<cfreturn variables.instance.referenceColors>
	</cffunction>
	<cffunction name="setDefaultReferenceColors" output="no" access="public" returntype="void">
		<cfargument name="referenceColors" type="string" required="true">
		<cfset variables.instance.referenceColors = arguments.referenceColors>
	</cffunction>

	<cffunction name="getDefaultPerformanceDot" output="no" access="public" returntype="boolean">
		<cfreturn variables.instance.performanceDot>
	</cffunction>
	<cffunction name="setDefaultPerformanceDot" output="no" access="public" returntype="void">
		<cfargument name="PerformanceDot" type="boolean" required="true">
		<cfset variables.instance.PerformanceDot = arguments.PerformanceDot>
	</cffunction>

</cfcomponent>