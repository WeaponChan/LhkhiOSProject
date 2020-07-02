let thisPageType = getLocalStorage("thisPageType",true);
if(thisPageType&&thisPageType!="null"){
    localStorage.removeItem("thisPageType");
}else{
    thisPageType = 0;
}
let timer = 0;
let J_Data = {},ML_data,B_info,yksDg= {},allData,lqData,lqArr=[];
let BG_data = {};
let jrDate = stringToDate(new Date(),"yyyy-MM-dd");
let IMG_= {};
let BG_={
    "jrdg":"/h5/img/poster/jrdg_.jpg?v="+Date.parse(new Date()),
    "ykdg":"/h5/img/poster/ykdg_.jpg?v="+Date.parse(new Date()),
    "zqplmx":"/h5/img/poster/dgpl.jpg?v="+Date.parse(new Date())
}
let imgDtMap = {
    "1":"/h5/img/ban/slt_jrdg.jpg?v="+timeToTimestamp(new Date()),
    "2":"/h5/img/ban/slt_ykdg.jpg?v="+timeToTimestamp(new Date()),
    "3":"/h5/img/ban/slt_dgmx.jpg?v="+timeToTimestamp(new Date()),
    "4":"/h5/img/ban/slt_lqdg.jpg?v="+timeToTimestamp(new Date()),
    "5":"/h5/img/ban/slt_lq.jpg?v="+timeToTimestamp(new Date()),
    "6":"/h5/img/ban/slt_lqsc.jpg?v="+timeToTimestamp(new Date())
}
let BG_COLOR = {
    "jrdg":"#fe0000",
    "ykdg":"#fe0000",
    "zqplmx":"#2F7D41"
}
$(function(){
    L_bg();
});
let sortAMap = [1,2,3,5,4];
function handleTab(dom, idx) {
    thisPageType = idx;
    $("#tab1").html("");
    $(".weui-loadmore").html("");
    $(dom).addClass("active").siblings(".active").removeClass("active");
    if(idx){
        let img = IMG_[idx];
        console.log('img==',img);
        if(idx==3){
            if(img){
                for(let k in img){
                    let url = 'https://m.lycf888.com/'+img[k].img;
                    let tr = '<div  style="background: url(\''+url+'\') no-repeat; background-size: cover;" class="item" mid="'+img[k].mid+'" type="'+idx+'"  onclick="toCreateImg('+idx+',\''+img[k].mid+'\')">'+
                        /*'<img class="img" src="'+img[k].img+'" />'+*/
                        '<div class="footer">'+img[k].title+'</div>'+
                        '</div>';
                    $("#tab1").append(tr);
                }
            }else{
                $(".weui-loadmore").html('<div class="weui-loadmore weui-loadmore_line"> <span class="weui-loadmore__tips">暂无海报</span> </div>')
            }
        }else if(idx==4){
            if(img){
                for(let k in img){
                    let url = 'https://m.lycf888.com/'+img[k].img;
                    let tr = '<div  style="background: url(\''+url+'\') no-repeat; background-size: cover;" class="item" mid="'+img[k].mid+'" type="'+idx+'"  onclick="toCreateImg('+idx+',\''+img[k].mid+'\')">'+
                        /*'<img class="img" src="'+img[k].img+'" />'+*/
                        '<div class="footer">'+img[k].title+'</div>'+
                        '</div>';
                    $("#tab1").append(tr);
                }
            }else{
                S_LQ(4);
            }
        }else if(idx==5){
            if(img){
                for(let k in img){
                    let url = 'https://m.lycf888.com/'+img[k].img;
                    let tr = '<div  style="background: url(\''+url+'\') no-repeat; background-size: cover;" class="item" mid="'+img[k].mid+'" type="'+idx+'"  onclick="toCreateImg('+idx+',\''+img[k].mid+'\')">'+
                        /*'<img class="img" src="'+img[k].img+'" />'+*/
                        '<div class="footer">'+img[k].title+'</div>'+
                        '</div>';
                    $("#tab1").append(tr);
                }
            }else{
                S_LQ(5);
            }
        }else if(idx==6){
            lqSc(6);
        }else{
            if(img){
                let url = 'https://m.lycf888.com/'+img.img;
                let tr = '<div style="background: url(\''+url+'\') no-repeat; background-size: cover;" class="item" type="'+idx+'" onclick="toCreateImg('+idx+')">'+
                    '<div class="footer">'+img.title+'</div>'+
                    '</div>';
                $("#tab1").append(tr);
            }else{
                $(".weui-loadmore").html('<div class="weui-loadmore weui-loadmore_line"> <span class="weui-loadmore__tips">暂无海报</span> </div>')
            }
        }
    }else{
        let pinT = true;
        if(IMG_&&Object.keys(IMG_).length>0){
            for(let b in sortAMap){
                let a= sortAMap[b];
                if(!IMG_[a]){
                    continue;
                }
                if(a>=3){
                    for(let k in IMG_[a]){
                        let url = 'https://m.lycf888.com/'+IMG_[a][k].img;
                        let tr = '<div class="item" style="background: url(\''+url+'\') no-repeat; background-size: cover;" mid="'+IMG_[a][k].mid+'" type="'+a+'"  onclick="toCreateImg('+a+',\''+IMG_[a][k].mid+'\')">'+
                            /*'<img class="img" src="'+IMG_[a][k].img+'" />'+*/
                            '<div class="footer">'+IMG_[a][k].title+'</div>'+
                            '</div>';
                        $("#tab1").append(tr);
                    }
                }else{
                    let url = 'https://m.lycf888.com/'+IMG_[a].img;
                    let tr = '<div class="item" style="background: url(\''+url+'\') no-repeat; background-size: cover;" type="'+a+'"  onclick="toCreateImg('+a+')">'+
                        '<div class="footer">'+IMG_[a].title+'</div>'+
                        '</div>';
                    $("#tab1").append(tr);
                }
            }
        }else{
            pinT= false;
        }
        if(lqArr&&lqArr.length>0){
            lqSc(6);
        }else{
            if(!pinT){
                $(".weui-loadmore").html('<div class="weui-loadmore weui-loadmore_line"> <span class="weui-loadmore__tips">暂无海报</span> </div>')
            }
        }
    }
    pointIDX();
}

function pointIDX(){
    $("#tab1 .item").each(function(idx){
        let point ='<div class="banner_list_idx"  style="display: block;">'+(parseInt(idx)+1)+'</div>';
        $(this).append(point);
    });
}

function lqSc(type){
    if(lqArr&&lqArr.length>0){
        let url = 'https://m.lycf888.com' + imgDtMap[type];
        let tr = '<div class="item"  style="background: url(\''+url+'/\') no-repeat; background-size: cover;" type="'+type+'" onclick="toCreateImg('+type+')">'+
            '<div class="footer">篮球赛程汇总</div>'+
            '</div>';
        $("#tab1").append(tr);
    }else{
        $("#tab1").html("");
        $(".weui-loadmore").html('<div class="weui-loadmore weui-loadmore_line"> <span class="weui-loadmore__tips">暂无海报</span> </div>')
    }
}
//加载海报背景
function L_bg(){
    try{
        $.showLoading("加载中...");
    } catch (e) {

    }
    let  data = matchData;
    let businessInfo = data.args.businessInfo;
    let bgList = data.args.bgList;
    if(bgList){
        //格式化背景
        formatBg(bgList);
    }
    B_info = businessInfo;
    let serverDate = data.args.date;
    let json = data.args.json;
    let lqJson = data.args.json_bas;
    let jsdata = getDataCount(json);
    lqData = getDataCount(lqJson);
    let ml = data.args.ml;
    if(jsdata){
        for(let nk in jsdata){
            if(jsdata[nk].b_date==jrDate){
                J_Data[nk] = jsdata[nk];
            }else{
                yksDg[nk] = jsdata[nk];
            }
        }
    }
    allData = jsdata;
    ML_data = ml;
    L_NA();
    toggleBody(1);
    S_list();
    if(lqData&&Object.keys(lqData).length>0){
        S_LQ(5);
        S_LQ(4);
    }
    if(lqArr&&lqArr.length>0){
        lqSc(6);
    }

    if(thisPageType&&thisPageType!="null"&&thisPageType!=0){
        handleTab($(".handleTab"+thisPageType),thisPageType);
    }else{
        pointIDX();
    }
    setTimeout(function(){
        timer++;
    }, 2000);
    $.hideLoading();
}

function formatBg(bgList){
    $.each(bgList,function(k,v){
        if(v.type==6){//今日单关
            setBg("1","jrdg",v);
        }else if(v.type==7){//已开单关单关
            setBg("2","ykdg",v);
        }else if(v.type==8){//已开单关单关
            setBg("3","zqplmx",v);
        }
    });
}

function setBg(type,dg,v){
    imgDtMap[type] = v.smallPic;
    BG_[dg] = v.topUrl;
    BG_COLOR[dg] = v.bgColor;
}

var LEN = 0;
function S_list(){
    if(J_Data&&Object.keys(J_Data).length>0){
        F_M(formatJson(J_Data),1,"今日单关汇总",BG_.jrdg);
        LEN++;
    }
    if(yksDg&&Object.keys(yksDg).length>0){
        F_M(formatJson(allData),2,"已开单关汇总",BG_.ykdg);
        LEN++;
    }

    if(allData&&Object.keys(allData).length>0){
        for(var k in allData){
            F_D(allData[k]);
            LEN++;
        }
    }
    if(LEN>0){
        $(".handleTab0 span").text(" "+LEN);
    }
    if(LEN==0){
        $(".weui-loadmore").html('<div class="weui-loadmore weui-loadmore_line"> <span class="weui-loadmore__tips">暂无海报</span> </div>');
    }else{
        sortImg();
    }

}

function S_LQ(type){
    toggleBody(1);
    $(".weui-loadmore").html('<i class="weui-loading"></i><span class="weui-loadmore__tips">正在加载</span>');
    for(var k in lqData){
        F_D_B(lqData[k],type);
        LEN++;
    }
    sortLq(type);
}

function L_NA(){
    var t = false;
    if(J_Data&&Object.keys(J_Data).length>0){
        $("#navTab").append('<div class="item handleTab1" onclick="handleTab(this,1)">今日单关<span style="color:#ff0000;"> 1</span></div>');
        t = true;
    }
    if(yksDg&&Object.keys(yksDg).length>0){
        $("#navTab").append('<div class="item handleTab2" onclick="handleTab(this,2)">已开单关<span style="color:#ff0000;"> 1</span></div>');
        t = true;
    }
    if(t){
        $("#navTab").append('<div class="item handleTab3" onclick="handleTab(this,3)">赔率明细<span style="color:#ff0000;"> '+(Object.keys(J_Data).length+Object.keys(yksDg).length)+'</span></div>');
    }
    if(lqData){
        lqArr = sortLqSc();
        if(lqArr&&lqArr.length>0){
            $("#navTab").append('<div class="item  handleTab5" onclick="handleTab(this,5)">篮球单关<span style="color:#ff0000;">1</span><</div>');
            $("#navTab").append('<div class="item  handleTab4" onclick="handleTab(this,4)">篮球赔率<span style="color:#ff0000;">'+ lqArr.length+'</span><</div>');
            $("#navTab").append('<div class="item  handleTab6" onclick="handleTab(this,6)">篮球赛程<span style="color:#ff0000;">1</span></div>');
        }else{
            $(".weui-loadmore").html('<div class="weui-loadmore weui-loadmore_line"> <span class="weui-loadmore__tips">暂无海报</span> </div>')
        }
    }

}

function formatJson(data){
    var jsDataArr = [];
    for(var kk in data){
        jsDataArr.push(data[kk]);
    }
    jsDataArr.sort(by_str("match_start_time"));
    //var ht = 45;
    //ht = ht+ Object.keys(J_Data).length*25;
    //$(".cont_img").css("height",ht+"%");
    for(var k in jsDataArr){
        var v = jsDataArr[k];
        var oddsArr = {};
        var bonusArr = {};
        var  p = "";
        if(v.had&&v.had.single==1){
            oddsArr.h =dealDecimal(v.had.h);
            oddsArr.d =dealDecimal(v.had.d);
            oddsArr.a =dealDecimal(v.had.a);
            bonusArr.h = parseFloat(1000*v.had.h).toFixed(0);
            bonusArr.d = parseFloat(1000*v.had.d).toFixed(0);
            bonusArr.a = parseFloat(1000*v.had.a).toFixed(0);
        }

        if(v.hhad&&v.hhad.single==1){
            oddsArr.h =dealDecimal(v.hhad.h);
            oddsArr.d =dealDecimal(v.hhad.d);
            oddsArr.a =dealDecimal(v.hhad.a);
            bonusArr.h = parseFloat(1000*v.hhad.h).toFixed(0);
            bonusArr.d = parseFloat(1000*v.hhad.d).toFixed(0);
            bonusArr.a = parseFloat(1000*v.hhad.a).toFixed(0);
            p += "让";
        }

        v.p = p;
        v.oddsArr = oddsArr;
        v.bonusArr = bonusArr;
    }
    return jsDataArr;
}
function getHzHtml(arr,topImg){
    var tr ='<div class="todayPreview" style="display:block;background:'+BG_COLOR.jrdg+'">'+
        '<img class="bannerImg" src="'+topImg+'" />'+
        '<div class="box">';
    for(var k in arr){
        var v = arr[k];
        var mlo = ML_data[v.id];
        if(!mlo){
            mlo = {
                win_per:"",
                draw_per:"",
                lose_per:""
            }
        }
        if(v.p == "让"){
            v.p = v.hhad.fixedodds;
        }
        tr += '<div class="item">'+
            '<div class="title" style="font-family: t-x-m;">'+v.l_cn_abbr+'</div>'+
            '<div class="header flex flexBetween">'+
            '<img class="headerImg" src="https://m.lycf888.com/static/teamlogo/png/'+v.h_id+'.png" onerror="this.onerror=\'\';src=\'https://m.lycf888.com/h5/img/ban/home_1.png\'" alt=""/>'+
            '<div class="textBox">'+
            '<div style="font-family: t-x-m;">'+v.h_cn_abbr+' VS '+v.a_cn_abbr+'</div>'+
            '<div>'+v.num+' '+v.match_start_time.substring(5,16)+'</div>'+
            '</div>'+
            '<img class="headerImg" src="https://m.lycf888.com/static/teamlogo/png/'+v.a_id+'.png" onerror="this.onerror=\'\';src=\'https://m.lycf888.com/h5/img/ban/visiting_1.png\'" alt="" />'+
            '</div>'+
            '<div class="priceBox">'+
            '<div class="item flex flexBetween">'+
            '<div>1000元</div>'+
            '<div>'+v.p+'胜</div>'+
            '<div class="award">奖金'+v.bonusArr.h+'元</div>'+
            '<div class="bugNum flex flexBetween">'+
            '<div style="font-size: 12px;">'+mlo.win_per+'</div>'+
            ' <div>买量</div>'+
            '</div>'+
            '</div>'+
            '<div class="item flex flexBetween">'+
            '<div>1000元</div>'+
            '<div>'+v.p+'平</div>'+
            '<div class="award">奖金'+v.bonusArr.d+'元</div>'+
            '<div class="bugNum flex flexBetween">'+
            '<div style="font-size: 12px;">'+mlo.draw_per+'</div>'+
            '<div>买量</div>'+
            '</div>'+
            '</div>'+
            '<div class="item flex flexBetween">'+
            '<div>1000元</div>'+
            '<div>'+v.p+'负</div>'+
            '<div class="award">奖金'+v.bonusArr.a+'元</div>'+
            '<div class="bugNum flex flexBetween">'+
            '<div style="font-size: 12px;">'+mlo.lose_per+'</div>'+
            '<div>买量</div>'+
            '</div>'+
            '</div>'+
            '</div>'+
            '<div class="footer">*实际奖金以出票为准</div>'+
            '</div>';
    };
    let url = 'https://m.lycf888.com'+ B_info.qrcode;
    tr += '</div><div class="footerBox flex flexBetween">'+
        '<div class="text" style="font-family: t-x-m;">'+
        '<div>公益体彩，责任彩票</div>'+
        '<div>快乐购彩，理性投注</div>'+
        '</div>'+
        '<div class="empty" style="background: url(\''+url+'\');background-size: 100% 100%;"></div>'+
        '</div>'+
        '</div>'+
        '</div>';
    return tr;
}
//汇总表
function F_M(arr,type,title,topImg){
    if(arr){
        createSlt(getHzHtml(arr,topImg),type,title);
    }
}

function sortLqSc(){
    var arr = [];
    var nod = getWeekStrByDate2(new Date());
    for(var k in lqData){
        var m = lqData[k];
        if(m.num.indexOf(nod)==-1){
            continue;
        }
        var obj = {
            m:m,
            sort:m.num.substring(2)
        }
        arr.push(obj);
    }
    if(arr.length>0){
        arr.sort(by_str("sort"));
    }
    return arr;
}

function getLqHzHtml(){
    if(lqArr&&lqArr.length>0){
        var tr ='<div class="focusPreview lq_dg_sc"  style="background:#D92831;display:block;">'+
            '<img class="bannerImg" src="https://m.lycf888.com/h5/img/poster/lqsc.jpg">'+
            '<div class="box">';
        for(var k in  lqArr){
            var m = lqArr[k].m;
            tr += '<div class="item flex flexBetween">'+
                '<div class="left">'+
                '<p>'+m.num+'</p>'+
                '<p>'+m.match_start_time.substring(11,16)+'</p>'+
                '</div>'+
                '<div class="center">'+
                '<div  class="team">'+m.a_cn_abbr+'</div>'+
                '<div>VS</div>'+
                '<div  class="team">'+m.h_cn_abbr+'</div>'+
                '</div>'+
                '<div  class="right flex flexBetween">'+
                '<div   class="odd_li flex flexBetween">'+
                '<div class="pk">'+(m.hdc?m.hdc.fixedodds:"-")+'</div>'+
                '<div class="bt">'+
                '<p>'+(m.hdc?m.hdc.a:"-")+'<span class="bet">负</span></p>'+
                '<p>'+(m.hdc?m.hdc.h:"-")+'<span class="bet">胜</span></p>'+
                '</div>'+
                '</div>'+
                '<div class="odd_li flex flexBetween">'+
                '<div class="pk">'+(m.hilo?m.hilo.fixedodds:"-")+'</div>'+
                '<div class="bt">'+
                '<p>'+(m.hilo?m.hilo.h:"-")+'<span class="bet">大</span></p>'+
                '<p>'+(m.hilo?m.hilo.l:"-")+'<span class="bet">小</span></p>'+
                '</div>'+
                '</div>'+
                '</div>'+
                '</div>';
        }

        tr += '</div><div class="footerBox flex flexBetween">'+
            '<div class="text" style="font-family: t-x-m;">'+
            '<div>公益体彩，责任彩票</div>'+
            '<div>快乐购彩，理性投注</div>'+
            '</div>'+
            '<div class="empty" style="background: url(\''+B_info.qrcode+'\');background-size: 100% 100%;"></div>'+
            '</div>'+
            '</div>'+
            '</div>';
        return tr;
    }
    return '';
}




function getLqLBHtml(m){
    var tr = '<div class="todayPreview"  style="background: #D82931;display:block;">'+
        '<img class="bannerImg" src="https://m.lycf888.com/h5/img/poster/lq.jpg" />'+
        '<div class="lq_team">'+
        '<div class="team_name" style="font-family: t-x-m;">'+m.a_cn_abbr+' VS '+m.h_cn_abbr+'</div>'+
        '<div class="time_time">'+m.num+' '+m.l_cn_abbr+' '+m.match_start_time.substring(5,16)+'</div>'+
        '</div>'+
        '<div class="box">';
    if(m.hdc&&m.hdc.single){
        m.hdc.bonush = parseFloat(1000*m.hdc.h).toFixed(0);
        m.hdc.bonusa = parseFloat(1000*m.hdc.a).toFixed(0);
        tr += '<div class="item">'+
            '<div class="title" style="font-family: t-x-m;">让分 '+m.hdc.fixedodds+'</div>'+
            '<div class="priceBox" style="margin: 5px 15px;">'+
            '<div class="item flex flexBetween">'+
            '<div>1000元</div>'+
            '<div>主胜</div>'+
            '<div class="award">奖金'+m.hdc.bonush+'元</div>'+
            '</div>'+
            '<div class="item flex flexBetween">'+
            '<div>1000元</div>'+
            '<div>主负</div>'+
            '<div class="award">奖金'+m.hdc.bonusa+'元</div>'+
            '</div>'+
            '</div>'+
            '<div class="footer" style="margin-top:inherit;">*实际奖金以出票为准</div>'+
            '</div>';
    }
    if(m.hilo&&m.hilo.single){
        m.hilo.bonush = parseFloat(1000*m.hilo.h).toFixed(0);
        m.hilo.bonusl = parseFloat(1000*m.hilo.l).toFixed(0);
        tr += '<div class="item">'+
            '<div class="title" style="font-family: t-x-m;">大小分 '+m.hilo.fixedodds+'</div>'+
            '<div class="priceBox"  style="margin: 5px 15px;">'+
            '<div class="item flex flexBetween">'+
            '<div>1000元</div>'+
            '<div>大分</div>'+
            '<div class="award">奖金'+m.hilo.bonush+'元</div>'+
            '</div>'+
            '<div class="item flex flexBetween">'+
            '<div>1000元</div>'+
            '<div>小分</div>'+
            '<div class="award">奖金'+m.hilo.bonusl+'元</div>'+
            '</div>'+
            '</div>'+
            '<div class="footer" style="margin-top:inherit;">*实际奖金以出票为准</div>'+
            '</div>'+
            '</div>';
    }
    tr+='<div class="footerBox flex flexBetween">'+
        '<div class="text" style="font-family: t-x-m;">'+
        '<div>公益体彩，责任彩票</div>'+
        '<div>快乐购彩，理性投注</div>'+
        '</div>'+
        '<div class="empty" style="background: url(\''+B_info.qrcode+'\');background-size: 100% 100%;"></div>'+
        '</div>'+
        '</div>';
    return tr;
}

function getMxHtml(m){
    var tr =' <div class="focusPage"><div class="focusPreview" style="background: '+BG_COLOR.zqplmx+';">'+
        '<img class="bannerImg" src="https://m.lycf888.com'+BG_.zqplmx+'" />'+
        '<div class="box">'+
        '<div class="item">'+
        '<div class="title" style="font-family: t-x-m;">'+m.l_cn_abbr+'</div>'+
        '<div class="header flex flexBetween">'+
        '<img class="headerImg"  src="https://m.lycf888.com/static/teamlogo/png/'+m.h_id+'.png" onerror="this.onerror=\'\';src=\'https://m.lycf888.com/h5/img/ban/home_1.png\'" alt=""/>'+
        ' <div class="textBox">'+
        '<div style="font-family: t-x-m;">'+m.h_cn_abbr+' VS '+m.a_cn_abbr+'</div>'+
        '<div>'+m.num+' '+m.match_start_time.substring(5,16)+'</div>'+
        '</div>'+
        '<img class="headerImg" src="https://m.lycf888.com/static/teamlogo/png/'+m.a_id+'.png" onerror="this.onerror=\'\';src=\'https://m.lycf888.com/h5/img/ban/visiting_1.png\'" alt=""/>'+
        '</div>'+
        ' <div class="tableBox">';
    var hasDan = m.had&&m.had.single==1 || m.hhad && m.hhad.single==1;
    if(!hasDan || hasDan==0){
        tr += '<table class="table1 gray_bg">'+
            ' <tbody><tr>'+
            ' <td class="gray_bg2">0</td>';
        if(m.had){
            tr += '<td><span class="font_size_14">胜</span>&nbsp;<em>'+m.had.h+'</em></td>'+
                '<td><span class="font_size_14">平</span>&nbsp;<em>'+m.had.d+'</em></td>'+
                '<td><span class="font_size_14">负</span>&nbsp;<em>'+m.had.a+'</em></td>';
        }else{
            tr += '<td><span class="font_size_14">胜</span>&nbsp;<em>-</em></td>'+
                '<td><span class="font_size_14">平</span>&nbsp;<em>-</em></td>'+
                '<td><span class="font_size_14">负</span>&nbsp;<em>-</em></td>';
        }
        tr += ' <td rowspan="2"><span>非单</span></td></tr><tr>'+
            '<td class="yellow_bg2">'+(m.hhad?m.hhad.fixedodds:"-")+'</td>';

        if(m.hhad){
            tr += '<td><span class="font_size_14">胜</span>&nbsp;<em>'+m.hhad.h+'</em></td>'+
                '<td><span class="font_size_14">平</span>&nbsp;<em>'+m.hhad.d+'</em></td>'+
                '<td><span class="font_size_14">负</span>&nbsp;<em>'+m.hhad.a+'</em></td>';
        }else{
            tr += '<td><span class="font_size_14">胜</span>&nbsp;<em>-</em></td>'+
                '<td><span class="font_size_14">平</span>&nbsp;<em>-</em></td>'+
                '<td><span class="font_size_14">负</span>&nbsp;<em>-</em></td>';
        }

        tr += '</tr></tbody></table>';
    }else{

        tr += '<table class="table1 '+(m.had&&m.had.single==1?"red_bg":"no_red_bg")+'"><tbody><tr> <td class="gray_bg2">0</td>';
        if(m.had){
            tr += ' <td  class="zhufu"><span class="font_size_14">胜</span>&nbsp;<em>'+m.had.h+'</em></td>'+
                ' <td><span class="font_size_14">平</span>&nbsp;<em>'+m.had.d+'</em></td>'+
                '<td><span class="font_size_14">负</span>&nbsp;<em>'+m.had.a+'</em></td>';
            if(m.had.single==1){
                tr += '<td class="">单</td>';
            }else{
                tr += '<td class="no_bord_td"></td>';
            }
        }else{
            tr += ' <td><span class="font_size_14">胜</span>&nbsp;<em>-</em></td>'+
                ' <td><span class="font_size_14">平</span>&nbsp;<em>-</em></td>'+
                '<td><span class="font_size_14">负</span>&nbsp;<em>-</em></td>';
            tr += '<td class="no_bord_td"></td>';
        }
        tr += '</tr></tbody></table>';
        tr += '<table class="table1 '+(m.hhad.single==1?"red_bg":"no_red_bg")+'"" style="margin-top: -4px;"><tbody><tr>'+
            '<td class="yellow_bg2">'+m.hhad.fixedodds+'</td>';
        if(m.hhad){
            tr += '<td  class="zhufu"><span class="font_size_14">胜</span>&nbsp;<em>'+m.hhad.h+'</em></td>'+
                '<td><span class="font_size_14">平</span>&nbsp;<em>'+m.hhad.d+'</em></td>'+
                '<td><span class="font_size_14">负</span>&nbsp;<em>'+m.hhad.a+'</em></td>';
            if(m.hhad.single==1){
                tr += '<td class="">单</td>';
            }else{
                tr += '<td class="no_bord_td"></td>';
            }
        }else{
            tr += ' <td><span class="font_size_14">胜</span>&nbsp;<em>-</em></td>'+
                ' <td><span class="font_size_14">平</span>&nbsp;<em>-</em></td>'+
                '<td><span class="font_size_14">负</span>&nbsp;<em>-</em></td>';
            tr += '<td class="no_bord_td"></td>';
        }
        tr += '</tr></tbody></table>';
    }

    var crs = m.crs;
    if(!crs){
        crs = {};
        crs["0100"] = '-';crs["0100"] = '-';crs["0201"] = '-';
        crs["0300"] = '-';crs["0301"] = '-';crs["0302"] = '-';
        crs["0400"] = '-';crs["0401"] = '-';crs["0402"] = '-';
        crs["0500"] = '-';crs["0501"] = '-';crs["0502"] = '-';
        crs["0000"] = '-';crs["0101"] = '-';crs["0202"] = '-';
        crs["0303"] = '-';crs["0001"] = '-';crs["0002"] = '-';
        crs["0102"] = '-';crs["0003"] = '-';crs["0103"] = '-';
        crs["0203"] = '-';crs["0004"] = '-';crs["0104"] = '-';
        crs["0204"] = '-';crs["0005"] = '-';crs["0105"] = '-';
        crs["0100"] = '-';crs["-1-h"] = '-';crs["-1-d"] = '-';
        crs["-1-a"] = '-';
    }

    tr += '<table class="table2 red_bg">'+
        '<tbody>'+
        '<tr>'+
        '<td class="yellow_bg" rowspan="5">比分</td>'+
        '<td><p class="font_size_14">1:0</p><em>'+crs["0100"]+'</em></td>'+
        '<td><p class="font_size_14">2:0</p><em>'+crs["0200"]+'</em></td>'+
        '<td><p class="font_size_14">2:1</p><em>'+crs["0201"]+'</em></td>'+
        '<td><p class="font_size_14">3:0</p><em>'+crs["0300"]+'</em></td>'+
        '<td><p class="font_size_14">3:1</p><em>'+crs["0301"]+'</em></td>'+
        '<td><p class="font_size_14">3:2</p><em>'+crs["0302"]+'</em></td>'+
        '<td><p class="font_size_14">4:0</p><em>'+crs["0400"]+'</em></td>'+
        '<td rowspan="5"><span>单关</span></td>'+
        '</tr>'+
        '<tr>'+
        '<td>'+
        '<p class="font_size_14">4:1</p><em>'+crs["0401"]+'</em>'+
        '</td>'+
        '<td>'+
        '<p class="font_size_14">4:2</p><em>'+crs["0402"]+'</em>'+
        '</td>'+
        '<td>'+
        '<p class="font_size_14">5:0</p><em>'+crs["0500"]+'</em>'+
        '</td>'+
        '<td>'+
        '<p class="font_size_14">5:1</p><em>'+crs["0501"]+'</em>'+
        '</td>'+
        '<td>'+
        '<p class="font_size_14">5:2</p><em>'+crs["0502"]+'</em>'+
        '</td>'+
        '<td colspan="2">'+
        '<p class="font_size_14">胜其他</p><em>'+crs["-1-h"]+'</em>'+
        '</td>'+
        '</tr>'+
        '<tr>'+
        '<td>'+
        '<p class="font_size_14">0:0</p><em>'+crs["0000"]+'</em>'+
        '</td>'+
        '<td>'+
        '<p class="font_size_14">1:1</p><em>'+crs["0101"]+'</em>'+
        '</td>'+
        '<td>'+
        '<p class="font_size_14">2:2</p><em>'+crs["0202"]+'</em>'+
        '</td>'+
        '<td>'+
        '<p class="font_size_14">3:3</p><em>'+crs["0303"]+'</em>'+
        '</td>'+
        '<td colspan="3">'+
        '<p class="font_size_14">平其他</p><em>'+crs["-1-d"]+'</em>'+
        '</td>'+
        '</tr>'+
        '<tr>'+
        '<td>'+
        '<p class="font_size_14">0:1</p><em>'+crs["0001"]+'</em>'+
        '</td>'+
        '<td>'+
        '<p class="font_size_14">0:2</p><em>'+crs["0002"]+'</em>'+
        '</td>'+
        '<td>'+
        '<p class="font_size_14">1:2</p><em>'+crs["0102"]+'</em>'+
        '</td>'+
        '<td>'+
        '<p class="font_size_14">0:3</p><em>'+crs["0003"]+'</em>'+
        '</td>'+
        '<td>'+
        '<p class="font_size_14">1:3</p><em>'+crs["0103"]+'</em>'+
        '</td>'+
        '<td>'+
        '<p class="font_size_14">2:3</p><em>'+crs["0203"]+'</em>'+
        '</td>'+
        '<td>'+
        '<p class="font_size_14">0:4</p><em>'+crs["0004"]+'</em>'+
        '</td>'+
        '</tr>'+
        '<tr>'+
        '<td>'+
        '<p class="font_size_14">1:4</p><em>'+crs["0104"]+'</em>'+
        '</td>'+
        '<td>'+
        '<p class="font_size_14">2:4</p><em>'+crs["0204"]+'</em>'+
        '</td>'+
        '<td>'+
        '<p class="font_size_14">0:5</p><em>'+crs["0005"]+'</em>'+
        '</td>'+
        '<td>'+
        '<p class="font_size_14">1:5</p><em>'+crs["0105"]+'</em>'+
        '</td>'+
        '<td>'+
        '<p class="font_size_14">2:5</p><em>'+crs["0205"]+'</em>'+
        '</td>'+
        '<td colspan="2">'+
        '<p class="font_size_14">负其他</p><em>'+crs["-1-a"]+'</em>'+
        '</td>'+
        '</tr>'+
        '</tbody>'+
        '</table>'
    var jqs = m.ttg;
    if(!jqs){
        jqs = {};
        jqs.s0 = "-";jqs.s1 = "-";jqs.s2 = "-";
        jqs.s3 = "-";jqs.s4 = "-";jqs.s5 = "-";
        jqs.s6 = "-";jqs.s7 = "-";
    }
    tr += '<table class="table3 red_bg">'+
        '<tbody>'+
        '<tr>'+
        '<td class="purple_bg" rowspan="2">总进球</td>'+
        '<td>'+
        '<p class="font_size_14">0球</p><em>'+jqs.s0+'</em>'+
        '</td>'+
        '<td>'+
        '<p class="font_size_14">1球</p><em>'+jqs.s1+'</em>'+
        '</td>'+
        '<td>'+
        '<p class="font_size_14">2球</p><em>'+jqs.s2+'</em>'+
        '</td>'+
        '<td>'+
        '<p class="font_size_14">3球</p><em>'+jqs.s3+'</em>'+
        '</td>'+
        '<td rowspan="2"><span>单关</span></td>'+
        '</tr>'+
        '<tr>'+
        '<td>'+
        '<p class="font_size_14">4球</p><em>'+jqs.s4+'</em>'+
        '</td>'+
        '<td>'+
        '<p class="font_size_14">5球</p><em>'+jqs.s5+'</em>'+
        '</td>'+
        '<td>'+
        '<p class="font_size_14">6球</p><em>'+jqs.s6+'</em>'+
        '</td>'+
        '<td>'+
        '<p class="font_size_14">7+球</p><em>'+jqs.s7+'</em>'+
        '</td>'+
        '</tr>'+
        '</tbody>'+
        '</table>';
    var hafu = m.hafu;
    if(!hafu){
        hafu = {};
        hafu.hh = "-";hafu.hd = "-";hafu.ha = "-";
        hafu.dh = "-";hafu.dd = "-";hafu.da = "-";
        hafu.ah = "-";hafu.ad = "-";hafu.aa = "-";
    }

    tr += '<table class="table1 red_bg">'+
        '<tbody>'+
        '<tr>'+
        '<td class="purple_bg line_height_less" rowspan="3">半全场</td>'+
        '<td>'+
        '<p class="font_size_14">胜胜</p><em>'+hafu.hh+'</em>'+
        '</td>'+
        '<td>'+
        '<p class="font_size_14">胜平</p><em>'+hafu.hd+'</em>'+
        '</td>'+
        '<td>'+
        '<p class="font_size_14">胜负</p><em>'+hafu.ha+'</em>'+
        '</td>'+
        '<td rowspan="3"><span>单关</span></td>'+
        '</tr>'+
        '<tr>'+
        '<td>'+
        '<p class="font_size_14">平胜</p><em>'+hafu.dh+'</em>'+
        '</td>'+
        '<td>'+
        '<p class="font_size_14">平平</p><em>'+hafu.dd+'</em>'+
        '</td>'+
        '<td>'+
        '<p class="font_size_14">平负</p><em>'+hafu.da+'</em>'+
        '</td>'+
        '</tr>'+
        '<tr>'+
        '<td>'+
        '<p class="font_size_14">负胜</p><em>'+hafu.ah+'</em>'+
        '</td>'+
        '<td>'+
        '<p class="font_size_14">负平</p><em>'+hafu.ad+'</em>'+
        '</td>'+
        '<td>'+
        '<p class="font_size_14">负负</p><em>'+hafu.aa+'</em>'+
        '</td>'+
        '</tr>'+
        '</tbody>'+
        '</table>';
    tr +='</div>'+
        '<div class="footer">*实际奖金以出票为准</div>'+
        '</div>'+
        '</div>'+
        '<div class="footerBox flex flexBetween">'+
        '<div class="text" style="font-family: t-x-m;">'+
        '<div>公益体彩，责任彩票</div>'+
        '<div>快乐购彩，理性投注</div>'+
        '</div>'+
        '<div class="empty"  style="background: url(\''+B_info.qrcode+'\');background-size: 100% 100%;"></div>'+
        '</div>'+
        '</div></div>';
    return tr;
}

//篮球明细
function getBasHtml(m){
    var tr =' <div class="focusPage"><div class="focusPreview" style="background:#A80808">'+
        '<img class="bannerImg" src="https://m.lycf888.com/h5/img/poster/lqdg.jpg" />'+
        '<div class="box">'+
        '<div class="item">'+
        '<div class="title" style="font-family: t-x-m;">'+m.l_cn_abbr+'</div>'+
        '<div class="header flex flexBetween">'+
        '<img class="headerImg"  src="https://m.lycf888.com/static/teamlogo/png/l'+m.a_id+'.png" onerror="this.onerror=\'\';src=\'https://m.lycf888.com/h5/img/ban/visiting_1.png\'" alt=""/>'+
        ' <div class="textBox">'+
        '<div style="font-family: t-x-m;">'+m.a_cn_abbr+' VS '+m.h_cn_abbr+'</div>'+
        '<div>'+m.num+' '+m.match_start_time.substring(5,16)+'</div>'+
        '</div>'+
        '<img class="headerImg" src="https://m.lycf888.com/static/teamlogo/png/l'+m.h_id+'.png" onerror="this.onerror=\'\';src=\'https://m.lycf888.com/h5/img/ban/home_1.png\'" alt=""/>'+
        '</div>'+
        ' <div class="tableBox">';
    if(!((m.mnl&&m.mnl.single) || (m.hdc && m.hdc.single) || (m.hilo && m.hilo.single))){
        tr += '<table class="table0 gray_bg">'+
            '<tbody>'+
            '<tr>'+
            '<td class="yellow_bg line_height_less" rowspan="2">胜负</td>';
        if(m.mnl){
            tr +='<td><span class="font_size_14">主负</span>&nbsp;<em>'+m.mnl.a+'</em></td>'+
                '<td><span class="font_size_14">主胜</span>&nbsp;<em>'+m.mnl.h+'</em></td>';
        }else{
            tr +='<td><span class="font_size_14">主负</span>&nbsp;<em>-</em></td>'+
                '<td><span class="font_size_14">主胜</span>&nbsp;<em>-</em></td>';
        }
        tr+='<td rowspan="2">非单</td>'+
            '</tr>'+
            '<tr>'+
            '<td class="yellow_bg line_height_less" rowspan="2">让分</td>';
        if(m.hdc){
            tr += '<td><span class="font_size_14">主负</span>&nbsp;<em>'+m.hdc.a+'</em></td>'+
                '<td><span class="font_size_14">主胜</span>&nbsp;<em>'+m.hdc.h+'('+m.hdc.fixedodds+')</em></td>'
        }else{
            tr +='<td><span class="font_size_14">主负</span>&nbsp;<em>-</em></td>'+
                '<td><span class="font_size_14">主胜</span>&nbsp;<em>-</em></td>';
        }

        tr += '</tr>'+
            '</tbody>'+
            '</table>';
    }else{
        tr += '<table class="table0 '+(m.mnl&&m.mnl.single==1?"red_bg":"no_red_bg")+'"><tbody><tr><td class="yellow_bg line_height_less" rowspan="2">胜负</td>';
        if(m.mnl){
            tr += '<td class="zhufu"><span class="font_size_14">主负</span>&nbsp;<em>'+m.mnl.a+'</em></td>'+
                '<td><span class="font_size_14">主胜</span>&nbsp;<em>'+m.mnl.h+'</em></td>';
            if(m.mnl.single==1){
                tr += '<td class="">单</td>';
            }else{
                tr += '<td class="no_bord_td"></td>';
            }
        }else{
            tr += '<td class="zhufu"><span class="font_size_14">主负</span>&nbsp;<em>-</em></td>'+
                '<td><span class="font_size_14">主胜</span>&nbsp;<em>-</em></td>';
            tr += '<td class="no_bord_td"></td>';
        }
        tr += '</tr></tbody></table>';
        tr += '<table class="table0  '+(m.hdc&&m.hdc.single==1?"red_bg":"no_red_bg")+'" style="margin-top: -4px;"><tbody><tr><td class="yellow_bg line_height_less" rowspan="2">让分</td>';
        if(m.hdc){
            tr += '<td class="zhufu"><span class="font_size_14">主负</span>&nbsp;<em>'+m.hdc.a+'</em></td>'+
                '<td><span class="font_size_14">主胜</span>&nbsp;<em>'+m.hdc.h+'('+m.hdc.fixedodds+')</em></td>';
            if(m.hdc.single==1){
                tr += '<td class="">单</td>';
            }else{
                tr += '<td class="no_bord_td"></td>';
            }
        }else{
            tr += '<td class="zhufu"><span class="font_size_14">主负</span>&nbsp;<em>-</em></td>'+
                '<td><span class="font_size_14">主胜</span>&nbsp;<em>-</em></td>';
            tr += '<td class="no_bord_td"></td>';
        }

        tr += '</tr></tbody></table>';
    }
    var hilo = m.hilo;
    if(hilo){
        if(hilo.single==1){
            tr += '<table class="table1 red_bg">'+
                ' <tbody>'+
                '<tr>'+
                ' <td class="yellow_bg line_height_less">大小分</td>'+
                '<td><span class="font_size_14">大分</span>&nbsp;<em>'+hilo.h+'</em></td>'+
                '<td><span class="font_size_14"></span>&nbsp;<em>'+hilo.fixedodds+'</em></td>'+
                '<td><span class="font_size_14">小分</span>&nbsp;<em>'+hilo.l+'</em></td>'+
                '<td>单</td>'+
                '</tr>'+
                '</tbody>'+
                '</table>'
        }else{
            tr += '<table class="table1 gray_bg">'+
                ' <tbody>'+
                '<tr>'+
                ' <td class="yellow_bg line_height_less">大小分</td>'+
                '<td><span class="font_size_14">大分</span>&nbsp;<em>'+hilo.h+'</em></td>'+
                '<td><span class="font_size_14"></span>&nbsp;<em>'+hilo.fixedodds+'</em></td>'+
                '<td><span class="font_size_14">小分</span>&nbsp;<em>'+hilo.l+'</em></td>'+
                '<td>非单</td>'+
                '</tr>'+
                '</tbody>'+
                '</table>'
        }
    }

    var sfc = m.wnm;
    if(sfc){
        tr += ' <table class="table3 red_bg">'+
            '<tbody>'+
            '<tr>'+
            '<td class="purple_bg line_height_less" rowspan="3">胜分差</td>'+
            '<td>'+
            '<p class="font_size_14">主胜1-5</p>&nbsp;<em>'+sfc.w1+'</em>'+
            '</td>'+
            '<td>'+
            ' <p class="font_size_14">主胜6-10</p>&nbsp;<em>'+sfc.w2+'</em>'+
            '</td>'+
            '<td>'+
            ' <p class="font_size_14">主胜11-15</p>&nbsp;<em>'+sfc.w3+'</em>'+
            '</td>'+
            '<td>'+
            ' <p class="font_size_14">主胜16-20</p>&nbsp;<em>'+sfc.w4+'</em>'+
            '</td>'+
            '<td rowspan="3">单关</td>'+
            '</tr>'+
            '<tr>'+
            ' <td>'+
            '  <p class="font_size_14">主胜21-25</p>&nbsp;<em>'+sfc.w5+'</em>'+
            '</td>'+
            '<td>'+
            ' <p class="font_size_14">主胜26+</p>&nbsp;<em>'+sfc.w6+'</em>'+
            '</td>'+
            '<td>'+
            ' <p class="font_size_14">客胜1-5</p>&nbsp;<em>'+sfc.l1+'</em>'+
            '</td>'+
            '<td>'+
            ' <p class="font_size_14">客胜6-10</p>&nbsp;<em>'+sfc.l2+'</em>'+
            '</td>'+
            '</tr>'+
            '<tr>'+
            ' <td>'+
            '  <p class="font_size_14">客胜11-15</p>&nbsp;<em>'+sfc.l3+'</em>'+
            '</td>'+
            '<td>'+
            ' <p class="font_size_14">客胜16-20</p>&nbsp;<em>'+sfc.l4+'</em>'+
            '</td>'+
            '<td>'+
            ' <p class="font_size_14">客胜21-25</p>&nbsp;<em>'+sfc.l5+'</em>'+
            '</td>'+
            '<td>'+
            ' <p class="font_size_14">客胜26+</p>&nbsp;<em>'+sfc.l6+'</em>'+
            '</td>'+
            '</tr>'+
            '</tbody>'+
            '</table>';

    }


    tr += '</div>'+
        '<div class="footer">*实际奖金以出票为准</div>'+
        '</div>'+
        '</div>'+
        '<div class="footerBox flex flexBetween">'+
        '<div class="text" style="font-family: t-x-m;">'+
        '<div>公益体彩，责任彩票</div>'+
        '<div>快乐购彩，理性投注</div>'+
        '</div>'+
        '<div class="empty"  style="background: url(\''+B_info.qrcode+'\');background-size: 100% 100%;"></div>'+
        '</div>'+
        '</div></div>';
    return tr;
}

//明细表
function F_D(m){
    createSlt(getMxHtml(m),3,m.h_cn_abbr+"赔率明细",m.id);
}

//明细表
function F_D_B(m,type){
    var title = m.h_cn_abbr+"赔率明细";
    if(type==5){
        title = m.h_cn_abbr+"单关";
    }
    createSlt(getBasHtml(m),type,title,m.id);
}

// 生成图片
/*var canvas = document.querySelector("canvas");
var ctx = canvas.getContext('2d');
ctx.beginPath();
ctx.arc(75,75,50,0,Math.PI*2,true); // Outer circle
ctx.moveTo(110,75);
ctx.arc(75,75,35,0,Math.PI,false);   // Mouth (clockwise)
ctx.moveTo(65,65);
ctx.arc(60,65,5,0,Math.PI*2,true);  // Left eye
ctx.moveTo(95,65);
ctx.arc(90,65,5,0,Math.PI*2,true);  // Right eye
ctx.stroke();*/

var IDX = 0;
function createSlt(html,type,title,mid){
    /*html = '<div id="htmlCanvasDiv_'+type+'_'+mid+'">'+html+'</div>';
    $("#htmlCanvasDiv").append(html);
    setTimeout(function(){
        html2canvas(document.querySelector("#htmlCanvasDiv_"+type+'_'+mid), {canvas: canvas}).then(function(canvas) {
            var img_data = canvas.toDataURL("image/png",0.2);*/
    var img_data = imgDtMap[type];
    if(!IMG_[type]){
        if(type<3){
            IMG_[type] = {};
        }else{
            IMG_[type] = [];
        }
    }
    if(mid){
        var obj = {
            img:img_data,
            title:title,
            mid:mid
        }
        IMG_[type].push(obj);
    }else{
        IMG_[type] = {};
        IMG_[type].img = img_data;
        IMG_[type].title = title;
    }

    /*IDX++;
    if(IDX==LEN){
        if(type<4){
            sortImg();
        }else{
            sortLq();
        }
    }*/
    //});
    //}, 100);
}

function sortImg(){
    //排序赔率明细
    var img3 = IMG_["3"];
    if(img3){
        img3.sort(by_str("mid"));
    }
    $("#htmlCanvasDiv").html('');
    LEN = 0;
    IDX = 0;
    toggleBody(0);

    $(".weui-loadmore").html('');
    for(var k =1;k<=3;k++){
        if(k<3){
            if(IMG_[k]){
                var img_data = 'https://m.lycf888.com/' + IMG_[k].img;
                var title = IMG_[k].title;
                var type = k;
                var mid = IMG_[k].mid;
                var tr = '<div class="item"  style="background: url(\''+img_data+'\') no-repeat; background-size: cover;" mid="'+mid+'" type="'+type+'" onclick="toCreateImg('+type+',\''+mid+'\')">'+
                    '<div class="footer">'+title+'</div>'+
                    '</div>';
                $("#tab1").append(tr);
            }
        }else{
            var arr = IMG_[k];
            for(var kk in arr){
                var img_data = 'https://m.lycf888.com/' + arr[kk].img;
                var title = arr[kk].title;
                var type = k;
                var mid = arr[kk].mid;
                var tr = '<div class="item"  style="background: url(\''+img_data+'\') no-repeat; background-size: cover;" mid="'+mid+'" type="'+type+'" onclick="toCreateImg('+type+',\''+mid+'\')">'+
                    '<div class="footer">'+title+'</div>'+
                    '</div>';
                $("#tab1").append(tr);
            }
        }
    }
}


function sortLq(type){
    var img4 = IMG_[type];
    if(img4){
        img4.sort(by_str("mid"));
    }
    $("#htmlCanvasDiv").html('');
    LEN = 0;
    IDX = 0;
    toggleBody(0);
    $(".weui-loadmore").html('');
    for(var kk in img4){
        var img_data = 'https://m.lycf888.com/' + img4[kk].img;
        var title = img4[kk].title;
        var mid = img4[kk].mid;
        var tr = '<div class="item"  style="background: url(\''+img_data+'\') no-repeat; background-size: cover;" mid="'+mid+'" type="'+type+'" onclick="toCreateImg('+type+',\''+mid+'\')">'+
            '<div class="footer">'+title+'</div>'+
            '</div>';
        $("#tab1").append(tr);
    }

}


function toCreateImg(type,mid){
    var html;
    try {
        if(type==1){
            var dt = formatJson(J_Data);
            html = getHzHtml(dt,"https://m.lycf888.com/h5/img/poster/jrdg.jpg?v="+timeToTimestamp(new Date()));
        }else if(type==2){
            var dt = formatJson(allData);
            html = getHzHtml(dt,"https://m.lycf888.com/h5/img/poster/ykdg.jpg?v="+timeToTimestamp(new Date()));
        }else if(type==3){
            html = getMxHtml(allData["_"+mid]);
        }else if(type==4){
            html = getBasHtml(lqData["_"+mid]);
        }else if(type==5){
            html = getLqLBHtml(lqData["_"+mid]);
        }else{
            html = getLqHzHtml();
        }
        if(html.length>0){
            setLocalStorage("thisPageType",thisPageType,true);
            // img_data（base64转化后的图片）存储在localstorage
            if(localStorage.getItem('bannerHtml')){
                localStorage.removeItem("bannerHtml");
            }
            if(localStorage.getItem('img_data')){
                localStorage.removeItem("img_data");
            }
            setLocalStorage("bannerHtml",html,true);
            location.href="bannerImg.html";
        }
    } catch (e) {
        alert("图片过长，您的手机内存不足");
    }
}

function toggleBody(isPin){
    var u = navigator.userAgent;
    var isAndroid = u.indexOf('Android') > -1 || u.indexOf('Adr') > -1; //android终端
    var isiOS = !!u.match(/\(i[^;]+;( U;)? CPU.+Mac OS X/);
    if(isPin){
        if(isiOS){
            document.body.addEventListener('touchmove',bodyScroll,false);
        }
        $("body").css({'position':'fixed',"width":"100%"});
    }else{
        if(isiOS){
            document.body.removeEventListener('touchmove',bodyScroll,false);
        }
        $("body").css({"position":"initial"});
    }

}
function bodyScroll(event){
    event.preventDefault();
}

//点击查看更多
$(function(){
    $(".cycle_btn_a .cycle_btn_a_center").on("click",function(){
        if($(".cycle_btn_a .cycle_btn_a_other").hasClass("noshow")){
            $(".cycle_btn_a .cycle_btn_a_other").fadeIn(200);
            $(".cycle_btn_a .cycle_btn_a_other").removeClass("noshow");
        }else{
            $(".cycle_btn_a .cycle_btn_a_other").fadeOut(200);
            $(".cycle_btn_a .cycle_btn_a_other").addClass("noshow");
        }
    });

    $("body").on("click",function(e){
        let target = $(e.target);
        if(target.closest($(".cycle_div")).length==0&&!$(".cycle_btn_a .cycle_btn_a_other").hasClass("noshow")){
            $(".cycle_btn_a .cycle_btn_a_other").fadeOut(200);
            $(".cycle_btn_a .cycle_btn_a_other").addClass("noshow");
        }
    });

});
