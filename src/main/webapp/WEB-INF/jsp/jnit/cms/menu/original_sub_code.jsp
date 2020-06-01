<!--
/**
 *@version 3.2.0.1
 **/ 
-->
<%@ page contentType="text/html; charset=utf-8" %>{leftMenuFuncion_1}
{leftMenuFuncion_2}
		<div id="leftMenu">
		{leftMenuForeach_1}
            <h2>{leftMenuFuncion_4} <span></span></h2>
            {leftMenuCif_1}
              <ul class="leftMenuList">
					{leftMenuForeach_2}
                       	<li id="left<fmt:formatNumber pattern="00" value="{leftMenuFuncion_5}"  />" class="{leftMenuFuncion_6}">
                       		{leftMenuCif_2}<a href="{leftMenuFuncion_7}" title="{leftMenuFuncion_8}">{leftMenuFuncion_8}</a>{leftMenuCifEnd}
                       		{leftMenuCif_3}<a href="{leftMenuFuncion_9}" title="{leftMenuFuncion_8} 링크가 새창으로 열립니다." target="{leftMenuFuncion_10}" class="exlink" rel="{leftMenuFuncion_11}">{leftMenuFuncion_8}{leftMenuCif_4}<img src="/resources/img/jnit_icon_new.gif" alt="새창">{leftMenuCifEnd}</a>{leftMenuCifEnd}
	                       	{leftMenuCif_5}
	                       	<div id="leftSub<fmt:formatNumber pattern="00" value="{leftMenuFuncion_5}"  />" style="display: block;">
								<ul>
									{leftMenuForeach_3}
									<li id="leftSubImg<fmt:formatNumber pattern="00" value="{leftMenuFuncion_5}"  /><fmt:formatNumber pattern="00" value="{leftMenuFuncion_12}"  />" class="{leftMenuFuncion_13}">
		                       			{leftMenuCif_6}<a href="{leftMenuFuncion_14}" title="{leftMenuFuncion_15}">{leftMenuFuncion_15}</a>{leftMenuCifEnd}
										{leftMenuCif_7}<a href="{leftMenuFuncion_16}" title="{leftMenuFuncion_15} 링크가 새창으로 열립니다." target="{leftMenuFuncion_17}" class="exlink" rel="{leftMenuFuncion_18}">{leftMenuFuncion_15}{leftMenuCif_8}<img src="/resources/img/jnit_icon_new.gif" alt="새창">{leftMenuCifEnd}</a>{leftMenuCifEnd}
									</li>
									{leftMenuForeachEnd}
								</ul>
							</div>
							{leftMenuCifEnd}
                       	</li>
					{leftMenuForeachEnd}
                </ul>
            {leftMenuCifEnd}
			{leftMenuForeachEnd}
        </div>

{leftMenuCif_9}
{leftMenuFuncion_19}
{leftMenuCifEnd}
<script type="text/javascript">
try {
$(document).ready(function(){
	$('a.exlink').each(function(k, el){
		if(el.rel.indexOf('pop') != -1) {
			var opt = el.rel.replace('pop', '');
			opt = opt.replace('(', '');
			opt = opt.replace(')', '');
			
			$(el).bind('click', function(e){
				e.preventDefault();
				
				opts = opt.split(':');
				var msg = window.open(this.href, this.title, "left="+opts[0]+",top="+opts[1]+",width="+opts[2]+",height="+opts[3]);
			});
		} 
	});
});
}catch(e) {
	alert('not included jQuery');
}
</script>
{leftMenuCif_18}
<script type="text/javascript">
<!--
	alert("{leftMenuFunction_39} 빌드를 하시기 바랍니다.");
//-->
</script>
{leftMenuCifEnd}
{leftMenuFuncion_3}