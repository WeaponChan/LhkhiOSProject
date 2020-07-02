
var J_Data,B_info,H_list,BG;

//加载海报背景
function L_mt(){
    try{
        $.showLoading("加载中...");
    } catch (e) {

    }
    let data = matchData;
    var businessInfo = data.args.businessInfo;
    B_info = businessInfo;
    var ht_match = data.list;
    H_list = ht_match;
    var serverDate = data.args.date;
    var json = data.args.json;
    var jsdata = getJsonData(json,true);
    var bg = data.args.bg;
    BG = bg;
    J_Data = jsdata;
    if(H_list&&H_list.length>0){
        $("#jdssCount").text(H_list.length);
        F_M();
    }else{
        $(".weui-loadmore").html('<div class="weui-loadmore weui-loadmore_line"> <span class="weui-loadmore__tips">暂无焦点赛事</span> </div>')
    }
    $.hideLoading();
}
var LEN = 0;
function F_M(){
    LEN = H_list.length;
    var hasLis = false;
    for(var k in H_list){
        var m = J_Data["_"+H_list[k].mId];
        if(m){
            var html = getMxHtml(m);
            createSlt(html,m.h_cn_abbr+" VS "+m.a_cn_abbr,H_list[k].mId);
            hasLis = true;
        }
    }
    if(!hasLis){
        $(".weui-loadmore").html('<div class="weui-loadmore weui-loadmore_line"> <span class="weui-loadmore__tips">暂无焦点赛事</span> </div>')
    }
}
var imgDtMap = {
    "1":"https://m.lycf888.com/h5/img/ban/slt_jrdg.jpg?v="+timeToTimestamp(new Date()),
    "2":"https://m.lycf888.com/h5/img/ban/slt_ykdg.jpg?v="+timeToTimestamp(new Date()),
    "3":"https://m.lycf888.com/h5/img/ban/hot_mx.jpg?v="+timeToTimestamp(new Date()),
    "4":"https://m.lycf888.com/h5/img/ban/slt_lqdg.jpg",
    "5":"https://m.lycf888.com/h5/img/ban/slt_lq.jpg?v=123",
    "6":"https://m.lycf888.com/h5/img/ban/slt_lqsc.jpg?v=123"
}
function getMxHtml(m){
    var tr =' <div class="focusPage"><div class="focusPreview">'+
        '<img class="bannerImg" src="https://m.lycf888.com/h5/img/poster/jdss.jpg?v=1312309" />'+
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
    var hasDan = m.had&&m.had.single || m.hhad && m.hhad.single;
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
            tr += ' <td class="zhufu"><span class="font_size_14">胜</span>&nbsp;<em>'+m.had.h+'</em></td>'+
                ' <td><span class="font_size_14">平</span>&nbsp;<em>'+m.had.d+'</em></td>'+
                '<td><span class="font_size_14">负</span>&nbsp;<em>'+m.had.a+'</em></td>';

            if(m.had.single==1){
                tr += '<td class="">单</td>';
            }else{
                tr += '<td class="no_bord_td"></td>';
            }
        }else{
            tr += ' <td class="zhufu"><span class="font_size_14">胜</span>&nbsp;<em>-</em></td>'+
                ' <td><span class="font_size_14">平</span>&nbsp;<em>-</em></td>'+
                '<td><span class="font_size_14">负</span>&nbsp;<em>-</em></td>';
            tr += '<td class="no_bord_td"></td>';
        }
        tr += '</tr></tbody></table>';
        tr += '<table class="table1 '+(m.hhad.single==1?"red_bg":"no_red_bg")+'"" style="margin-top: -4px;"><tbody><tr>'+
            '<td class="yellow_bg2">'+m.hhad.fixedodds+'</td>';
        if(m.hhad){
            tr += '<td class="zhufu"><span class="font_size_14">胜</span>&nbsp;<em>'+m.hhad.h+'</em></td>'+
                '<td><span class="font_size_14">平</span>&nbsp;<em>'+m.hhad.d+'</em></td>'+
                '<td><span class="font_size_14">负</span>&nbsp;<em>'+m.hhad.a+'</em></td>';
            if(m.hhad.single==1){
                tr += '<td class="">单</td>';
            }else{
                tr += '<td class="no_bord_td"></td>';
            }
        }else{
            tr += ' <td class="zhufu"><span class="font_size_14">胜</span>&nbsp;<em>-</em></td>'+
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

//生成图片
var canvas = document.querySelector("canvas");
var ctx = canvas.getContext('2d');
ctx.beginPath();
ctx.arc(75,75,50,0,Math.PI*2,true); // Outer circle
ctx.moveTo(110,75);
ctx.arc(75,75,35,0,Math.PI,false);   // Mouth (clockwise)
ctx.moveTo(65,65);
ctx.arc(60,65,5,0,Math.PI*2,true);  // Left eye
ctx.moveTo(95,65);
ctx.arc(90,65,5,0,Math.PI*2,true);  // Right eye
ctx.stroke();
var IDX = 0;
function createSlt(html,title,mid){
    var tr ='<div class="item" style="background:url(\''+imgDtMap[3]+'\') no-repeat; background-size: 100%;" mid="'+mid+'" onclick="toCreateImg(\''+mid+'\')">'+
        '<div class="footer">'+title+'</div>'+
        '</div>';
    $("#tab1").append(tr);
    $(".weui-loadmore").html('');
}

function toCreateImg(mid){
    var html = getMxHtml(J_Data["_"+mid]);
    setLocalStorage("bannerHtml",html,true);
    location.href="bannerImg.html";
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