<!--
/**
 *@version 3.2.0.1
 **/ 
-->
<%@page import="org.apache.xmlbeans.impl.xb.xsdschema.IncludeDocument.Include"%><%@ page import="java.util.Date" %><%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %><%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%><%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%><%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %><%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %><%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>{sitemapCifFunction22}
<script type="text/javascript">
<!--
alert("{sitemapFunction23}");
//-->
</script>
{sitemapCifEnd}
<div class="Jnit_sitemap">
    {sitemapForeach1}
        <ul class="sitemap_Dept01">
            <li><a href="{sitemapFunction1}">{sitemapFunction2}</a>
            <ul class="sitemap_Dept02">
            {sitemapCifFunction1}
                {sitemapForeach2}
					{sitemapCifFunction2}	                    
						<li>
	                    {sitemapCifFunction3}
							<a href="{sitemapFunction3}" title="{sitemapFunction4}">{sitemapFunction7}</a>
						{sitemapCifEnd}
	                    {sitemapCifFunction4}
							<a href="{sitemapFunction8}" title="{sitemapFunction7} 링크가 새창으로 열립니다." target="{sitemapFunction5}"  rel="{sitemapFunction6}">{sitemapFunction7}
								{sitemapCifFunction5}
									<img src="/resources/img/jnit_icon_new.gif" alt="새창" />
								{sitemapCifEnd}
							</a>
						{sitemapCifEnd}
	                    {sitemapCifFunction6}
	                        <ul class="sitemap_Dept03">
	                            {sitemapForeach3}
									{sitemapCifFunction7}
	                                <li>
		                                {sitemapCifFunction8}
											<a href="{sitemapFunction9}" title="{sitemapFunction10}">{sitemapFunction10}</a>
										{sitemapCifEnd}
					                    {sitemapCifFunction9}
											<a href="{sitemapFunction11}" title="{sitemapFunction10} 링크가 새창으로 열립니다." target="{sitemapFunction12}"  rel="{sitemapFunction13}">{sitemapFunction10}
												{sitemapCifFunction10}
													<img src="/resources/img/jnit_icon_new.gif" alt="새창" />
												{sitemapCifEnd}
											</a>
										{sitemapCifEnd}
		                                {sitemapCifFunction11}
		                                    <ul class="sitemap_Dept04">
		                                        {sitemapForeach4}
													{sitemapCifFunction12}
		                                            <li>
			                                            {sitemapCifFunction13}
															<a href="{sitemapFunction14}" title="{sitemapFunction15}">{sitemapFunction15}</a>
														{sitemapCifEnd}
									                    {sitemapCifFunction14}
															<a href="{sitemapCifFunction15}" title="{sitemapFunction15} 링크가 새창으로 열립니다." target="{sitemapFunction16}"  rel="{sitemapFunction17}">{sitemapFunction15}
																{sitemapCifFunction16}
																	<img src="/resources/img/jnit_icon_new.gif" alt="새창" />
																{sitemapCifEnd}
															</a>
														{sitemapCifEnd}
			                                            {sitemapCifFunction17}
			                                                <ul class="sitemap_Dept05">
			                                                    {sitemapForeach5}
																	{sitemapCifFunction18}
			                                                        <li>
			                                                       {sitemapCifFunction19}
																		<a href="{sitemapFunction18}" title="{sitemapFunction19}">{sitemapFunction19}</a>
																	{sitemapCifEnd}
												                    {sitemapCifFunction20}
																		<a href="{sitemapFunction20}" title="{sitemapFunction19} 링크가 새창으로 열립니다." target="{sitemapFunction21}"  rel="{sitemapFunction22}">{sitemapFunction19}
																			{sitemapCifFunction21}
																				<img src="/resources/img/jnit_icon_new.gif" alt="새창" />
																			{sitemapCifEnd}
																		</a>
																	{sitemapCifEnd}
			                                                        </li>
																	{sitemapCifEnd}
			                                                    {sitemapForeachEnd}
			                                                </ul>
			                                            {sitemapCifEnd}
		                                            </li>
													{sitemapCifEnd}
		                                        {sitemapForeachEnd}
		                                    </ul>
		                                {sitemapCifEnd}
									</li>
									{sitemapCifEnd}
	                            {sitemapForeachEnd}
	                        </ul>
						{sitemapCifEnd}
						</li>	                    
					{sitemapCifEnd}
				{sitemapForeachEnd}
				</ul>
			{sitemapCifEnd}
			</li>
			</ul>
	{sitemapForeachEnd}
</div>
