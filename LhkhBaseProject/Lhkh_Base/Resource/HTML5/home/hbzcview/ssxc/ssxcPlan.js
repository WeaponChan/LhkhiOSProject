
var TE = {
    match:{
        zq:{},
        lq:{},
        wdls:{},
        mzl:{},
        yc:{},
        xj:{},
        fj:{},
        yj:{},
        dj:{}
    },
    html:{
        zq:{},
        lq:{},
        xj:{},
        fj:{},
        yj:{},
        yc:{},
        dj:{},
        mzl:{},
        wdls:{},
    },
    clolor:{
        "xj":"#29304A",
        "dj":"#721D22",
        "fj":"#082149",
        "yj":"#2CB273",
        "yc":"#640A3D",
        "wdls":"#191CBF",
        "mzl":"#3423FF",
        "zq":"#0E00FF",
        "lq":"#0E00FF"
    },
    img:{
        zq:"/h5/img/ban/zqss.jpg?v="+timeToTimestamp(new Date()),
        lq:"/h5/img/ban/lqss.jpg?v="+timeToTimestamp(new Date()),
        xj:"/h5/img/ban/xj.jpg?v="+timeToTimestamp(new Date()),
        fj:"/h5/img/ban/fj.jpg?v="+timeToTimestamp(new Date()),
        yj:"/h5/img/ban/yj.jpg?v="+timeToTimestamp(new Date()),
        yc:"/h5/img/ban/yc.jpg?v="+timeToTimestamp(new Date()),
        dj:"/h5/img/ban/dj.jpg?v="+timeToTimestamp(new Date()),
        wdls:"/h5/img/ban/wdls.jpg?v="+timeToTimestamp(new Date()),
        mzl:"/h5/img/ban/mzl.jpg?v="+timeToTimestamp(new Date())
    },imgTitle:{
        zq:"/h5/img/ban/zq_t.jpg?v="+timeToTimestamp(new Date()),
        lq:"/h5/img/ban/lq_t.jpg?v="+timeToTimestamp(new Date()),
        xj:"/h5/img/ban/xj_t.jpg?v="+timeToTimestamp(new Date()),
        fj:"/h5/img/ban/fj_t.jpg?v="+timeToTimestamp(new Date()),
        yj:"/h5/img/ban/yj_t.jpg?v="+timeToTimestamp(new Date()),
        yc:"/h5/img/ban/yc_t.jpg?v="+timeToTimestamp(new Date()),
        dj:"/h5/img/ban/dj_t.jpg?v="+timeToTimestamp(new Date()),
        wdls:"/h5/img/ban/wdls_t.jpg?v="+timeToTimestamp(new Date()),
        mzl:"/h5/img/ban/mzl_t.jpg?v="+timeToTimestamp(new Date())
    },
    timer:0,
    date:stringToDate(new Date(),"MM月dd日"),
    B_info:{},
    isCreate:false,
    RichMatch:{"西甲":"xj","法甲":"fj","德甲":"dj","英超":"yc","意甲":"yj","美职篮":"mzl"},
    matchTitle:{
        zq:"足球赛事",
        lq:"篮球赛事",
        yc:"英超赛事",
        yj:"意甲赛事",
        fj:"法甲赛事",
        dj:"德甲赛事",
        xj:"西甲赛事",
        mzl:"NBA赛事",
        wdls:"五大赛事"
    },
    format:function(json,kt){
        var data = json["data"];
        var nod = getWeekStrByDate2(new Date());
        var nowDate = formatDateTime(new Date());
        if(data){
            var nowTime=new Date().getTime();
            for(var id in data){
                var m = data[id];
                m.match_start_time = m.date + ' ' + m.time;
                var date = parseTime(m.match_start_time);
                var bDate = parseTime(m.b_date+" 00:00:00");
                var hour = date.getHours();
                if(bDate.getDay()==0 || bDate.getDay()==6){
                    if(hour >= 1 && hour < 9 || hour ==23){
                        m.book_end_time = m.b_date+" 23:00:00";
                    }else{
                        m.book_end_time = m.match_start_time;
                    }
                }else{
                    if(hour >= 0 && hour < 9|| hour ==23 || hour==22){
                        m.book_end_time = m.b_date+" 22:00:00";
                    }else{
                        m.book_end_time = m.match_start_time;
                    }
                }
                if(m.match_start_time < m.book_end_time){
                    m.book_end_time = m.match_start_time;
                }
                m.bookEndTimeLong=parseTime(m.book_end_time).getTime();
                if(m.bookEndTimeLong<nowTime){//截止
                    delete data[id];
                    continue;
                }
                if(TE.RichMatch[m.l_cn_abbr]){
                    if(!TE.match[TE.RichMatch[m.l_cn_abbr]][m.b_date]){
                        TE.match[TE.RichMatch[m.l_cn_abbr]][m.b_date]={};
                    }
                    TE.match[TE.RichMatch[m.l_cn_abbr]][m.b_date][id] = m;
                    if(TE.RichMatch[m.l_cn_abbr]!="mzl"){
                        if(!TE.match.wdls[m.b_date]){
                            TE.match.wdls[m.b_date] = {};
                        }
                        TE.match.wdls[m.b_date][id] = m;
                    }
                }
                if(!TE.match[kt][m.b_date]){
                    TE.match[kt][m.b_date] = {};
                }
                TE.match[kt][m.b_date][id] = m;

            }
        }
        return data;
    },getData:function(){
        if(TE.isCreate){
            TE.getMatch();
            return;
        }
        let data = matchTypeData;
        var businessInfo = data.args.businessInfo;
        TE.B_info = businessInfo;
        var serverDate = data.args.date;
        var jsdata = data.args.json;
        var lqJson = data.args.json_bas;
        var zq = TE.format(jsdata,"zq");
        var lq = TE.format(lqJson,"lq");
        setTimeout(function(){
            TE.timer++;
        }, 2000);
        TE.getMatch();
    },
    getDateStr:function(dt){
        var now = new Date();
        var rdt = stringToDate(parseDate(dt),"MM月dd日");
        now = stringToDate(now,"MM月dd日");
        if(rdt==now){
            return "今日";
        }
        return rdt;
    },
    getMatch:function(){
        var match = TE.match;
        var bn ='';
        var hs = $(".leftBox .item").eq(1).hasClass("active");
        var len = 0;
        for(var k in match){
            var mtch = match[k];
            if(mtch&&Object.keys(mtch).length>0){
                //if(k=="zq"||k=="lq"){
                for(ak in mtch){
                    var mt = mtch[ak];
                    if(mt){
                        len++;
                        if(hs){
                            var rdt = TE.getDateStr(ak);
                            if(k!="zq"&&k!="lq"&&rdt!="今日"){
                                console.log(mt)
                            }else{
                                TE.createHtml(k,ak);
                                var title = rdt+TE.matchTitle[k];
                                let url = 'https://m.lycf888.com'+TE.imgTitle[k]
                                bn += '<div class="item"  style="background: url(\''+url+'\') no-repeat; background-size: 100%;" onclick="showMatchImg(\''+k+'\',\''+ak+'\')">'+
                                    '<div class="footer">'+title+'</div>'+
                                    '</div>';
                            }
                        }
                    }
                }
            }
        }
        if(len>0){
            $("#jrscCount").text(len);
        }
        if(hs){
            $("#tab1").html(bn);
            $(".weui-loadmore").html('');
        }
        TE.isCreate = true;
    }
    ,createHtml:function(tab,dt){
        var jsonList = TE.match[tab][dt];
        var dtr = stringToDate(parseDate(dt),"MM月dd日");
        var tr = '<div class="data">'+
            '<div class="title">'+dtr+'，共'+Object.keys(jsonList).length+'场比赛</div>'+
            '<div class="matchContent">';
        if(TE.html[tab][dt]){
            tr += TE.html[tab][dt];
        }else{
            var jsonArr = [];
            for(var k in jsonList){
                jsonArr.push(jsonList[k]);
            }
            jsonArr.sort(by_str("id"));
            $.each(jsonArr,function(k,v){
                if(tab=="zq"||tab=="xj"||tab=="yj"||tab=="fj"||tab=="dj"||tab=="yc" || tab=="wdls"){
                    if(v.had&&v.had.h){
                        v.had.h_ = "胜 "+v.had.h;
                        v.had.d_ = "平 "+v.had.d;
                        v.had.a_ = "负 "+v.had.a;
                    }else{
                        v.had = {};
                        v.had.h_ = "-";
                        v.had.d_ = "-";
                        v.had.a_ = "-";
                    }
                    if(v.hhad&&v.hhad.h){
                        v.hhad.h_ = "胜 "+v.hhad.h;
                        v.hhad.d_ = "平 "+v.hhad.d;
                        v.hhad.a_ = "负 "+v.hhad.a;
                    }else{
                        v.hhad = {};
                        v.hhad.h_ = "-";
                        v.hhad.d_ = "-";
                        v.hhad.a_ = "-";
                    }
                    var danCls = "";
                    var ranDanCls = "";
                    if(v.had.single==1){
                        danCls = "dan";
                    }
                    if(v.hhad.single==1){
                        ranDanCls = "dan";
                    }
                    var cls = "";
                    if(TE.RichMatch[v.l_cn_abbr]){
                        cls = "mainFontColor";
                    }
                    tr += '<div class="item">'+
                        '<div class="name flex flexBetween">'+
                        '<div class="'+cls+'">'+v.h_cn_abbr+'</div>'+
                        '<div>VS</div>'+
                        '<div class="'+cls+'">'+v.a_cn_abbr+'</div>'+
                        '</div>'+
                        '<div class="table flex flexBetween">'+
                        '<div class="leftBox">'+
                        '<div>'+v.num+'</div>'+
                        '<div  class="'+cls+'">'+v.l_cn_abbr+'</div>'+
                        '<div>'+v.match_start_time.substring(11,16)+'截止</div>'+
                        '</div>'+
                        '<table class="rightBox" border="0" cellspacing="0" cellpadding="0">'+
                        '<tr>'+
                        '<td>0</td>'+
                        '<td class="'+danCls+' bodds">'+v.had.h_+'</td>'+
                        '<td class="bodds">'+v.had.d_+'</td>'+
                        '<td class="bodds">'+v.had.a_+'</td>'+
                        '</tr>'+
                        '<tr>'+
                        '<td>'+(v.hhad.fixedodds?v.hhad.fixedodds:'-')+'</td>'+
                        '<td class="bodds '+ranDanCls+'">'+v.hhad.h_+'</td>'+
                        '<td class="bodds">'+v.hhad.d_+'</td>'+
                        '<td class="bodds">'+v.hhad.a_+'</td>'+
                        '</tr>'+
                        '</table>'+
                        '</div>'+
                        '</div>';
                }else{
                    if(v.mnl&&v.mnl.h){
                        v.mnl.h_ = "主胜 "+v.mnl.h;
                        v.mnl.a_ = "主负 "+v.mnl.a;
                    }else{
                        v.mnl = {};
                        v.mnl.h_ = "-";
                        v.mnl.a_ = "-";
                    }
                    if(v.hdc&&v.hdc.h){
                        v.hdc.h_ = "让胜 "+v.hdc.h;
                        v.hdc.a_ = "让负 "+v.hdc.a;
                    }else{
                        v.hdc = {};
                        v.hdc.h_ = "-";
                        v.hdc.a_ = "-";
                    }
                    if(v.hilo&&v.hilo.h){
                        v.hilo.h_ = "大分 "+v.hilo.h;
                        v.hilo.l_ = "小分 "+v.hilo.l;
                    }else{
                        v.hilo = {};
                        v.hilo.h_ = "-";
                        v.hilo.l_ = "-";
                    }
                    var danSfCls = "";
                    var ranDanCls = "";
                    var dxDanCls = "";
                    if(v.mnl.single==1){
                        danSfCls = "dan";
                    }
                    if(v.hdc.single==1){
                        ranDanCls = "dan";
                    }
                    if(v.hilo.single==1){
                        dxDanCls = "dan";
                    }
                    var cls = "";
                    if(TE.RichMatch[v.l_cn_abbr]){
                        cls = "mainFontColor";
                    }
                    tr += '<div class="item">'+
                        '<div class="name flex flexBetween">'+
                        '<div  class="'+cls+'">'+v.a_cn_abbr+'</div>'+
                        '<div>VS</div>'+
                        '<div  class="'+cls+'">'+v.h_cn_abbr+'</div>'+
                        '</div>'+
                        '<div class="table flex flexBetween">'+
                        '<div class="leftBox">'+
                        '<div>'+v.num+'</div>'+
                        '<div  class="'+cls+'">'+v.l_cn_abbr+'</div>'+
                        '<div>'+v.match_start_time.substring(11,16)+'截止</div>'+
                        '</div>'+
                        '<table class="rightBox" border="0" cellspacing="0" cellpadding="0">'+
                        '<tr>'+
                        '<td class="'+danSfCls+'">胜负</td>'+
                        '<td class="bodds">'+v.mnl.a_+'</td>'+
                        '<td class="bodds">'+v.mnl.h_+'</td>'+
                        '</tr>'+
                        '<tr>'+
                        '<td  class="'+ranDanCls+'">让分 <span>'+(v.hdc.fixedodds?"("+v.hdc.fixedodds+")":"")+'</span></td>'+
                        '<td class="bodds">'+v.hdc.a_+'</td>'+
                        '<td class="bodds">'+v.hdc.h_+'</td>'+
                        '</tr>'+
                        '<tr>'+
                        '<td  class="'+dxDanCls+'">总分 <span>'+(v.hilo.fixedodds?"("+v.hilo.fixedodds+")":"")+'</span></td>'+
                        '<td class="bodds">'+v.hilo.h_+'</td>'+
                        '<td class="bodds">'+v.hilo.l_+'</td>'+
                        '</tr>'+
                        '</table>'+
                        '</div>'+
                        '</div>';
                }
            });
            tr += '</div></div>';
            TE.html[tab][dt] = tr;
        }
    }

}

function showMatchImg(k,dt){
    var htmlTxt = TE.html[k][dt];
    let url = 'https://m.lycf888.com'+TE.img[k]
    $("#htmlCanvasPlanDiv .img").attr("src",url);
    var kstr = "zq";
    if(k=="lq"||k=="mzl"){
        kstr = "lq";
    }
    $("#htmlCanvasPlanDiv .todayEventPage .tab"+kstr).html(htmlTxt);
    if(k=="lq"||k=="mzl"){
        $("#htmlCanvasPlanDiv .todayEventPage .tabzq").html("");
    }else{
        $("#htmlCanvasPlanDiv .todayEventPage .tablq").html("");
    }
    $("#qrCode").attr("src",TE.B_info.qrcode);
    var htxt = $("#htmlCanvasPlanDiv").html();
    var col = TE.clolor[k];
    setLocalStorage("bannerHtml",htxt,true);
    setLocalStorage("MatchColor",col,true);
    location.href="eventPoster.html";
}