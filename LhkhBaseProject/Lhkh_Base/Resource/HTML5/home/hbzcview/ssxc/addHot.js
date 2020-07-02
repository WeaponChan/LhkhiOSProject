var J_Data,B_info,BG,D_data,lq_Data,L_Data;
var chooseMid;
var CT = "zq";
$(function(){
    L_mt();

    $(".footerBtn").on("click",function(){
        if(!chooseMid){
            $.toast("请选择一场赛事","forbidden");
            return;
        }
        toCreateImg(chooseMid);
    });

    $(".order_nav_dg .weui-flex__item").on("click",function(){
        var vl = $(this).attr("vl");
        $(".order_nav_dg .weui-flex__item").removeClass("checked");
        $(this).addClass("checked");
        chooseMid = null;
        CT = vl;
        F_M();
    });
});

//加载海报背景
function L_mt(){
    try{
        $.showLoading("加载中...");
    } catch (e) {

    }
    let data = matchHotData;
    var businessInfo = data.args.businessInfo;
    B_info = businessInfo;
    var ht_match = data.list;
    var serverDate = data.args.date;
    var json = data.args.json;
    var jsonLq = data.args.jsonLq;
    var jsdata = getJsonData(json,true);
    var jsdataLq = getJsonData(jsonLq,true);
    var bg = data.args.bg;
    BG = bg;
    J_Data = jsdata;
    lq_Data = jsdataLq;
    format();
    formatLq();
    F_M();
    $.hideLoading();
}
function format(){
    var dataArr = {};
    if(J_Data){
        var nowTime=new Date().getTime();
        for(var k in J_Data){
            var m = J_Data[k];
            if(m.bookEndTimeLong<nowTime){//截止
                delete J_Data[k];
                continue;
            }
            var key = m.b_date+" "+m.num.substring(0,2)+"[12:00-次日12:00]";
            if(!dataArr[key]){
                dataArr[key] = [];
            }
            dataArr[key].push(m);
        }
    }
    D_data = [];
    for(var hk in dataArr){
        var obj = dataArr[hk];
        var gobj = {
            "key":hk,
            "data":obj
        }
        D_data.push(gobj);
    }
    D_data.sort(by_str("key"));
}

function formatLq(){
    var dataArr = {};
    if(lq_Data){
        var nowTime=new Date().getTime();
        for(var k in lq_Data){
            var m = lq_Data[k];
            if(m.bookEndTimeLong<nowTime){//截止
                delete lq_Data[k];
                continue;
            }
            var key = m.b_date+" "+m.num.substring(0,2)+"[12:00-次日12:00]";
            if(!dataArr[key]){
                dataArr[key] = [];
            }
            dataArr[key].push(m);
        }
    }
    L_Data = [];
    for(var hk in dataArr){
        var obj = dataArr[hk];
        var gobj = {
            "key":hk,
            "data":obj
        }
        L_Data.push(gobj);
    }
    L_Data.sort(by_str("key"));
}
function F_M(){
    $(".content").html("");
    if(CT=="zq"){
        if(D_data){
            var idx = 0;
            for(var key in D_data){
                var dm = D_data[key].data;
                var k =  D_data[key].key;
                dm.sort(by_str("num"));
                var cls = "";
                if(idx==0){
                    cls = "active";
                }
                var tr = '<div class="box '+cls+'">'+
                    '<div class="total flex flexBetween">'+
                    '<div class="left flex flexStart">'+
                    ' <div>'+k+' </div>'+
                    '<div>共'+dm.length+'场比赛</div>'+
                    '</div>'+
                    '<div class="right">'+
                    '<div class="top"></div>'+
                    '<div class="bottom"></div>'+
                    '</div>'+
                    '</div>'+
                    '<div class="scheme">';
                for(var kk in dm){
                    var m = dm[kk];
                    tr += '<div class="item flex flexBetween" mid="'+m.id+'">'+
                        '<div>'+m.num+'</div>'+
                        '<div>'+m.h_cn_abbr+'</div>'+
                        '<div>VS</div>'+
                        '<div>'+m.a_cn_abbr+'</div>'+
                        ' </div>';
                }
                tr += '</div></div>';
                $(".content").append(tr);
                idx++;
            }
        }

    }else{
        if(L_Data){
            var idx = 0;
            for(var key in L_Data){
                var dm = L_Data[key].data;
                var k =  L_Data[key].key;
                dm.sort(by_str("num"));
                var cls = "";
                if(idx==0){
                    cls = "active";
                }
                var tr = '<div class="box '+cls+'">'+
                    '<div class="total flex flexBetween">'+
                    '<div class="left flex flexStart">'+
                    ' <div>'+k+' </div>'+
                    '<div>共'+dm.length+'场比赛</div>'+
                    '</div>'+
                    '<div class="right">'+
                    '<div class="top"></div>'+
                    '<div class="bottom"></div>'+
                    '</div>'+
                    '</div>'+
                    '<div class="scheme">';
                for(var kk in dm){
                    var m = dm[kk];
                    tr += '<div class="item flex flexBetween" mid="'+m.id+'">'+
                        '<div>'+m.num+'</div>'+
                        '<div>'+m.h_cn_abbr+'</div>'+
                        '<div>VS</div>'+
                        '<div>'+m.a_cn_abbr+'</div>'+
                        ' </div>';
                }
                tr += '</div></div>';
                $(".content").append(tr);
                idx++;
            }
        }
    }
    $('.total').click(function () {
        var dom = $(this).parent();
        if (dom.hasClass('active')) {
            dom.removeClass('active')
        } else {
            dom.addClass('active')
        }
    });
    $('.scheme .item').click(function () {
        $('.scheme .item').removeClass("active");
        $(this).addClass("active");
        var mid = $(this).attr("mid");
        chooseMid = mid;
    });
}

function getMxHtml(m){
    var tr =' <div class="focusPage"><div class="focusPreview">'+
        '<img class="bannerImg" src="/h5/img/poster/jdss.jpg?v=1312309" />'+
        '<div class="box">'+
        '<div class="item">'+
        '<div class="title" style="font-family: t-x-m;">'+m.l_cn_abbr+'</div>'+
        '<div class="header flex flexBetween">'+
        '<img class="headerImg"  src="/static/teamlogo/png/'+m.h_id+'.png" onerror="this.onerror=\'\';src=\'/h5/img/ban/home_1.png\'" alt=""/>'+
        ' <div class="textBox">'+
        '<div style="font-family: t-x-m;">'+m.h_cn_abbr+' VS '+m.a_cn_abbr+'</div>'+
        '<div>'+m.num+' '+m.match_start_time.substring(5,16)+'</div>'+
        '</div>'+
        '<img class="headerImg" src="/static/teamlogo/png/'+m.a_id+'.png" onerror="this.onerror=\'\';src=\'/h5/img/ban/visiting_1.png\'" alt=""/>'+
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

//篮球明细
function getBasHtml(m){
    var tr =' <div class="focusPage"><div class="focusPreview" style="background:#A80808">'+
        '<img class="bannerImg" src="/h5/img/poster/lqmx.jpg" />'+
        '<div class="box">'+
        '<div class="item">'+
        '<div class="title" style="font-family: t-x-m;">'+m.l_cn_abbr+'</div>'+
        '<div class="header flex flexBetween">'+
        '<img class="headerImg"  src="/static/teamlogo/png/l'+m.a_id+'.png" onerror="this.onerror=\'\';src=\'/h5/img/ban/visiting_1.png\'" alt=""/>'+
        ' <div class="textBox">'+
        '<div style="font-family: t-x-m;">'+m.a_cn_abbr+' VS '+m.h_cn_abbr+'</div>'+
        '<div>'+m.num+' '+m.match_start_time.substring(5,16)+'</div>'+
        '</div>'+
        '<img class="headerImg" src="/static/teamlogo/png/l'+m.h_id+'.png" onerror="this.onerror=\'\';src=\'/h5/img/ban/home_1.png\'" alt=""/>'+
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

function toCreateImg(mid){
    var html = "";
    if(CT == "zq"){
        html =  getMxHtml(J_Data["_"+mid]);
    }else{
        html = getBasHtml(lq_Data["_"+mid]);
    }

    setLocalStorage("bannerHtml",html,true);
    location.href="bannerImg.html";
}