<html>
<head>
<title>hello!</title>
</head>
<body>
<#include "/header.ftl"/>
<#import "/macros.ftl" as macros/>

<#-- 搜索条件 start -->
<#assign url>${uri}?</#assign>
<div>
<form method="GET" action="${url}1=1&${G.toUri2(paramMap)}">
id<input type="text" value="${paramMap.q_i_a_e_id!}" class="qq" name="q_i_a_e_id"/><br>
name<input type="text" value="${paramMap.q_s_a_li_name!}" class="qq" name="q_s_a_li_name"/><br>
age<input type="text" value="${paramMap.q_i_a_e_age!}" class="qq" name="q_i_a_e_age"/><br>
日期小于<input type="text" value="${paramMap.q_d_a_l_createtime!}" class="qq" name="q_d_a_l_createtime"/><br>
日期大于<input type="text" value="${paramMap.q_d_a_g_createtime!}" class="qq" name="q_d_a_g_createtime"/><br>
companyid<input type="text" value="${paramMap.q_i_a_e_companyid!}" class="qq" name="q_i_a_e_companyid"/><br>
<input type="submit">
</form>
<form method="GET" action="${uri}">
<input type="submit" value="取消">
</form>
</div>
<#-- 搜索条件end -->
<hr>

<#-- 表格 start -->
<table style="border:1px;" border=1>
<tr><#list colNames as colName>
<td>${colName}</td>
</#list></tr>
<#list listAll as one>
<tr><td>${one.id!}</td><td>${one.name!}</td><td>${one.age!}</td><td>${G.toDateStr(one.createtime)!}</td><td>${one.companyname!}</td></tr>
</#list>
</table>
<#-- 表格 end -->

<#-- 分页start -->
<#assign url>${uri}?1=1&${G.toUri(paramMap,"page",null)}</#assign>
<@macros.pager page=paramMap.page?number pageSize=10 total=total url=url/>
<#-- 分页end -->

</body>
</html>
