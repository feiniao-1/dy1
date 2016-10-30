<#macro pager page pageSize total url>
	<#local showCount=3>
	<#local sideCount=2>
	<#if total%pageSize==0 && total!=0>
		<#local pageNo=(total/pageSize)>
	<#else>
		<#local pageNo=(total/pageSize)?int+1>
	</#if>
	<#if (page-showCount>1+sideCount)>
		<#local left=1>
	<#else>
		<#local left=0>
	</#if>
	<#if (page+showCount<pageNo-sideCount)>
		<#local right=1>
	<#else>
		<#local right=0>
	</#if>
	<#local leftNo=sideCount>
	<#if (leftNo>pageNo)>
		<#local leftNo=pageNo>
	</#if>
	<#local midNo1=page-showCount>
	<#if (midNo1<=leftNo)>
		<#local midNo1=leftNo+1>
	</#if>
	<#local midNo2=page+showCount>
	<#if (midNo2>pageNo)>
		<#local midNo2=pageNo>
	</#if>
	<#local rightNo=pageNo-sideCount+1>
	<#if (rightNo<=midNo2)>
		<#local rightNo=midNo2+1>
	</#if>
	<@subPager left=1 right=leftNo page=page url=url/>
	<#if left==1>
		&hellip;
	</#if>
	<#if midNo1<=midNo2>
	    <@subPager left=midNo1 right=midNo2 page=page url=url/>
	</#if>
	<#if right==1>
		&hellip;
	</#if>
	<#if (rightNo<=pageNo)>
		<@subPager left=rightNo right=pageNo page=page url=url/>
	</#if>
	<br>
<#--
	pageNo:${pageNo}<br>
	leftNo:${leftNo}<br>
	left:${left}<br>
	midNo1:${midNo1}<br>
	midNo2:${midNo2}<br>
	right:${right}<br>
	rightNo:${rightNo}<br>
-->
</#macro>
<#macro subPager left right page url>
	<#list left..right as nowCount>
		<#if nowCount==page>
			<a href="${url}&page=${nowCount}">[${nowCount}]</a>
		<#else>
			<a href="${url}&page=${nowCount}">${nowCount}</a>
		</#if>
	</#list>
</#macro>
