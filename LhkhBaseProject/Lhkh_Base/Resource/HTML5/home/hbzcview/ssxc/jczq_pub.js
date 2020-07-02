/**
 * 竞彩足球发布推荐  WW
 */
var JCZQ ={
    order:{},
    jsonData:{},
    dataMatch:{},
    nowTime:new Date().getTime(),
    g_config:{
        minute_before_playtime:0,
        lottery_type:''
    },
    matchGame:{
        totalMatchCount:0
    },
    mtop:0,
    selectMap:{},
    lotteryId:'',
    mesportData:{},
    passway:'',
    selectCount:0,//选择赛事场次
    l_name_map:{},
    zhushu:0,
    betMap:{},
    yh:0,
    yhMap:{"zjd":0,"avg":1,"hot":2,"cold":3},
    weekArr:{
        "周一":1,
        "周二":2,
        "周三":3,
        "周四":4,
        "周五":5,
        "周六":6,
        "周日":7,
    },
    scp:{minJjyhMoney:0},
    formatJsonData:function(){
        var json = JCZQ.jsonData;
        if(json){
            var dataMatch = {};
            var datearr=[];
            for(var id in json){
                var m = json[id];
                m.match_start_time = m.date + ' ' + m.time;
                var date = parseTime(m.match_start_time);
                var bDate = parseTime(m.b_date+" 00:00:00");
                var hour = date.getHours();
                if(bDate.getDay()==0 || bDate.getDay()==6){
                    if(hour >= 0 && hour < 9 || hour==23){
                        m.book_end_time = m.b_date+" 23:00:00";
                    }else{
                        if(hour==9 &&date.getMinutes()==0){
                            m.book_end_time = m.b_date+" 23:00:00";
                        }else{
                            m.book_end_time = m.match_start_time;
                        }
                        /*if(m.had && m.had.int==2){
                            continue;
                        }
                        if(m.hhad && m.hhad.int==2){
                            continue;
                        }
                        if(m.ttg&&m.ttg.int==2){
                            continue;
                        }
                        if(m.crs&&m.crs.int==2){
                            continue;
                        }
                        if(m.hafu&&m.hafu.int==2){
                            continue;
                        }*/
                    }
                }else{
                    if(hour >= 0 && hour < 9 || hour>=22 && hour<=23){
                        m.book_end_time = m.b_date+" 22:00:00";
                    }else{
                        if(hour==9 &&date.getMinutes()==0){
                            m.book_end_time = m.b_date+" 22:00:00";
                        }else{
                            m.book_end_time = m.match_start_time;
                        }
                        /*	if(m.had && m.had.int==2){
                                continue;
                            }
                            if(m.hhad && m.hhad.int==2){
                                continue;
                            }
                            if(m.ttg&&m.ttg.int==2){
                                continue;
                            }
                            if(m.crs&&m.crs.int==2){
                                continue;
                            }
                            if(m.hafu&&m.hafu.int==2){
                                continue;
                            }*/
                    }
                }
                /*if(m.match_start_time < m.book_end_time){
                    m.book_end_time = m.match_start_time;
                }*/
                m.bookEndTimeLong=parseTime(m.book_end_time).getTime();
                m.bookEndTimeLong = m.bookEndTimeLong-JCZQ.g_config.minute_before_playtime*60*1000;
                if(m.bookEndTimeLong<JCZQ.nowTime||(m.index_show==1&&m.show==0)){//截止
                    continue;
                }

                if(m.crs&&m.crs.single==0&&m.ttg&&m.ttg.single==0){
                    continue;
                }

                if(!JCZQ.matchGame[m.l_id]){
                    JCZQ.matchGame[m.l_id]={};
                    JCZQ.matchGame[m.l_id].matchCount = 0;
                }
                JCZQ.matchGame[m.l_id]['l_id'] = m.l_id;
                JCZQ.matchGame[m.l_id]['l_cn_abbr']=m.l_cn_abbr;
                JCZQ.matchGame[m.l_id]['l_cn']=m.l_cn;
                JCZQ.matchGame[m.l_id]['selected']=true;
                JCZQ.matchGame[m.l_id].matchCount++;
                JCZQ.matchGame.totalMatchCount++;

                m.book_end_time = stringToDate(new Date(m.bookEndTimeLong),"yyyy-MM-dd hh:mm:ss");
                var key = m.b_date+","+m.num.substring(0,2);
                var list = dataMatch[key];
                if(!list){
                    datearr.push(key);//排序用的
                    list=[];
                    dataMatch[key]=list;
                }
                m.single=false;
                if(m.had && m.had.single==1){
                    m.single=true;
                }
                if(m.hhad && m.hhad.single==1){
                    m.single=true;
                }
                if(m.ttg&&m.ttg.single==1){
                    m.single=true;
                }
                if(m.crs&&m.crs.single==1){
                    m.single=true;
                }
                if(m.hafu&&m.hafu.single==1){
                    m.single=true;
                }
                m.h_order=m.h_order==""?"":"["+m.h_order.replace(/\D/g,'')+"]";
                m.a_order=m.a_order==""?"":"["+m.a_order.replace(/\D/g,'')+"]";
                JCZQ.jsonData[m.id]=m;
                JCZQ.l_name_map[m.l_cn_abbr] = "1";
                list.push(m);
            }
            for(var i=0;i<datearr.length;i++){
                var datestr = datearr[i];
                var list = dataMatch[datestr];
                var keyArr = datestr.split(",");
                var date = keyArr[0];
                var week = keyArr[1];
                var item = {};
                item.date = date;
                item.datetem = date.split("-")[0]+date.split("-")[1]+date.split("-")[2];
                item.week = week;
                item.list = list;
                item.show=true;
                item.hasChild = true;
                if(list!=null&&list.length>0){
                    JCZQ.dataMatch[datestr]=item;
                }
            }
            for(var kk in JCZQ.dataMatch){
                JCZQ.dataMatch[kk].list.sort(by_str("id"));
            }
            JCZQ.dataMatch = obj_sort_by(JCZQ.dataMatch,"datetem");
        }
        var delay=10*1000*60;
        if(JCZQ.g_config.lottery_type=='had'){
            delay = 1000*60*2;
        }
    },
    createHtml:function(){
        if(JCZQ.dataMatch && JCZQ.dataMatch.length>0){
            for(var key in JCZQ.dataMatch){
                var val = JCZQ.dataMatch[key];
                var cls = "jr_recommend_mid_fist";
                if(key==JCZQ.dataMatch.length-1){
                    cls = "jr_recommend_mid_last";
                }
                var tr = '<div class="jr_recommend_top" tid="k'+val.datetem+'">'+
                    '<span>'+val.date+' '+val.week+' [12:00-次日12:00]  共'+val.list.length+'场比赛</span>'+
                    '<i class="icon_top"></i>'+
                    '</div><div class="jr_recommend_mid '+cls+'" id="k'+val.datetem+'"><ul>';
                $.each(val.list,function(k,v){
                    var h,d,a,isd="";
                    var rh,rd,ra,isrqd="";
                    if(v.had){
                        if(v.had.single==1){
                            isd = "red_dan_bg";
                        }
                        h = "胜 "+v.had.h;
                        d = "平 "+v.had.d;
                        a = "负 "+v.had.a;
                    }
                    if(v.hhad){
                        if(v.hhad.single==1){
                            isrqd = "red_dan_bg";
                        }
                        rh = "胜 "+v.hhad.h;
                        rd = "平 "+v.hhad.d;
                        ra = "负"+v.hhad.a;
                    }
                    var analysisurl ='http://m.sporttery.cn/wap/fb/fb_match_info.php?m='+v.id+'&f=livescore';
                    if(v.team_id){
                        if(JCZQ.mesportData[v.team_id]&&JCZQ.mesportData[v.team_id].analysisurl){
                            analysisurl = JCZQ.mesportData[v.team_id].analysisurl;
                        }
                    }
                    var xStr = '<p style="color: #10aeff;font-size: 16px;" onclick="location.href=\''+analysisurl+'\'">析';
                    xStr += '</p>';
                    var li ='<li>'+
                        '<div class="weui-flex team_cont_fb">'+
                        '<div class="team_time">'+
                        '<p>'+v.l_cn_abbr+'</p>'+
                        '<p>'+v.num+'</p>'+
                        '<p>'+v.book_end_time.substring(11,16)+'截止</p>'+
                        xStr+
                        '</div>'+
                        '<div class="weui-flex__item team_detail text_center">'+
                        '<div class="weui-flex team_a">'+
                        '<div class="weui-flex__item bold_a">'+v.h_cn_abbr+'</div>'+
                        '<div class="vs">VS</div>'+
                        '<div class="weui-flex__item bold_a">'+v.a_cn_abbr+'</div>'+
                        '</div>'+
                        '<div class="team_b text_left">'+
                        '<div class="hhtz_spf text_center">'+
                        '<div class="weui-flex spf">'+
                        '<div class="frq" style="margin-right:0;border-right:0;line-height: 32px;">0</div>';
                    if(v.had){
                        li += '<div class="weui-flex__item '+isd+'" id="'+v.id+'-had-h">'+h+'</div>'+
                            '<div class="weui-flex__item" id="'+v.id+'-had-d">'+d+'</div>'+
                            '<div class="weui-flex__item" id="'+v.id+'-had-a">'+a+'</div>';
                    }else{
                        li += '<div class="weui-flex__item">不支持此玩法</div>';
                    }

                    li+=         '</div>'+
                        '<div class="weui-flex spf">'+
                        '<div class="frq red_color" style="margin-right:0;border-right:0;line-height: 32px;">'+(v.hhad?v.hhad.fixedodds:'-')+'</div>';
                    if(v.hhad){
                        li += '<div class="weui-flex__item '+isrqd+'" id="'+v.id+'-hhad-h">'+rh+'</div>'+
                            '<div class="weui-flex__item" id="'+v.id+'-hhad-d">'+rd+'</div>'+
                            '<div class="weui-flex__item" id="'+v.id+'-hhad-a">'+ra+'</div>';
                    }else{
                        li +='<div class="weui-flex__item">不支持此玩法</div>';
                    }

                    li +=             '</div>'+
                        '</div>'+
                        '<div class="hhtz text_center open-popup" data-target="" id="mid'+v.id+'" mid="'+v.id+'">混合投注</div>'+
                        '</div>'+
                        '</div>'+
                        '</div>'+
                        '</li>';
                    tr += li;
                });
                tr += '</ul></div>';
                $("#tab_list").append(tr);
            }
            $(".jr_recommend_top").on("click",function(){
                var tid = $(this).attr("tid");
                if($("#"+tid).is(":hidden")){
                    $("#"+tid).show();
                    $(this).find("i").addClass("icon_top").removeClass("icon_down");
                }else{
                    $("#"+tid).hide();
                    $(this).find("i").addClass("icon_down").removeClass("icon_top");
                }
            });
            JCZQ.$selectJx();
        }else{
            $("#tab_list").html('<div style="text-align: center;font-size: 0.42rem;margin-top: 10%;">今日无赛事</div>');
        }
    },
    $selectJx:function(){
        $(".team_detail .text_left .hhtz_spf .weui-flex__item").on("click",function(){
            var id = $(this).attr("id");
            if(!id || $(this).text()=="不支持此玩法"){
                return;
            }
            var mid = id.split("-")[0];
            var lot = id.split("-")[1];
            var bet = id.split("-")[2];
            if($(this).hasClass("yellow_bg")){
                $(this).removeClass("yellow_bg");
                delete JCZQ.selectMap["_"+mid][lot][bet];
                if(JSON.stringify(JCZQ.selectMap["_"+mid][lot])=='{}'){
                    delete JCZQ.selectMap["_"+mid][lot];
                }
                if(JCZQ.selectMap["_"+mid]['m']){
                    delete JCZQ.selectMap["_"+mid]['m'];
                }
                if(JSON.stringify(JCZQ.selectMap["_"+mid])=='{}'){
                    delete JCZQ.selectMap["_"+mid];
                }
                JCZQ.caleBetCount(mid);
            }else{
                JCZQ.getSelectCount();
                if(!JCZQ.selectMap["_"+mid]){
                    if(JCZQ.selectCount==8){
                        $.toast("最多选择8场赛事", "forbidden");
                        return;
                    }
                    JCZQ.selectMap["_"+mid] = {};
                }
                if(!JCZQ.selectMap["_"+mid][lot]){
                    JCZQ.selectMap["_"+mid][lot] = {};
                }
                JCZQ.selectMap["_"+mid][lot][bet] = JCZQ.jsonData["_"+mid][lot][bet];
                $(this).addClass("yellow_bg");
                JCZQ.caleBetCount(mid);
            }
            if(JCZQ.betMap["_"+mid]>0){
                $("#mid"+mid).html('已选<span style="color:#ff0033">'+JCZQ.betMap["_"+mid]+'</span>项');
            }else{
                $("#mid"+mid).text('混合投注');
            }
            JCZQ.getSelectCount();
            if(JCZQ.selectCount>0){
                $("#selectCount").html('已选<span style="color:#ff0033">'+JCZQ.selectCount+'</span>场');
            }else{
                $("#selectCount").text("至少选择一场比赛");
            }
        });

        $(".team_detail .text_left .hhtz").on("click",function(){
            var mid = $(this).attr("mid");
            JCZQ.showHtTab(mid);
        });
    },
    getSelectCount:function(){
        var map = JCZQ.selectMap;
        JCZQ.selectCount = Object.keys(map).length;
    },
    getBetCount:function(obj){
        if(!obj){
            return 0;
        }
        return Object.keys(obj).length;;
    },
    showHtTab:function(mid){
        JCZQ.mtop = scrolleH;
        document.body.scrollTop = 0;
        $("#htTab").show();
        $("#baseTab").hide();
        var m = JCZQ.jsonData["_"+mid];
        var h,d,a,isd="";
        var rh,rd,ra,isrqd="";
        if(m.had){
            if(m.had.single==1){
                isd = "red_dan_bg";
            }
            h = "胜 "+m.had.h;
            d = "平 "+m.had.d;
            a = "负 "+m.had.a;
        }
        if(m.hhad){
            if(m.hhad.single==1){
                isrqd = "red_dan_bg";
            }
            rh = m.hhad.fixedodds+" 胜 "+m.hhad.h;
            rd = m.hhad.fixedodds+" 平 "+m.hhad.d;
            ra = m.hhad.fixedodds+" 负 "+m.hhad.a;
        }
        var sMap = JCZQ.selectMap["_"+m.id];
        if(!sMap){
            sMap = {};
        }
        var div = '<div class="weui-flex text_center top">'+
            '<div class="weui-flex__item">'+m.h_cn_abbr+'</div>'+
            '<div class="weui-flex__item">VS</div>'+
            '<div class="weui-flex__item">'+m.a_cn_abbr+'</div>'+
            '</div>';
        div += '<div class="team_detail">';
        div += '<table class="table_one text_center">'+
            '<tbody>'+
            '<tr>'+
            '<td style="width: 20px;">0</td>';
        if(m.had){
            div += '<td class="show_match_table_td '+isd+' '+(sMap["had"]&&sMap["had"]["h"]?"yellow_bg":"")+'" id="_'+m.id+'-had-h">'+h+'</td>'+
                '<td class="show_match_table_td '+(sMap["had"]&&sMap["had"]["d"]?"yellow_bg":"")+'" id="_'+m.id+'-had-d">'+d+'</td>'+
                '<td class="show_match_table_td '+(sMap["had"]&&sMap["had"]["a"]?"yellow_bg":"")+'" id="_'+m.id+'-had-a">'+a+'</td>';
        }else{
            div += '<td colspan="3">不支持此玩法</td>';
        }

        div +=      '</tr>'+
            '<tr>'+
            '<td style="width: 20px;" class="red_color">'+(m.hhad?m.hhad.fixedodds:'-')+'</td>';
        if(m.hhad){
            div += '<td class="show_match_table_td '+isrqd+' '+(sMap["hhad"]&&sMap["hhad"]["h"]?"yellow_bg":"")+'" id="_'+m.id+'-hhad-h">'+rh+'</td>'+
                '<td class="show_match_table_td '+(sMap["hhad"]&&sMap["hhad"]["d"]?"yellow_bg":"")+'" id="_'+m.id+'-hhad-d">'+rd+'</td>'+
                '<td class="show_match_table_td '+(sMap["hhad"]&&sMap["hhad"]["a"]?"yellow_bg":"")+'" id="_'+m.id+'-hhad-a">'+ra+'</td>';
        }else{
            div += '<td>不支持次玩法</td>';
        }

        div +=   '</tr>'+
            '</tbody>'+
            '</table>';
        if(m.crs){
            div += '<p class="red_bg text_center">单</p>'+
                '<table class="table_two text_center">'+
                '<tbody>'+
                '<tr>'+
                '<td rowspan="3" style="width: 20px;">胜</td>'+
                '<td class="show_match_table_td '+(sMap["crs"]&&sMap["crs"]["0100"]?"yellow_bg":"")+'" id="_'+m.id+'-crs-0100">'+
                '<p>1:0</p>'+
                '<p>'+m.crs['0100']+'</p>'+
                '</td>'+
                '<td class="show_match_table_td '+(sMap["crs"]&&sMap["crs"]["0200"]?"yellow_bg":"")+'" id="_'+m.id+'-crs-0200">'+
                '<p>2:0</p>'+
                '<p>'+m.crs['0200']+'</p>'+
                '</td>'+
                '<td class="show_match_table_td '+(sMap["crs"]&&sMap["crs"]["0201"]?"yellow_bg":"")+'" id="_'+m.id+'-crs-0201">'+
                '<p>2:1</p>'+
                '<p>'+m.crs['0201']+'</p>'+
                '</td>'+
                '<td class="show_match_table_td '+(sMap["crs"]&&sMap["crs"]["0300"]?"yellow_bg":"")+'" id="_'+m.id+'-crs-0300">'+
                '<p>3:0</p>'+
                '<p>'+m.crs['0300']+'</p>'+
                '</td>'+
                '<td class="show_match_table_td '+(sMap["crs"]&&sMap["crs"]["0301"]?"yellow_bg":"")+'" id="_'+m.id+'-crs-0301">'+
                '<p>3:1</p>'+
                '<p>'+m.crs['0301']+'</p>'+
                '</td>'+
                '</tr>'+
                '<tr>'+
                '<td style="border-left:0;" class="show_match_table_td '+(sMap["crs"]&&sMap["crs"]["0302"]?"yellow_bg":"")+'" id="_'+m.id+'-crs-0302">'+
                '<p>3:2</p>'+
                '<p>'+m.crs['0302']+'</p>'+
                '</td>'+
                '<td class="show_match_table_td '+(sMap["crs"]&&sMap["crs"]["0400"]?"yellow_bg":"")+'" id="_'+m.id+'-crs-0400">'+
                '<p>4:0</p>'+
                '<p>'+m.crs['0400']+'</p>'+
                '</td>'+
                '<td class="show_match_table_td '+(sMap["crs"]&&sMap["crs"]["0401"]?"yellow_bg":"")+'" id="_'+m.id+'-crs-0401">'+
                '<p>4:1</p>'+
                '<p>'+m.crs['0401']+'</p>'+
                '</td>'+
                '<td class="show_match_table_td '+(sMap["crs"]&&sMap["crs"]["0402"]?"yellow_bg":"")+'" id="_'+m.id+'-crs-0402">'+
                '<p>4:2</p>'+
                '<p>'+m.crs['0402']+'</p>'+
                '</td>'+
                '<td class="show_match_table_td '+(sMap["crs"]&&sMap["crs"]["0500"]?"yellow_bg":"")+'" id="_'+m.id+'-crs-0500">'+
                '<p>5:0</p>'+
                '<p>'+m.crs['0500']+'</p>'+
                '</td>'+
                '</tr>'+
                '<tr>'+
                '<td style="border-left:0;" class="show_match_table_td '+(sMap["crs"]&&sMap["crs"]["0501"]?"yellow_bg":"")+'" id="_'+m.id+'-crs-0501">'+
                '<p>5:1</p>'+
                '<p>'+m.crs['0501']+'</p>'+
                '</td>'+
                '<td class="show_match_table_td '+(sMap["crs"]&&sMap["crs"]["0502"]?"yellow_bg":"")+'" id="_'+m.id+'-crs-0502">'+
                '<p>5:2</p>'+
                '<p>'+m.crs['0502']+'</p>'+
                '</td>'+
                '<td colspan="3" class="show_match_table_td '+(sMap["crs"]&&sMap["crs"]["-1-h"]?"yellow_bg":"")+'" id="_'+m.id+'-crs-H">'+
                '<p>胜其他</p>'+
                '<p>'+m.crs['-1-h']+'</p>'+
                '</td>'+
                '</tr>'+
                '<tr>'+
                '<td style="width: 20px;">平</td>'+
                '<td class="show_match_table_td '+(sMap["crs"]&&sMap["crs"]["0000"]?"yellow_bg":"")+'" id="_'+m.id+'-crs-0000">'+
                '<p>0:0</p>'+
                '<p>'+m.crs['0000']+'</p>'+
                '</td>'+
                '<td class="show_match_table_td '+(sMap["crs"]&&sMap["crs"]["0101"]?"yellow_bg":"")+'" id="_'+m.id+'-crs-0101">'+
                '<p>1:1</p>'+
                '<p>'+m.crs['0101']+'</p>'+
                '</td>'+
                '<td class="show_match_table_td '+(sMap["crs"]&&sMap["crs"]["0202"]?"yellow_bg":"")+'" id="_'+m.id+'-crs-0202">'+
                '<p>2:2</p>'+
                '<p>'+m.crs['0202']+'</p>'+
                '</td>'+
                '<td class="show_match_table_td '+(sMap["crs"]&&sMap["crs"]["0303"]?"yellow_bg":"")+'" id="_'+m.id+'-crs-0303">'+
                '<p>3:3</p>'+
                '<p>'+m.crs['0303']+'</p>'+
                '</td>'+
                '<td class="show_match_table_td '+(sMap["crs"]&&sMap["crs"]["-1-d"]?"yellow_bg":"")+'" id="_'+m.id+'-crs-D">'+
                '<p>平其他</p>'+
                '<p>'+m.crs['-1-d']+'</p>'+
                '</td>'+
                '</tr>'+
                '<tr>'+
                '<td rowspan="3" style="width: 20px;">负</td>'+
                '<td class="show_match_table_td '+(sMap["crs"]&&sMap["crs"]["0001"]?"yellow_bg":"")+'" id="_'+m.id+'-crs-0001">'+
                '<p>0:1</p>'+
                '<p>'+m.crs['0001']+'</p>'+
                '</td>'+
                '<td class="show_match_table_td '+(sMap["crs"]&&sMap["crs"]["0002"]?"yellow_bg":"")+'" id="_'+m.id+'-crs-0002">'+
                '<p>0:2</p>'+
                '<p>'+m.crs['0002']+'</p>'+
                '</td>'+
                '<td class="show_match_table_td '+(sMap["crs"]&&sMap["crs"]["0102"]?"yellow_bg":"")+'" id="_'+m.id+'-crs-0102">'+
                '<p>1:2</p>'+
                '<p>'+m.crs['0102']+'</p>'+
                '</td>'+
                '<td class="show_match_table_td '+(sMap["crs"]&&sMap["crs"]["0003"]?"yellow_bg":"")+'" id="_'+m.id+'-crs-0003">'+
                '<p>0:3</p>'+
                '<p>'+m.crs['0003']+'</p>'+
                '</td>'+
                '<td class="show_match_table_td '+(sMap["crs"]&&sMap["crs"]["0103"]?"yellow_bg":"")+'" id="_'+m.id+'-crs-0103">'+
                '<p>1:3</p>'+
                '<p>'+m.crs['0103']+'</p>'+
                '</td>'+
                '</tr>'+
                '<tr>'+
                '<td style="border-left:0;" class="show_match_table_td '+(sMap["crs"]&&sMap["crs"]["0203"]?"yellow_bg":"")+'" id="_'+m.id+'-crs-0203">'+
                '<p>2:3</p>'+
                '<p>'+m.crs['0203']+'</p>'+
                '</td>'+
                '<td class="show_match_table_td '+(sMap["crs"]&&sMap["crs"]["0004"]?"yellow_bg":"")+'" id="_'+m.id+'-crs-0004">'+
                '<p>0:4</p>'+
                '<p>'+m.crs['0004']+'</p>'+
                '</td>'+
                '<td class="show_match_table_td '+(sMap["crs"]&&sMap["crs"]["0104"]?"yellow_bg":"")+'" id="_'+m.id+'-crs-0104">'+
                '<p>1:4</p>'+
                '<p>'+m.crs['0104']+'</p>'+
                '</td>'+
                '<td class="show_match_table_td '+(sMap["crs"]&&sMap["crs"]["0204"]?"yellow_bg":"")+'" id="_'+m.id+'-crs-0204">'+
                '<p>2:4</p>'+
                '<p>'+m.crs['0204']+'</p>'+
                '</td>'+
                '<td class="show_match_table_td '+(sMap["crs"]&&sMap["crs"]["0005"]?"yellow_bg":"")+'" id="_'+m.id+'-crs-0005">'+
                '<p>0:5</p>'+
                '<p>'+m.crs['0005']+'</p>'+
                '</td>'+
                '</tr>'+
                '<tr>'+
                '<td style="border-left:0;" class="show_match_table_td '+(sMap["crs"]&&sMap["crs"]["0105"]?"yellow_bg":"")+'" id="_'+m.id+'-crs-0105">'+
                '<p>1:5</p>'+
                '<p>'+m.crs['0105']+'</p>'+
                '</td>'+
                '<td class="show_match_table_td '+(sMap["crs"]&&sMap["crs"]["0205"]?"yellow_bg":"")+'" id="_'+m.id+'-crs-0205">'+
                '<p>2:5</p>'+
                '<p>'+m.crs['0205']+'</p>'+
                '</td>'+
                '<td colspan="3" class="show_match_table_td '+(sMap["crs"]&&sMap["crs"]["-1-a"]?"yellow_bg":"")+'" id="_'+m.id+'-crs-A">'+
                '<p>负其他</p>'+
                '<p>'+m.crs['-1-a']+'</p>'+
                '</td>'+
                '</tr>'+
                '</tbody>'+
                '</table>';
        }
        if(m.ttg){
            div += ' </tr></tbody></table><p class="red_bg text_center">单</p>';
            div += '<table class="table_three text_center">'+
                '<tbody>'+
                '<tr>'+
                '<td rowspan="2" style="width: 20px;">总进球</td>'+
                '<td class="show_match_table_td '+(sMap["ttg"]&&sMap["ttg"]["s0"]?"yellow_bg":"")+'" id="_'+m.id+'-ttg-s0">0 '+m.ttg.s0+'</td>'+
                '<td class="show_match_table_td '+(sMap["ttg"]&&sMap["ttg"]["s1"]?"yellow_bg":"")+'" id="_'+m.id+'-ttg-s1">1 '+m.ttg.s1+'</td>'+
                '<td class="show_match_table_td '+(sMap["ttg"]&&sMap["ttg"]["s2"]?"yellow_bg":"")+'" id="_'+m.id+'-ttg-s2">2 '+m.ttg.s2+'</td>'+
                '<td class="show_match_table_td '+(sMap["ttg"]&&sMap["ttg"]["s3"]?"yellow_bg":"")+'" id="_'+m.id+'-ttg-s3">3 '+m.ttg.s3+'</td>'+
                '</tr>'+
                '<tr>'+
                '<td style="border-left:0;" class="show_match_table_td '+(sMap["ttg"]&&sMap["ttg"]["s4"]?"yellow_bg":"")+'" id="_'+m.id+'-ttg-s4">4 '+m.ttg.s4+'</td>'+
                '<td class="show_match_table_td '+(sMap["ttg"]&&sMap["ttg"]["s5"]?"yellow_bg":"")+'" id="_'+m.id+'-ttg-s5">5 '+m.ttg.s5+'</td>'+
                '<td class="show_match_table_td '+(sMap["ttg"]&&sMap["ttg"]["s6"]?"yellow_bg":"")+'" id="_'+m.id+'-ttg-s6">6 '+m.ttg.s6+'</td>'+
                '<td class="show_match_table_td '+(sMap["ttg"]&&sMap["ttg"]["s7"]?"yellow_bg":"")+'" id="_'+m.id+'-ttg-s7">7+ '+m.ttg.s7+'</td>'+
                '</tr>'+
                '</tbody>'+
                '</table>';
        }
        if(m.hafu){
            div += '<p class="red_bg text_center">单</p>'+
                '<table class="table_four text_center">'+
                '<tbody>'+
                '<tr>'+
                '<td rowspan="3" style="width: 20px;">半全场</td>'+
                '<td class="show_match_table_td '+(sMap["hafu"]&&sMap["hafu"]["hh"]?"yellow_bg":"")+'" id="_'+m.id+'-hafu-hh"><p>胜胜</p><p>'+m.hafu.hh+'</p></td>'+
                '<td class="show_match_table_td '+(sMap["hafu"]&&sMap["hafu"]["hd"]?"yellow_bg":"")+'" id="_'+m.id+'-hafu-hd"><p>胜平</p><p>'+m.hafu.hd+'</p></td>'+
                '<td class="show_match_table_td '+(sMap["hafu"]&&sMap["hafu"]["ha"]?"yellow_bg":"")+'" id="_'+m.id+'-hafu-ha"><p>胜负</p><p>'+m.hafu.ha+'</p></td>'+
                '</tr>'+
                '<tr>'+
                '<td style="border-left:0;" class="show_match_table_td '+(sMap["hafu"]&&sMap["hafu"]["dh"]?"yellow_bg":"")+'" id="_'+m.id+'-hafu-dh"><p>平胜</p><p>'+m.hafu.dh+'</p></td>'+
                '<td class="show_match_table_td '+(sMap["hafu"]&&sMap["hafu"]["dd"]?"yellow_bg":"")+'" id="_'+m.id+'-hafu-dd"><p>平平</p><p>'+m.hafu.dd+'</p></td>'+
                '<td class="show_match_table_td '+(sMap["hafu"]&&sMap["hafu"]["da"]?"yellow_bg":"")+'" id="_'+m.id+'-hafu-da"><p>平负</p><p>'+m.hafu.da+'</p></td>'+
                '</tr>'+
                '<tr>'+
                '<td style="border-left:0;" class="show_match_table_td '+(sMap["hafu"]&&sMap["hafu"]["ah"]?"yellow_bg":"")+'" id="_'+m.id+'-hafu-ah"><p>负胜</p><p>'+m.hafu.ah+'</p></td>'+
                '<td class="show_match_table_td '+(sMap["hafu"]&&sMap["hafu"]["ad"]?"yellow_bg":"")+'" id="_'+m.id+'-hafu-ad"><p>负平</p><p>'+m.hafu.ad+'</p></td>'+
                '<td class="show_match_table_td '+(sMap["hafu"]&&sMap["hafu"]["aa"]?"yellow_bg":"")+'" id="_'+m.id+'-hafu-aa"><p>负负</p><p>'+m.hafu.aa+'</p></td>'+
                '</tr>'+
                '</tbody>'+
                '</table>';
        }
        div +='</div>';
        $("#htTab .jr_recommend_detail").html(div);
        $("#sureHtTab").attr("mid",m.id);

        $(".show_match_table_td").on("click",function(){
            if($(this).text()=="-"){
                return;
            }
            if($(this).hasClass("yellow_bg")){//
                $(this).removeClass("yellow_bg");
            }else{
                $(this).addClass("yellow_bg");
            }

        });

        $("#sureHtTab").unbind("click").on("click",function(){
            var matchNumber = $(this).attr("mid");
            var sure = true;
            $(".show_match_table_td").each(function(){
                if($(this).hasClass("yellow_bg")){
                    var id = $(this).attr("id");
                    var mid = id.split("-")[0];
                    var lot = id.split("-")[1];
                    var bet = id.split("-")[2];
                    if(bet=='H') bet = '-1-h';
                    if(bet=='D') bet = '-1-d';
                    if(bet=='A') bet = '-1-a';

                    JCZQ.getSelectCount();
                    if(!JCZQ.selectMap[mid]){
                        if(JCZQ.selectCount==8){
                            $.toast("最多选择8场赛事", "forbidden");
                            sure = false;
                            return;
                        }
                        JCZQ.selectMap[mid] = {};
                    }
                    if(!JCZQ.selectMap[mid][lot]){
                        JCZQ.selectMap[mid][lot] = {};
                    }
                    JCZQ.selectMap[mid][lot][bet] = JCZQ.jsonData[mid][lot][bet];
                    var key1 = id.substring(1);
                    if($("#"+key1).length>0){
                        $("#"+key1).addClass("yellow_bg");
                    }
                }
            });

            if(JCZQ.selectMap["_"+matchNumber]){
                for(var k in JCZQ.selectMap["_"+matchNumber]){
                    var lotMap = JCZQ.selectMap["_"+matchNumber][k];
                    if(lotMap){
                        for(var kk in lotMap){
                            var bt = kk;
                            if(kk=="-1-h") bt = "H";
                            if(kk=="-1-d") bt = "D";
                            if(kk=="-1-a") bt = "A";
                            var key = "_"+matchNumber+"-"+k+"-"+bt;
                            if(!$("#"+key).hasClass("yellow_bg")){
                                if(k=='m'){
                                    delete JCZQ.selectMap["_"+matchNumber][k];
                                }else{
                                    delete JCZQ.selectMap["_"+matchNumber][k][kk];
                                    if(JSON.stringify(JCZQ.selectMap["_"+matchNumber][k])=='{}'){
                                        delete JCZQ.selectMap["_"+matchNumber][k];
                                    }
                                    if(JCZQ.selectMap["_"+matchNumber]['m']){
                                        delete JCZQ.selectMap["_"+matchNumber]['m'];
                                    }
                                    if(JSON.stringify(JCZQ.selectMap["_"+matchNumber])=='{}'){
                                        delete JCZQ.selectMap["_"+matchNumber];
                                    }
                                    var key1 = matchNumber+"-"+k+"-"+bt;
                                    if($("#"+key1).length>0&&$("#"+key1).hasClass("yellow_bg")){
                                        $("#"+key1).removeClass("yellow_bg");
                                    }
                                }
                            }
                        }
                    }
                }
            }
            JCZQ.caleBetCount(matchNumber);
            if(sure){
                if(JCZQ.betMap["_"+matchNumber]>0){
                    $("#mid"+matchNumber).html('已选<span style="color:#ff0033">'+JCZQ.betMap["_"+matchNumber]+'</span>项');
                }else{
                    $("#mid"+matchNumber).text('混合投注');
                }
                JCZQ.getSelectCount();
                if(JCZQ.selectCount>0){
                    $("#selectCount").html('已选<span style="color:#ff0033">'+JCZQ.selectCount+'</span>场');
                }else{
                    $("#selectCount").text("至少选择一场比赛");
                }
                $("#htTab").hide();
                $("#baseTab").show();
                document.body.scrollTop = JCZQ.mtop;
            }
        });
    },
    caleBetCount:function(mid){
        var betMapCount = 0;
        if(JCZQ.selectMap["_"+mid]){
            for(var k in JCZQ.selectMap["_"+mid]){
                if(k=='m'){
                    continue;
                }
                var ltMap = JCZQ.selectMap["_"+mid][k];
                if(ltMap){
                    betMapCount += JCZQ.getBetCount(ltMap);
                }
            }
        }
        JCZQ.betMap["_"+mid] = betMapCount;
    },
    caleTotalZs:function(){
        var zs = 1;
        if(JCZQ.betMap){
            for(var k in JCZQ.betMap){
                if(JCZQ.betMap[k]==0){
                    delete JCZQ.betMap[k];
                    continue;
                }
                zs *= JCZQ.betMap[k];
            }
        }
        JCZQ.zhushu = zs;
    },
    surePub:function(){
        var fb = JCZQ.checkMap();
        if(fb){
            $("#surePubTab").show();
            $("#baseTab").hide();
            JCZQ.mtop = scrolleH;
            document.body.scrollTop = 0;
            var isFs = JCZQ.checkIsFs();
            if(isFs){
                $("#yh_div").show();
            }else{
                $("#yh_div").hide();
                JCZQ.yh = 0;

            }
            var td ='';
            for(var k in JCZQ.selectMap){
                var map = JCZQ.selectMap[k];
                var match = map.m;
                td += '<p class="tit_ss"><span class="team_name">'+match.num+' '+match.h_cn_abbr+' VS '+match.a_cn_abbr+'</span>';
                var arr = [];
                for(var kk in map){
                    if(kk==='m'){
                        continue;
                    }
                    for(var jk in map[kk]){
                        var obj = {};
                        obj.sort = betParamMap[kk][jk];
                        obj.odd = map[kk][jk];
                        obj.bet = jk;
                        obj.lot = kk;
                        if(kk==='hhad'){
                            obj.pankou = map['m'][kk].fixedodds;
                        }
                        arr.push(obj);
                    }
                }
                arr.sort(by_str("sort")).reverse();
                td += '<span class="team_ret">';
                for(var i in arr){
                    var rq = "非让球";
                    if(arr[i].pankou){
                        rq = "主让"+arr[i].pankou;
                    }
                    td += '<span class="text_center">'+
                        '<em>'+rq+'</em>'+
                        '<i>'+paramsMap[arr[i].lot][arr[i].bet]+' '+arr[i].odd+'</i>'+
                        '</span>'+
                        '';
                }
                td += ' </span></p>';
            }
            $("#match_detail").html(td);
            JCZQ.caleTotalZs();
            JCZQ.calcOrder();
            if(JCZQ.scp.order.orderAwardMin==JCZQ.scp.order.orderAwardMax){
                $("#hundredBonus").text(JCZQ.scp.order.orderAwardMax);
            }else{
                $("#hundredBonus").text(JCZQ.scp.order.orderAwardMin+"-"+JCZQ.scp.order.orderAwardMax);
            }
        }
    },
    checkMap:function(){
        var count = JCZQ.selectCount;
        if(count==0){
            $.toast("请至少选择一场赛事", "forbidden");
            return false;
        }
        var lMap = {};
        if(count==1){
            var sMap = JCZQ.selectMap;
            for(var key in sMap){
                for(var k in sMap[key]){
                    if(k=='m'){
                        continue;
                    }
                    lMap[k] = 1;
                }
                sMap[key]['m'] = JCZQ.jsonData[key];
            }
        }else{
            var sMap = JCZQ.selectMap;
            for(var key in sMap){
                var bdx = 0;
                for(var k in sMap[key]){
                    if(k=='m'){
                        continue;
                    }
                    lMap[k] = 1;
                }
                sMap[key]['m'] = JCZQ.jsonData[key];
            }
        }
        if(JCZQ.getBetCount(lMap)>1){
            JCZQ.lotteryId = "59";
        }else{
            var lk;
            for(var jk in lMap){
                lk = jk;
            }
            JCZQ.lotteryId = poolId[lk];
        }
        JCZQ.passway = count+"01";
        return true;
    },
    checkIsFs:function(){
        if(JCZQ.betMap){
            for(var k in JCZQ.betMap){
                if(JCZQ.betMap[k]>1){
                    return true;
                }
            }
        }
        return false;
    },
    getCompleteData:function(){
        var order = {};
        order.passway = JCZQ.passway;
        order.yh = JCZQ.yh;
        order.lotteryId = JCZQ.lotteryId;
        order.hundredBonus = JCZQ.scp.order.orderAwardMax;
        order.mtype = 1;
        if(JCZQ.scp.order.orderAwardMin!=JCZQ.scp.order.orderAwardMax){
            order.expert_bonus = JCZQ.scp.order.orderAwardMin+"-"+JCZQ.scp.order.orderAwardMax;
        }else{
            order.expert_bonus = JCZQ.scp.order.orderAwardMin;
        }
        var week = getWeekStrByDateStr2(formatFullTime(new Date()));
        var bookEndTimeLong = 999999999999999;
        for(var k in JCZQ.scp.selectMatchMap){
            JCZQ.scp.selectMatchMap[k].content = {};
            var bor = [];
            var match = JCZQ.scp.selectMatchMap[k];
            if(bookEndTimeLong>match.m.bookEndTimeLong){
                order.bookEndTime = match.m.book_end_time;
                bookEndTimeLong = match.m.bookEndTimeLong;
            }
            for(var kk in match){
                if(kk!='m'&&kk!='arr'){
                    for(var jk in  match[kk]){
                        var obj = {};
                        obj.lott = kk;
                        obj.bet = jk;
                        obj.odd = match[kk][jk];
                        obj.sort = betParamMap[kk][jk];
                        bor.push(obj);
                    }
                }
            }
            bor.sort(by_str("sort")).reverse();
            JCZQ.scp.selectMatchMap[k].content = bor;
        }
        order.content = JCZQ.scp.selectMatchMap;
        JCZQ.order = order;
    },
    getMulArr:function(){
        var mulArr = {};
        if(JCZQ.yh==0){//直接打的情况
            var map = JCZQ.scp.selectMatchMap;
            var mul = JCZQ.scp.order.betMul;
            var arr = [];
            for(var k in map){
                var objArr = [];
                for(var key in map[k]){
                    if(key==='m'){
                        continue;
                    }
                    for(var kk in map[k][key]){
                        if(kk==='pankou'){
                            continue;
                        }
                        if(key=="hhad"){
                            objArr.push(k+"^r"+kk);
                        }else{
                            objArr.push(k+"^"+kk);
                        }
                    }
                }
                arr.push(objArr);
            }
            if(arr.length==1){
                for(var j in arr){
                    if(arr[j].length==1){
                        mulArr[arr[j]]= mul;
                    }else{
                        for(var k in arr[j]){
                            mulArr[arr[j][k]] = mul;
                        }
                    }
                }
            }else{
                for(var j in arr[0]){
                    for(var k in arr[1]){
                        mulArr[arr[0][j]+"|"+arr[1][k]] = mul;
                    }
                }
            }
        }else{
            var jjyhList = JCZQ.scp.jjyhlist;
            for(var k in jjyhList){
                var list = jjyhList[k];
                var str = '';
                var bs = list.bs;
                for(var i in list){
                    if(typeof list[i] != 'object'){
                        continue;
                    }
                    var tt = "";
                    if(list[i].type=="spf"){
                        tt = "r";
                    }
                    str += '|_'+list[i].id+"^"+tt+list[i].bet;
                }
                str = str.substring(1);
                mulArr[str] = bs;
            }
        }
        return mulArr;
    }
}

JCZQ.scp.getPassWay = function(){
    var pass = JCZQ.passway+"";
    var passwayArr = [];
    passwayArr.push(pass.replace("0","x"));
    return passwayArr;
}
JCZQ.calcOrder = function(){
    JCZQ.scp.g_config = {};
    JCZQ.scp.g_config.lottery_type = betParamMap.lotteryId[JCZQ.lotteryId+""];
    JCZQ.scp.selectMatchMap = JCZQ.selectMap;
    JCZQ.scp.betCnMap = paramsMap;
    JCZQ.scp.betEnMap = betEnMap;
    //订单计算后数据
    var betMul = 50;
    if(50%JCZQ.zhushu==0){
        betMul = betMul/JCZQ.zhushu;
    }
    JCZQ.scp.order={betMul:betMul,betnum:0,orderMoney:0,orderMoneyJjyh:100,orderAwardMin:0,orderAwardMax:0,followAllow:true,followMoney:0};
    JCZQ.calcMoney();
    JCZQ.isJjyh = false;
    if(50%JCZQ.zhushu>0){
        $("#jjyhBtn").children().eq(0).hide();
        $("#jjyhBtn").find("button").removeClass("yellow_bg");
        $("#jjyhBtn").children().eq(1).find("button").addClass("yellow_bg");
        JCZQ.jjyhChange();
    }else{
        if(JCZQ.scp.jjyh){
            JCZQ.scp.jjyh.type = "zjd";
        }
        $("#jjyhBtn").children().eq(0).show();
        $("#jjyhBtn").find("button").removeClass("yellow_bg");
        $("#jjyhBtn").children().eq(0).find("button").addClass("yellow_bg");
        if(JCZQ.scp.order.orderAwardMin==JCZQ.scp.order.orderAwardMax){
            $("#hundredBonus").text(JCZQ.scp.order.orderAwardMax);
        }else{
            $("#hundredBonus").text(JCZQ.scp.order.orderAwardMin+"-"+JCZQ.scp.order.orderAwardMax);
        }
    }
}

//计算投注额及奖金
JCZQ.calcMoney = function(){
    jczq.vm =JCZQ.scp;
    var reObj = jczq.bet.main();
    JCZQ.scp.order.betnum = reObj.betNum;
    JCZQ.scp.order.followMoney=JCZQ.scp.order.betnum*2;
    JCZQ.scp.order.orderMoney = (JCZQ.scp.order.betnum*JCZQ.scp.order.betMul*2);
    JCZQ.scp.order.orderAwardMin = reObj.min.toFixed(2);
    JCZQ.scp.order.orderAwardMax = reObj.max.toFixed(2);
}

//奖金优化计算器
JCZQ.jjyhCalc = function(type){
    var passway = JCZQ.scp.getPassWay();
    var num = 0;
    JCZQ.scp.jjyh={type:type};
    JCZQ.scp.jjyh.passway = parseInt(passway[0].charAt(0));
    var jjyhMoney = JCZQ.scp.order.orderMoneyJjyh;
    if(!num || isNaN(num)){
        num = 0;
    }
    if(jjyhMoney==0 || isNaN(jjyhMoney)||jjyhMoney<JCZQ.scp.minJjyhMoney){
        jjyhMoney = JCZQ.scp.minJjyhMoney;
    }
    JCZQ.scp.order.orderMoneyJjyh = jjyhMoney+parseInt(num);
    if(JCZQ.scp.order.orderMoneyJjyh<0 || isNaN(JCZQ.scp.order.orderMoneyJjyh)){
        JCZQ.scp.order.orderMoneyJjyh=JCZQ.scp.order.orderMoney;
    }
    OP.main(JCZQ.scp);
    JCZQ.scp.order.orderAwardMin=999999999;
    JCZQ.scp.order.orderAwardMax = 0;
    for(var lk in JCZQ.scp.jjyhlist){
        var jjyh = JCZQ.scp.jjyhlist[lk];
        var prize = parseFloat(jjyh.prize);
        if(prize>JCZQ.scp.order.orderAwardMax){
            JCZQ.scp.order.orderAwardMax = prize;
        }
        if(JCZQ.scp.order.orderAwardMin>prize){
            JCZQ.scp.order.orderAwardMin = prize;
        }
    }
    JCZQ.scp.minJjyhMoney = JCZQ.scp.jjyhlist.length*2;
    JCZQ.scp.order.betMul = parseInt(JCZQ.scp.order.orderMoneyJjyh/2);
    JCZQ.isJjyh = true;
}

//平均，博热，博冷
JCZQ.jjyhChange=function(type,t){
    if(!type){
        type = "avg";
    }
    if(!JCZQ.isJjyh||!t){
        JCZQ.jjyhCalc(type);
    }else{
        if(JCZQ.scp.jjyh.type==type&&t){
            return;
        }
        JCZQ.scp.jjyh.type=type;
        OP.changeType(type);
    }
    JCZQ.yh = JCZQ.yhMap[type];
    $("#hundredBonus").text(JCZQ.scp.order.orderAwardMin+"-"+JCZQ.scp.order.orderAwardMax);
}


JCZQ.init=function(){
    JCZQ.formatJsonData();
    JCZQ.createHtml();
}
JCZQ.Main = function(jsonData){
    JCZQ.jsonData = jsonData.data;
    JCZQ.init();
    $("#delMap").on("click",function(){
        JCZQ.selectMap= {};
        JCZQ.betMap = {};
        $(".team_detail .text_left .hhtz_spf .weui-flex__item").removeClass("yellow_bg");
        $("#selectCount").text("非单关至少选择两场比赛");
        $(".team_detail .text_left .hhtz").text('混合投注');
    });
    $("#removeHtTab").on("click",function(){
        $("#htTab").hide();
        $("#baseTab").show();
        document.body.scrollTop = JCZQ.mtop;
    });
    $("#ok_pub").on("click",function(){
        JCZQ.surePub();
    });
    $("#jjyhBtn").find("button").on("click",function(){
        var type = $(this).attr("type");
        $("#jjyhBtn").find("button").removeClass("yellow_bg");
        $(this).addClass("yellow_bg");
        if(type=='zjd'){
            var  betMul = 50;
            if(50%JCZQ.zhushu==0){
                betMul = betMul/JCZQ.zhushu;
            }
            JCZQ.scp.order={betMul:betMul,betnum:0,orderMoney:0,orderMoneyJjyh:100,orderAwardMin:0,orderAwardMax:0,followAllow:true,followMoney:0};
            JCZQ.calcMoney();
            JCZQ.scp.jjyh.type=type;
            JCZQ.yh = JCZQ.yhMap[type];
            $("#hundredBonus").text(JCZQ.scp.order.orderAwardMin+"-"+JCZQ.scp.order.orderAwardMax);
        }else{
            JCZQ.jjyhChange(type,1);
        }
    });
}
var scrolleH = 0;
$(function(){
    $(window).scroll(function(){
        var scroH = $(this).scrollTop();
        scrolleH = scroH;
    });
});