<?php $Mni="3.03";$Mni.=" ru";$Mnj="lightning.devs.mx";if(strpos(HTTP_SERVER,"/localhost/"))$Mnk="http://localhost/high2/service/settings3.php?token=".md5(HTTP_SERVER);else$Mnk="http://$Mnj/settings3.php?token=".md5(HTTP_SERVER);$Mnk=str_replace(".php","ru.php",$Mnk);$Maj=$Mni;if($Maf=strpos($Maj," "))$Maj=substr($Maj,0,$Maf);$Mnk.="&v=".substr($Maj,2);if(strpos(HTTP_SERVER,"/localhost/"))$Mnl="http://localhost/high2/service/notices.php?token=".md5(HTTP_SERVER);else$Mnl="http://$Mnj/notices.php?token=".md5(HTTP_SERVER);$Mnl=str_replace(".php","ru.php",$Mnl);if(file_exists(DIR_SYSTEM."lightning/gamma.php")){die("<div dummy='lightning_menu'>Удалите папку <b>system/lightning</b>!</div>");}$Mnk=ssl($Mnk);$Mnl=ssl($Mnl);define('Wa',DIR_CACHE."lightning/".'b');$Mc=(@filemtime(DIR_CACHE."lightning/"."cron_working")>time()-15*60);$Mtr="http://$Mnj/buy.php?v=3&host=".str_replace("https://","",str_replace("http://","",HTTP_SERVER));$buy_link="https://opencartforum.com/files/file/3869-licenziya-lightning-dlya-odnogo-domena/' oncontextmenu='location=\"".str_replace(".php", "ru.php",$Mtr)."\"";$Mnn=false;if(file_exists(Wa)){$Mgb=unserialize(file_get_contents(Wa));$Mnn=$Mgb['db'];if(substr($Mnn,0,1)=="<")$Mno=true;$Mnn=str_replace("[license]"," ",$Mnn);if(substr($Mnn,-1)==" "){$Mnn.="<a class='lightning_links' target='blank' href='".$buy_link."'>[купить лицензию]</a>";}}else$Mgb=array('Mnt'=>true,'Mns'=>false,'f'=>true);$Me=false;if(!empty($_GET["op"]))$Me=$_GET["op"];$Mnp="blue";$Mnq=DIR_LOGS.'cv';$Mps=DIR_LOGS.'da';$Mhb='';$Mno=false;if(isset($_POST['lc']))Wdx();$Mnr=array(0,0,0);$Muk=10*60;if(file_exists($Mnq)){$Muk=12*60*60;$Mnk.="&disabled=1";$Mhb=file_get_contents($Mnq);if($Mhb=='dd'){$Mnp="grey";$Mhb='';}else{$Mnp="red";if(substr($Mhb,-1)=='#'){$Mhb=substr($Mhb,0,-1);$Mno=true;}}}$Mmw=DIR_CACHE."lightning/".'cu';if(!file_exists($Mmw)||filemtime($Mmw)<time()-$Muk){require_once"omega.php";Wdy();}$Mnr=explode("|",file_get_contents($Mmw));$Mns=$Mgb['Mns'];$Mnt=$Mgb['Mnt'];$Mnu=Wa.'ar';$Mnv=false;if(file_exists($Mnu)){$Mnv=(int)file_get_contents($Mnu);}if($Mnt and!empty($Mgb['n'])and!file_exists($Mnq)and!file_exists(DIR_CACHE."lightning/alpha"))$Mnv=1;if(empty($Mnw))exit;if($Me=="image_check"){require_once"optima.php";Check_Optimizers();}if(empty($_SERVER["HTTP_X_REQUESTED_WITH"])&&@$_GET["li_op"][1]!=="t")exit;if($Me=="toggle"){if(file_exists($Mps))unlink($Mps);else file_put_contents($Mps,'1');exit;}if($Me=="disable"){file_put_contents($Mnq,'dd');Wdz();Wt(true);if(file_exists($Mnu))unlink($Mnu);exit;}function Wd_($Mks,$Mnx=false){if(!file_exists($Mks))return true;if(!is_dir($Mks)||is_link($Mks))return unlink($Mks);foreach(scandir($Mks)as$Mny){if($Mny=='.'||$Mny=='..')continue;if(!Wd_($Mks."/".$Mny,true)){chmod($Mks."/".$Mny,0777);if(!Wd_($Mks."/".$Mny,true))return false;};}if(!$Mnx)return true;return rmdir($Mks);}if($Me=="clear_caches"){ini_set("display_errors","Off");ini_set("log_errors","Off");require"clear_caches.php";echo"OK";exit;}function Wdz(){if(file_exists(Wa))unlink(Wa);}function Wea($storage){$Map=DIR_CACHE."lightning/$storage/meters";if(file_exists($Map))return explode(',',file_get_contents($Map));return array(0,0);}function Wac($Mbj){$Mbk=0;while($Mbj>=1024){$Mbj/=1024;$Mbk++;}if($Mbj<10)$Mbj=round($Mbj,2);else$Mbj=round($Mbj);$Mbl=array("bytes","Kb","Mb","Gb","Tb");$Mbm=$Mbj."&nbsp;".$Mbl[$Mbk];return$Mbm;}function num($Mhk){if($Mhk<1)$Mhk=round($Mhk,3);elseif($Mhk<2)$Mhk=round($Mhk,2);elseif($Mhk<6)$Mhk=round($Mhk,1);else$Mhk=round($Mhk);return($Mhk);}$Mtx=DIR_IMAGE."catalog/lightning_optimized_data";if(!file_exists($Mtx))$Mty=array(0,0,0);else$Mty=explode(" ",file_get_contents($Mtx));if($Mtz=$Mty[0]){$Mt_=($Mty[1]-$Mty[2]);$Mua=round($Mt_/$Mty[1]*100);$Mt_=Wac($Mt_);}$Mhj=Wea("beta");$Mi_=Wea("alpha");$Mn_=Wea("gamma");$Moa=Wea("tetha");$Mav=Wea("delta");$Mob=0;if(@$Mi_[0])$Mob=(@$Mi_[1]+@$Mn_[1])/@$Mi_[0];$Moc=@disk_free_space(DIR_CACHE);$Mtp=$Moc;if($Moc)$Moc=Wac($Moc);if(file_exists(DIR_CACHE."lightning/".'de'))$Mod=unserialize(file_get_contents(DIR_CACHE."lightning/".'de'));else{$Mod=array();}$Moe=0;if(!empty($Mod['Moe']))$Moe=$Mod['Moe'];function Wdx(){if(!file_exists(DIR_CACHE."lightning")){@mkdir(DIR_CACHE."lightning",0777,true);@chmod(DIR_CACHE."lightning",0777);}@file_put_contents(Wa,stripslashes($_POST['lc']));$Mgd=unserialize(stripslashes($_POST['Mgd']));foreach($Mgd as&$Mge)$Mge=str_replace("xy".'Mf_'."xy","SELECT",$Mge);@file_put_contents(Wa.'Mgd',serialize($Mgd));echo'OK';exit;}$Mof=DIR_CACHE."lightning/".'Moh';$Mog=DIR_CACHE."lightning/".'Mdw';if(file_exists($Mog))$Moe=file_get_contents($Mog);$Moh=array();if(file_exists($Mof)&&filemtime($Mof)>time()-10)$Moh=unserialize(file_get_contents($Mof));$Moi="blackberry kindle ipad iphone android feedburner msie firefox opera chrome safari google bot";$Moi=explode(" ",$Moi);$Moj=DIR_CACHE."lightning/".'dg';if(file_exists($Moj))if(filemtime($Moj)>time()-15){$Mok=file($Moj,FILE_IGNORE_NEW_LINES|FILE_SKIP_EMPTY_LINES);unlink($Moj);foreach($Mok as$Mol)if(substr($Mol,0,1)=="a"){$Mol=unserialize($Mol);if(empty($Mol['Mon']))$Mol['Mon']=false;if(empty($Mol['ip']))$Mol['ip']=false;if(empty($Mol['Mox'])and($Mol['ip']==@$_SERVER["REMOTE_ADDR"]))$Mol['Mox']="Вы";if(!empty($Mol['Mox']))$Mol['ip']=$Mol['Mox'];$Mom=$Mol['Mon'];$Mgl=strtolower($Mol['Mon']);$Mol['Mon']="other";foreach($Moi as$Mon)if(strpos($Mgl,$Mon)!==false){$Mol['Mon']=$Mon;if($Mon!="bot")$Mom=false;break;}if($Mom)$Mol['dj']=$Mom;$Moh[$Mol['id']]=$Mol;}else{$Mol=explode('|',$Mol);$Mld=$Mol[0];$Mbt=$Mol[1];if(!empty($Moh[$Mld])){$Moh[$Mld]['dk']=$Mbt;if(!empty($Mol[2]))$Moh[$Mld]['Mo_']=$Mol[2];}}}else{@unlink($Moj);$Moh=array();}$Mbt=microtime(true)-5;if($Moh)foreach($Moh as$Mld=>&$Mbm){if(!empty($Mbm['dk'])&&$Mbm['dk']<$Mbt-5)unset($Moh[$Mld]);elseif(empty($Mbm['dk'])&&$Mbt-$Mbm['Mbt']>360){$Mbm['dk']=$Mbt;$Mbm['Mo_']="Принудительно завершено сервером";}}file_put_contents($Mof,serialize($Moh));$Mpt="";if(file_exists($Mps))$Mpt=" style='display:none'";function ssl($Mbe){$Moo=str_replace("http:","https:",$Mbe);if(!empty($_SERVER["HTTPS"])&&(($_SERVER["HTTPS"]=="on")||($_SERVER["HTTPS"]=="1")))return$Moo;if(!empty($_SERVER["SERVER_PORT"])&&$_SERVER["SERVER_PORT"]==443)return$Moo;if(!empty($_SERVER["HTTP_X_FORWARDED_PROTO"])&&$_SERVER["HTTP_X_FORWARDED_PROTO"]=="https")return$Moo;if(!empty($_SERVER["HTTP_X_FORWARDED_PROTOCOL"])&&$_SERVER["HTTP_X_FORWARDED_PROTOCOL"]=="https")return$Moo;if(!empty($_SERVER["HTTP_X_HTTPS"]))return$Moo;return$Mbe;}if(empty($_SERVER["HTTP_X_REQUESTED_WITH"])){header('Content-Type: text/html; charset=utf-8');?><head><title>OpenCart Lightning</title><base href="<?php echo ssl(HTTP_SERVER).'admin/' ?>"/><script src="<?php echo ssl('http:') ?>//code.jquery.com/jquery-2.1.1.min.js"type="text/javascript"></script><link rel="stylesheet"type="text/css"href="<?php echo ssl('http:') ?>//<?php echo $Mnj ?>/service/css/tetha3.css"/><style>#lightning_menu{display: block;}</style></head><body style="font-family: Arial, Helvetica, sans-serif; font-size: 12px; margin-left: 200px; margin-top: 20px"><div id="lightning"><?php }if(VERSION<2){?><style>#lightning_container{border: 2px solid #777;}</style><?php }?><div class="top <?php if ($Mns) echo "li_small" ?>"id="lightning_container"><img id="li_slogo"class="li_logos"src="<?php echo ssl('http:') ?>//<?php echo $Mnj ?>/service/image/light_<?php echo $Mnp ?>.png"height="28"width="28"><?php if($Mnr[0]){?><div class="li_notices"><?php echo$Mnr[0]?></div><?php }?><div class="lightning_bar"><?php if($Mnv!==false){echo"Пре-генерация";echo" <strong><span id='li_percent'>".$Mnv."</span>%</strong>";?><?php }else if(num($Moe)){?><span class="li_tipped"><div class="li_tip">Время генерации последней страницы</div><strong><?php echo num($Moe)." "?>сек</strong> <span style="color:#DDD">TTFB</span></span><?php }if($Moc){?><div style="float: right"class="li_tipped"><div class="li_tip">Свободное место на диске вашего сервера</div><b><span style="<?php if($Mtp<512*1024*1024)echo"color: palevioletred";elseif($Mtp<1024*1024*1024)echo"color: orange";?>"><?php echo $Moc ?></span></b> <span style="color:#DDD"><?php if($Mnv===false)echo'свободно';?></span></div><?php }?></div><div id="li_bar"style="position: relative;height: 34px;<?php $Mop=0;if($Moe)$Mop=190/5*$Moe+10;if($Mnv!==false)$Mop=$Mnv*2;if($Mop>200)$Mop=200;echo"width: $Mop"."px; background-color: ";if($Mnv!==false)echo"#239b25";else if($Moe<2)echo"#3065b5";else if($Moe<4)echo"#82701b";else echo"#9e3c3c";?>"></div><div id="lightning_live"><?php $Moe=0;if($Moh)foreach($Moh as$Moq){$Mor=!empty($Moq['dk'])&&$Moq['dk']<$Mbt;$Mos=0;if(!empty($Moq['dk'])){$Mos=num($Moq['dk']-$Moq['Mbt']);if(!$Mos)$Mos=0.01;$Moe=$Mos;}if(!$Mor)$Mhs=round($Mbt-$Moq['Mbt'],1);else$Mhs=round($Mbt-$Moq['dk']-5,1);$Mop=0;if($Mor)$Mop=40*$Mos;else if($Mhs>0)$Mop=40*$Mhs;$Mbe=$Moq['Mbe'];$Mot=$Mbe;if(strpos($Mot,'&')or strpos($Mot,'?'))$Mot.='&';else$Mot.='?';$Mot.="li_sql=1";if(strlen($Mbe)>strlen(HTTP_SERVER)&&substr($Mbe,0,strlen(HTTP_SERVER))==HTTP_SERVER)$Mbe="<strong>".substr($Mbe,strlen(HTTP_SERVER))."</strong>";else{$Maf=strpos($Mbe,'/',9);$Mbe=substr($Mbe,0,$Maf)."<strong>".substr($Mbe,$Maf)."</strong>";}?><div onclick='window.open("<?php echo$Mot;?>")'class="li_req <?php if (!$Mor) echo "li_req_live" ?>"style="<?php if($Mhs<0&&!$Mor)echo"display:none;";if($Mhs<0&&$Mor)echo"margin-left: ".(($Mhs+5)*10)."px"?>"><div class="li_req_bar"style="width: <?php echo $Mop ?>px"></div><div class="li_req_on"><img src="<?php echo ssl("http:");?>//lightning.devs.mx/service/image/browsers/<?php echo$Moq['Mon'];?>.png"/><?php if(!empty($Moq['Mo_'])){?><span class="li_substring<?php if(substr($Moq['Mo_'],0,1)=='+')echo" li_success\">".substr($Moq['Mo_'],1);else echo" li_error\">".$Moq['Mo_']?></span><?php }elseif(!empty($Moq['dj'])){?><span class="li_substring"> <?php echo$Moq['dj']?></span><?php }?><span class="li_who"><?php echo' '.$Moq['ip'].' '?></span><span class="li_live_time"><?php echo$Mhs ?></span><span class="li_time"><?php echo$Mos ?></span>&nbsp;<span class="li_sec">sec</span>&nbsp;<a class="li_req_link"target="_blank"><?php echo$Mbe ?></a></div></div><?php }if($Moe)file_put_contents($Mog,$Moe);?></div><div id="lightning_menu"><div style="text-align: center; margin-top: 10px; margin-bottom: 20px"><img class="li_logos"src="<?php echo ssl('http:') ?>//<?php echo $Mnj ?>/service/image/light_<?php echo $Mnp ?>.png"style="height: 80px"><div style="font-size:17px; margin-top:5px">OpenCart&nbsp;<strong>Lightning</strong></div><div class="lightning_version"ondblclick="$.get('../index.php?li_op=t&op=toggle&rd='+Date.now())">v.<?php echo" ".$Mni ?></div><div class="lightning_license"><?php echo$Mnn ?></div><?php if($Mhb){?><strong>Lightning отключен:</strong><div style="color:#9a1b1b; font-size: 14px; margin-bottom: 20px;"><?php echo$Mhb ?></div><?php }?></div><?php if($Mno){?><a target="_blank"href='<?php echo $buy_link ?>'class="lightning_button lightning_active">Приобрести лицензию</a><?php }?><?php if(!file_exists($Mnq)){?><div class="lightning_button <?php if (!$Mpt) echo "li_half" ?>"style="background-color: #b81818"onclick="$.ajax('../index.php?li_op=t&op=disable&rd='+Date.now()).done(function(){Ul();});">Выключить</div><?php }else{?><div class="lightning_button <?php if (!$Mpt) echo "li_half" ?>"style="background-color: #239b25"onclick="if($(this).hasClass('lightning_active'))return;$(this).html('Вкл'+' <img class=\'lightning_work\' src=\'<?php echo ssl('http:')?>//<?php echo$Mnj ?>/service/image/loading.gif\'>');$(this).addClass('lightning_active');lu=false;$.get('../index.php?li_op=gens&cd='+Date.now(),function(data){lu=true;Ul();if(data['gen']===true)if(!li_genx)li_gen();},'json');"><strong>Включить</strong></div><?php }?><?php if(!$Mpt){?><div class="lightning_button li_half"style="float:right"id="light_settings"onclick='window.open("<?php echo $Mnk ?>");'>Настройки...</div><?php }?><div class="lightning_button"id="light_clearcaches"onclick="if($(this).hasClass('lightning_active'))return;$(this).html('Очистка кеша'+' ... <img class=\'lightning_work\' src=\'<?php echo ssl('http:')?>//<?php echo$Mnj ?>/service/image/loading.gif\'>');$(this).addClass('lightning_active');lu=false;$.ajax('../index.php?li_op=t&op=clear_caches&rd='+Date.now()).done(function(){<?php if(!file_exists($Mnq)){?>$.ajax('../index.php?li_op=gens&cd='+Date.now()+'x').done(function(){lu=true;Ul();if(!li_genx)li_gen();});<?php }else{?>lu=true;Ul();<?php }?>});">Очистить кеш</div><div<?php echo$Mpt ?>><?php if($Mnr[0]or$Mnr[1]){?><div class="lightning_button"onclick='window.open("<?php echo$Mnl ?>");'><span class="li_notice_count"<?php if(!$Mnr[0])echo'style="background-color: #888"'?>><?php if($Mnr[0])echo$Mou=$Mnr[0];else echo$Mou=$Mnr[1]?></span><?php echo" ";if($Mnr[0]){if($Mou>1)echo'Новые';else echo'Новое';echo' и';}else echo'И';if($Mou>1)echo'звещения';else echo'звещение';?></div><?php }else if($Mnr[2]){?><div class="li_dismissed"><a class="lightning_links"target="_blank"href="<?php echo $Mnl ?>"><?php echo$Mnr[2].' ';if($Mnr[2]>1)echo'скрытых извещений';else echo'скрытое извещение';?></a></div><?php }?><div class="lightning_h3">Показатели</div><?php if($Mi_[0]){?><div class="lstat">Кеш страниц:<?php echo" "?><span id="li_psize"><?php echo Wac($Mi_[1])."</span> <span class='lightning_grey'>(<span id='li_pages'>$Mi_[0]"?></span>&nbsp;страниц)</span></div><?php }?><?php if($Moa[0]){?><div class="lstat">Кеш AJAX:<span> <?php echo Wac($Moa[1])."</span> <span class='lightning_grey'>($Moa[0]"?>&nbsp;запросов)</span></div><?php }?><?php if($Mhj[0]){?><div class="lstat">Кеш БД:<span> <?php echo Wac($Mhj[1])."</span> <span class='lightning_grey'>($Mhj[0]"?>&nbsp;запросов)</span></div><?php }?><?php if($Mtz){?><div class="lstat">Оптимизировано<span><?php echo" $Mtz"?>&nbsp;изображений</span><?php echo" "?>на&nbsp;<?php echo"$Mua"?>%<?php echo" "?><span class="lightning_grey">(<?php echo$Mt_ ?>)</span></div><?php }?><?php if($Mod&&@$Mod['dm']>1){?><div class="lstat">Среднее TTFB без&nbsp;Lightning:<span style="color:#9a1b1b"> <?php echo num($Mod['dn']/$Mod['dm'])."&nbsp;сек</span> <span class=\"lightning_grey\">(на&nbsp;базе ".$Mod['dm']."&nbsp;страниц)"?></span></div><?php }?><?php if($Mod&&@$Mod['do']>1){if($Mod['dp']/$Mod['do']>1000)@unlink(DIR_CACHE."lightning/".'de');?><div class="lstat">Среднее TTFB с&nbsp;Lightning:<span style="color:green"> <?php echo num($Mod['dp']/$Mod['do'])."&nbsp;сек </span> <span class=\"lightning_grey\">(на&nbsp;базе ".$Mod['do']."&nbsp;страниц)"?></span></div><?php }?><?php if($Mod&&@$Mod['do']>1 and @$Mod['dm']>1){$Mov=@round(($Mod['dn']/$Mod['dm'])/($Mod['dp']/$Mod['do']));if($Mov>1){?><div class="lstat">Подсчитаное ускорение:<?php echo" "?><span style="color:green">x&nbsp;<?php echo$Mov."&nbsp;раз</span>"?></div><?php }}?></div><a class="lightning_links"target="_blank"href="https://opencartforum.com/topic/42017-opencart-lightning/"style="float:left">Поддержка</a><?php if(!$Mpt){?><a class="lightning_links"target="_blank"href="http://lightning.devs.mx/uninstall/"style="float:right">Деинсталляция</a><?php }?></div></div><?php if(empty($_SERVER["HTTP_X_REQUESTED_WITH"])){?></div><script type="text/javascript">var lu=true;var lv=true;var lt=false;function Ul(){if(!lu)return;if(!lv)return;lu=false;$.get('../index.php?li_op=t&rd='+Date.now(),false,function(data){if(data.indexOf("lightning_menu")==-1)$('#lightning').html("<a style='background:white; padding:5px' target='_blank' href='http://lightning.devs.mx/fix-index-php-problem/'>Click to fix Lightning <b>index.php</b> problem</a>");else{$('#lightning').html(data);}},"html").done(function(){lu=true;});}function li_live(){$(".li_logos").css("-webkit-filter","brightness(100%)");$(".li_req").each(function(index){var live=$(this).hasClass("li_req_live");var time=$(this).find(".li_live_time");var t=+time.html();t=parseFloat(t+0.1);if(t>0)$(this).find(".li_req_bar").css("width",40*t);else if(t<0&&!live){$(this).css("margin-left",((5+t)*10)+"px");}if(t==0)if(live)$(this).show();else{$(this).css("background","none").css("border","none");$(this).find(".li_req_on").remove();$(this).find(".li_req_bar").remove();$(this).animate({height:0,padding:0,margin:0},300);return;}var ft=+$(this).find(".li_time").html();if(ft&&t>=ft){t=-5;$(this).removeClass("li_req_live");$(this).find(".li_req_bar").css("width",40*ft);if(!$("#li_percent").length){$(".lightning_bar strong").html(ft+" sec");var width=190/5*ft+10;if(width>200)width=200;var color="#9e3c3c";if(ft<2)color="#3065b5";else if(ft<4)color="#82701b";$("#li_bar").css("width",width+"px").css("background-color",color);$(".li_logos").css("-webkit-filter","brightness(120%)");}}time.html(t.toFixed(1));});}$(document).ready(function(){setInterval('Ul()',5000);Ul();setInterval('li_live()',100);li_live();});$(window).focus(function(){lv=true;Ul();});$(window).blur(function(){lv=false;});var li_genx=false;function li_gen(){li_genx=true;$.get('../index.php?li_op=gen&cd='+Date.now(),false,function(data){if(!data){$('#li_percent').html(100);$('#li_bar').css('width','200px');li_genx=false;return;}if(typeof data['width']!=='undefined'){$('#li_bar').css('width',data['width']);$('#li_percent').html(data['percent']);}$('#li_pages').html(data['pages']);$('#li_psize').html(data['psize']);li_gen();},'json');}</script><?php }?><?php if(!$Mc and!empty($_SERVER["HTTP_X_REQUESTED_WITH"]))if($Mnt and(!file_exists($Mnq)and!file_exists(DIR_CACHE."lightning/alpha"))||$Mnv!==false){?><script type="text/javascript">if(!li_genx){$.get('../index.php?li_op=gens&cd='+Date.now(),false,function(data){if(data['gen'])li_gen();},'json');}</script><?php }?><?php if(empty($_SERVER["HTTP_X_REQUESTED_WITH"])){?></body><?php }exit;?>