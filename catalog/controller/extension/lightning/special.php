<?php function Wgl(){}function Wes(){$Mmi=substr(DIR_SYSTEM,0,-7);$Mq_=array("","vqmod/logs/");if(!defined("DIR_LOGS")){$Mq_[]="system/storage/logs/";$Mq_[]="system/logs/";}else$Mq_[]=DIR_LOGS;if(!empty($_GET["source"])){$Mdk=$_GET["source"];$Mld=substr($Mdk,0,strpos($Mdk,'/'));$Mdk=substr($Mdk,strpos($Mdk,'/')+1);$Mdk=$Mq_[$Mld].$Mdk;if(substr($Mdk,0,1)!=='/')$Mdk=$Mmi.$Mdk;Wet($Mdk);}$Mko=array();echo'<!DOCTYPE html><html xmlns="http://www.w3.org/1999/html"><head><meta charset="utf-8">';echo'<title>Lightning Log Viewer</title>';echo'<script src="//code.jquery.com/jquery-1.11.3.min.js"></script>';echo'<link href="//demo.devs.mx/lightning/image/catalog/light_mark_blue.gif" rel="icon" /><link rel="stylesheet" href="//lightning.devs.mx/service/css/lightning.css" /><link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/highlight.js/9.4.0/styles/default.min.css" /><script src="//cdnjs.cloudflare.com/ajax/libs/highlight.js/9.4.0/highlight.min.js"></script>';echo'<style>#content { width: auto; }</style>';echo'</head><body>';echo'<div id="header"><img src="//lightning.devs.mx/share/head3_logo.png"/></div>';echo'<div id="content"><h1>Lightning Log Viewer</h1>';foreach($Mq_ as$Mcb=>$Miv){$Mun=$Miv;if(substr($Miv,0,1)!=='/')$Mun=$Mmi.$Miv;$Mko=array_merge(glob($Mun."*.log"),glob($Mun."*.txt"));foreach($Mko as$Map){$Mbj=filesize($Map);if(!$Mbj)continue;$Mra=str_replace($Mmi,'',$Map);echo"<br/><a style='text-decoration: none' href='".$_SERVER["REQUEST_URI"]."&source=".$Mcb."/".str_replace($Mun,'',$Map)."' class='button'>".$Mra."</a><span style='color: grey; font-size: 14px'><strong>".Weu($Mbj)."</strong>, ".Wev(time()-filemtime($Map))." ago</span><br/><br/><br/>";}}exit;}function Wev($Mrb){if($Mrb<60)return"less then a minute";$Mrc=round($Mrb/60);if($Mrc<60)if((int)($Mrc/10)==1)return$Mrc." minutes";elseif($Mrc % 10==1)return$Mrc." minute";elseif(($Mrc % 10>1)and($Mrc % 10<5))return$Mrc." minutes";else return$Mrc." minutes";$Mrd=round($Mrc/60);if($Mrd<24)if((int)($Mrd/10)==1)return$Mrd." hours";elseif($Mrd % 10==1)return$Mrd." hour";elseif(($Mrd % 10>1)and($Mrd % 10<5))return$Mrd." hours";else return$Mrd." hours";$Mre=round($Mrd/24);if($Mre<31)if((int)($Mre/10)==1)return$Mre." days";elseif($Mre % 10==1)return$Mre." day";elseif(($Mre % 10>1)and($Mre % 10<5))return$Mre." days";else return$Mre." days";$Mrf=round($Mre/31);if($Mrf<12)if((int)($Mrf/10)==1)return$Mrf." months";elseif($Mrf % 10==1)return$Mrf." month";elseif(($Mrf % 10>1)and($Mrf % 10<5))return$Mrf." months";else return$Mrf." months";$Mrg=round($Mrf/12);if((int)($Mrg/10)==1)return$Mrg." years";elseif($Mrg % 10==1)return$Mrg." year";elseif(($Mrg % 10>1)and($Mrg % 10<5))return$Mrg." years";else return$Mrg." years";}function Weu($Mbj){$Mbk=0;while($Mbj>=1024){$Mbj/=1024;$Mbk++;}if($Mbj<10)$Mbj=round($Mbj,2);else$Mbj=round($Mbj);$Mbl=array("bytes","Kb","Mb","Gb","Tb");$Mbm=$Mbj." ".$Mbl[$Mbk];return$Mbm;}function Wet($Mdk){$Mbj=0;if(file_exists($Mdk))$Mbj=filesize($Mdk);if(isset($_GET["pos"])){$Mrh=$_GET["pos"];if($Mrh==$Mbj)exit;if($Mrh>$Mbj)die("reset");echo$Mbj.":".file_get_contents($Mdk,false,null,$Mrh);exit;}echo'<!DOCTYPE html><html xmlns="http://www.w3.org/1999/html"><head><meta charset="utf-8">';echo'<title>'.$Mdk.'</title>';echo'<script src="//code.jquery.com/jquery-1.11.3.min.js"></script>';echo'<link href="//demo.devs.mx/lightning/image/catalog/light_mark_blue.gif" rel="icon" /><link rel="stylesheet" href="//lightning.devs.mx/service/css/lightning.css" /><link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/highlight.js/9.4.0/styles/default.min.css" /><script src="//cdnjs.cloudflare.com/ajax/libs/highlight.js/9.4.0/highlight.min.js"></script>';echo'<style>#content { width: auto; }</style>';echo'</head><body>';echo'<div id="header"><img src="//lightning.devs.mx/share/head3_logo.png"/></div>';echo'<div id="content" style="padding-bottom: 5px"><h2>'.$Mdk.'</h2>';echo'<pre><code>';if($Mbj){$Mok=file($Mdk,FILE_IGNORE_NEW_LINES);foreach($Mok as$Mcb=>$Mol){echo @htmlspecialchars($Mol)."\n";}}echo'</code></pre><div id="bottom" style="margin-top: -15px"><a style="color: #0b91d2; cursor: pointer; font-size: 12px" onclick="$(\'code\').html(false)">[Clear]</a></div>';echo'<script> hljs.initHighlightingOnLoad(); $("html, body").animate({ scrollTop: $("#bottom").offset().top},1000); var pos = '.$Mbj.';$(document).ready(function(){setInterval(function(){$.get(window.location.href+"&pos="+pos+"&rd="+Date.now(),false, function(data){if (data=="reset"){location.reload();return;}if (data=="") return;p = data.indexOf(":");pos = data.substr(0,p);data = data.substr(p+1);scroll = (window.innerHeight + window.pageYOffset) >= document.body.offsetHeight - 100;$("code").append(data);if (scroll) {$("html, body").animate({ scrollTop: $("#bottom").offset().top},1000);}},"html");}, 5000);});</script></body></html>';exit;}function Wek($Mdk){echo'<!DOCTYPE html><html xmlns="http://www.w3.org/1999/html"><head><meta charset="utf-8">';echo'<title>'.$Mdk.'</title>';echo'<script src="//code.jquery.com/jquery-1.11.3.min.js"></script>';echo'<link href="//demo.devs.mx/lightning/image/catalog/light_mark_blue.gif" rel="icon" /><link rel="stylesheet" href="//lightning.devs.mx/service/css/lightning.css" /><link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/highlight.js/9.4.0/styles/default.min.css" /><script src="//cdnjs.cloudflare.com/ajax/libs/highlight.js/9.4.0/highlight.min.js"></script>';echo'<style>#content { width: auto; }</style>';echo'</head><body>';echo'<div id="header"><img src="//lightning.devs.mx/share/head3_logo.png"/></div>';$Mei=explode(":",$Mdk);echo'<div id="content"><h2>'.$Mei[0].'</h2>';echo'<pre><code class="php">';$Mok=file($Mei[0],FILE_IGNORE_NEW_LINES);$Mou=@$Mei[1];foreach($Mok as$Mcb=>$Mol){if($Mcb+1==$Mou)echo'<div style="background: yellow" id="xline">';echo htmlspecialchars($Mol)."\n";if($Mcb+1==$Mou)echo'</div>';}echo'</code></pre>';echo'<script> hljs.initHighlightingOnLoad(); $("html, body").animate({ scrollTop: $("#xline").offset().top-400},1000);</script></body></html>';exit;}function Wck(){if(empty(Wc_("session")->data["user_id"])and empty($_COOKIE["lix"]))exit;header("Content-Type: text/html; charset=utf-8");echo"<!DOCTYPE html><html xmlns='http://www.w3.org/1999/html'><head><meta charset='utf-8'>";echo"<title>Page Generation Metrics for ".$_SERVER["REQUEST_URI"]."</title>";echo"<script src='//code.jquery.com/jquery-1.11.3.min.js'></script><link rel='stylesheet' href='//lightning.devs.mx/service/css/lightning.css' />";echo"<link href='//demo.devs.mx/lightning/image/catalog/light_mark_blue.gif' rel='icon' /><link rel='stylesheet' href='//cdnjs.cloudflare.com/ajax/libs/highlight.js/9.4.0/styles/default.min.css' /><script src='//cdnjs.cloudflare.com/ajax/libs/highlight.js/9.4.0/highlight.min.js'></script><script>hljs.initHighlightingOnLoad();</script><style>pre{white-space: pre-wrap;}</style>";echo"</head><body><div id='header'><img src='//lightning.devs.mx/wp-content/uploads/2015/01/site_logo_optimized2.png'/></div><div id='content'>";$Mbe="http".(($_SERVER["SERVER_PORT"]==443)?"s://":"://").$_SERVER["HTTP_HOST"].$_SERVER["REQUEST_URI"];$Mbe=str_replace("&amp;",'&',$Mbe);$Mbe=str_replace("?li_sql=1",'',$Mbe);$Mbe=str_replace("&li_sql=1",'',$Mbe);$Mju=str_replace(HTTP_SERVER,'',$Mbe);if(!$Mju)$Mju='/';echo"<h2>Page Generation Metrics for <a href='".$Mbe."' target='_blank'>".$Mju."</a></h2>";global$Mgy,$Mgz,$Mg_,$Mhd,$Mhe;$Mha=microtime(true)-$Mgy;echo"Total: <strong>".Wcj($Mha)." sec </strong> <br/>";echo"<div style='font-size:13px; margin-top:10px;'>";$Mhf=$Mha-$Mhd;echo"PHP: <strong>".Wcj($Mhf)." sec</strong> (".round($Mhf/$Mha*100)."%)<br/>";$Mhg=$Mhd-$Mhe;if($Mhg)echo"Lightning: <strong>".Wcj($Mhg)." sec</strong> (".round($Mhg/$Mha*100)."%)<br/>";echo"SQL: <strong>".Wcj($Mhe)." sec</strong> (".round($Mhe/$Mha*100)."%)<br/>";echo"</div>";echo"<h2>SQL Queries</h2>";if($Mg_)echo"Cached queries: ".$Mg_."<br/>";echo"Real queries: ".$Mgz."<br/>";echo"<br/>";echo"<div class='notice_buttons_line'><a class='button' onclick='$(\".li_hide\").show(300); $(this).hide(300);'>Show All</a></div><br/>";echo"<style type='text/css'>.li_sub{margin-left:20px}.action{font-size:16px; margin-top:20px} .li_time {color: blue}  .li_time .hljs-number {color: blue} .li_timex {color: red; font-weight: bold}  .li_timex .hljs-number {color: red} .li_query {margin-left:20px}</style>";global$Mjd;foreach($Mjd as$Mcb=>$Maj){if(!empty($Mjd[$Mcb]['ed'])){if($Mjd[$Mcb]['ed']!='Mbn'&&!isset($Mjd[$Mcb]['Mbt']))unset($Mjd[$Mcb]);}else$Mjd[$Mcb]['Mjv']['Mbt']=$Mjd[$Mcb]['Mbt'];}$Mjd=array_values($Mjd);for($Mcb=count($Mjd)-2;$Mcb>=0;$Mcb--)if(isset($Mjd[$Mcb]['Mjv'])and isset($Mjd[$Mcb+1]['Mjv']))if($Mjd[$Mcb]['Mjv']['Mil']==$Mjd[$Mcb+1]['Mjv']['Mil']){$Mjd[$Mcb]['Mjv']['Mbt']+=$Mjd[$Mcb+1]['Mjv']['Mbt'];$Mjd[$Mcb+1]['Mjv']['Mbt']=0;}$Mjv="";$Mjw=$Mha/100;$Mcb=0;foreach($Mjd as$Mjx)if(!empty($Mjx['ed'])){if($Mjx['ed']=='Mbn'){echo"</div>";continue;}$Mcb++;echo"<div class='action' onclick='$(\".q$Mcb\").toggle(300)'>".$Mjx['ed'];if($Mjx['Mbt']<0.001)$Mjx['Mbt']=0;if($Mjx['Mbt']){echo" <span class='li_time";if($Mjx['Mbt']>0.5)echo"x";echo"'>(".Wcj($Mjx['Mbt'])." sec)</span>";}echo"</div>";echo"<div  class='li_sub q$Mcb' ";if($Mjx['Mbt']<$Mjw)echo" style='display:none'";echo">";}else{if($Mjx['Mjv']['Mil']!=$Mjv){$Mjv=$Mjx['Mjv']['Mil'];$Mcb++;echo"<div class='code_origin' onclick='$(\".q$Mcb\").toggle(300)' style='font-size:12px; margin-top:20px'><div";if($Mjx['Mjv']['Mbt']<0.001)$Mjx['Mjv']['Mbt']=0;if($Mjx['Mjv']['Mbt']<$Mjw)echo" class='li_hide' style='display:none'";echo">".$Mjv;if($Mjx['Mjv']['Mbt']){echo" <span class='li_time";if($Mjx['Mjv']['Mbt']>0.5)echo"x";echo"'>(".Wcj($Mjx['Mjv']['Mbt'])." sec)</span>";}echo"</div></div>";}if($Mjx['Mbt']<0.001)$Mjx['Mbt']=0;echo"<div class='li_query";if($Mjx['Mbt']<$Mjw)echo" li_hide q$Mcb";echo"' style='margin-top:10px;";if($Mjx['cr'])echo"color: grey;";if($Mjx['Mbt']<$Mjw)echo"display:none";echo"'>";echo"<pre><code class='sql'>".$Mjx['Mhj'];if($Mjx['Mbt']){echo" <span class='li_time";if($Mjx['Mbt']>0.5)echo"x";echo"'>(".Wcj($Mjx['Mbt'])." sec)</span>";}if($Mjx['cr']==-1)echo" <span style='color:grey'>[nocache]</span";elseif($Mjx['cr'])echo" <span class='li_time'>(cached)</span>";echo"</code></pre>";echo"</div>";}}function Wcl($Mhb){global$Mjd;$Mjd[]=array('Mhj'=>"<font color='blue'>".$Mhb."</font>",'cr'=>false,'Mbt'=>0,'Mjv'=>Wce());}function Wfu($Mce){global$Mam;if(!$Mam)return;global$Mjd;$Mjd[]=array('ed'=>$Mce,'Mdl'=>microtime(true));$Mrv=array_keys($Mjd);return end($Mrv);}function Wcj($Mhk){if($Mhk<1)$Mhk=round($Mhk,3);elseif($Mhk<2)$Mhk=round($Mhk,2);elseif($Mhk<6)$Mhk=round($Mhk,1);else$Mhk=round($Mhk);return($Mhk);}function Wce($Mmh=false){$Mjh=debug_backtrace();$Mbp="";$Mmi=substr(DIR_SYSTEM,0,-7);foreach($Mjh as$Mcb=>$Mhs){$Mji=$Mhs["function"];if($Mji=='Wdd'||$Mji=='Wce'||$Mji=='Web')continue;if($Mji=="call_user_func_array")break;if(!empty($Mhs["class"])){if($Mhs["class"]=="DB"||$Mhs["class"]=="Front"||$Mhs["class"]=="Controller"||$Mhs["class"]=="light_db")continue;$Mji=$Mhs["class"].":".$Mji;}$Mmj="<a";if(!empty($Mhs["file"])and isset($Mhs["line"])){$Map=str_replace($Mmi,'',$Mhs["file"]).':'.$Mhs["line"];$Mpr=HTTP_SERVER;if(defined("HTTP_CATALOG"))$Mpr=HTTP_CATALOG;$Mmj.=" title='".$Map."' target='_blank' href='".$Mpr."index.php?li_source=".$Map."'";}$Mmj.=">".$Mji."</a>";if($Mbp)$Mbp=$Mmj." -> ".$Mbp;else$Mbp=$Mmj;}$Mhp['Mil']=$Mbp;static$Mbt;if(!$Mbt)$Mbt=microtime(true);$Mmk=microtime(true);$Mhp['Mbt']=$Mmk-$Mbt;$Mbt=$Mmk;return$Mhp;}function Wb($Mmu,$Mmv=true,$Mbq=false){$Mmw=DIR_CACHE."lightning/".'Mmx';$Mmx=array();if(file_exists($Mmw))$Mmx=unserialize(file_get_contents($Mmw));if(!$Mmv){if(empty($Mmx[$Mmu]))return false;unset($Mmx[$Mmu]);Wdv($Mmx);}else{if(empty($Mmx[$Mmu])){$Mmx[$Mmu]["new"]=true;$Mmx[$Mmu]["hidden"]=false;$Mmx[$Mmu]["data"]=array();Wdv($Mmx);}$Mmy=&$Mmx[$Mmu];$Mmy["time"]=time();if($Mmy["hidden"])return$Mmv;if($Mbq){if($Mgj=array_search($Mbq,$Mmy["data"]))return$Mmv;if(!empty($Mbq["key"])){foreach($Mmy["data"]as$Mcb=>$Mmz)if($Mbq["key"]===$Mmz["key"]){if(!empty($Mbq["score"])&&$Mbq["score"]<$Mmz["score"])return$Mmv;unset($Mmy["data"][$Mcb]);break;}}if(count($Mmy["data"])>9){if(!empty($Mbq["score"])){$Mm_=100000000;foreach($Mmy["data"]as$Mcb=>$Mmz)if($Mmz["score"]<$Mm_){$Mm_=$Mmz["score"];$Mna=$Mcb;}if($Mm_>$Mbq["score"])return$Mmv;unset($Mmy["data"][$Mna]);}else{reset($Mmy["data"]);unset($Mmy["data"][key($Mmy["data"])]);}}if(!empty($Mbq["url"])&&$Mbq["url"]===true)$Mbq["url"]="http".(($_SERVER["SERVER_PORT"]==443)?"s://":"://").$_SERVER["HTTP_HOST"].$_SERVER["REQUEST_URI"];$Mmy["data"][time()]=$Mbq;}}file_put_contents($Mmw,serialize($Mmx));return$Mmv;}function Wd(){$Mmw=DIR_CACHE."lightning/".'Mmx';if(!file_exists($Mmw))return;$Mmx=file_get_contents($Mmw);echo$Mmx;$Mmx=unserialize($Mmx);foreach($Mmx as&$Mnb)$Mnb["new"]=false;Wdv($Mmx);file_put_contents($Mmw,serialize($Mmx));}function Wa($Mmu,$Mnc=false){$Mmw=DIR_CACHE."lightning/".'Mmx';if(!file_exists($Mmw))return;$Mmx=unserialize(file_get_contents($Mmw));$Mmx[$Mmu]["hidden"]=!$Mnc;Wdv($Mmx);file_put_contents($Mmw,serialize($Mmx));}function Wdv(&$Mmx){$Mmw=DIR_CACHE."lightning/".'cu';$Mnd=array();if(file_exists(($Mmw)))$Mnd=filemtime($Mmw);$Mne=0;$Mnf=0;$Mng=0;foreach($Mmx as$Mnh){if($Mnh["new"])$Mne++;elseif($Mnh["hidden"])$Mng++;else$Mnf++;}file_put_contents($Mmw,$Mne.'|'.$Mnf.'|'.$Mng);if($Mnd)touch($Mmw,$Mnd);}function Wdw(){$Mmw=DIR_CACHE."lightning/".'cu';if(file_exists(($Mmw)))touch($Mmw);else{$Mmx=unserialize(file_get_contents(DIR_CACHE."lightning/".'Mmx'));Wdv($Mmx);}}