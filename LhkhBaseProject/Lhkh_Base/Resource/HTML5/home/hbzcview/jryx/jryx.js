let thisPageType = getLocalStorage("thisPageType",true);
if(thisPageType&&thisPageType!="null"){
    localStorage.removeItem("thisPageType");
}else{
    thisPageType = 0;
}

let P = 1,S=50,contentType=thisPageType;
let bannerMap = {};
let loading = true;
//加载更多
$(function(){
    try {
        setDsCount();
        //滚动加载更多
        $(document.body).infinite().on("infinite",function() {
            if(loading||contentType==-1) return;
            loading = true;
            setTimeout(function() {
                loadBanner("append");
                loading = false;
            }, 1000);   //模拟延迟
        });
        $(".handleTab"+contentType).addClass("active").siblings(".active").removeClass("active");
        loadBanner();
    } catch (e) {
        alert(e);
    }
});

//点击左边的Tab
function handleTab(dom, idx) {
    $(dom).addClass("active").siblings(".active").removeClass("active");
    if(contentType!=idx){
        contentType = idx;
        P  = 1;
        $("#tab1").html("");
        $(".weui-loadmore").html('<i class="weui-loading"></i><span class="weui-loadmore__tips">正在加载</span>');
        loading = true;
        $(document.body).infinite();
        loadBanner();
    }
}
let codeImg = null;
function loadBanner(C){
    C = C || "append"
    let data = null;
    if (contentType==0){
        data = bannerAllData;
    }else if (contentType==1){
        data = bannerNewsData;
    }else if (contentType==8){
        data = bannerHotsData;
    }else if (contentType==9){
        data = bannerJCAdData;
    }else if (contentType==6){
        data = bannerAnalyzeData;
    }else {
        data = bannerTCData;
    }
    let list = data.list
    console.log('list--->',list);
    if(P==1){
        codeImg = data.args.code;
    }
    if(list!=null && list.length>0){
        let bn ='';
        $.each(list,function(k,v){
            bannerMap[v.id] = v;
            let ind = parseInt(k)+1+(P-1)*S;
            let lpoint = "";
            if(v.contentType==6&&v.qrcodeUrl&&v.qrcodeUrl.indexOf("isMf=1")!=-1){
                lpoint='<div class="banner_mf">免</div>';
            }
            let  url = 'https://m.lycf888.com'+(v.sltUrl?v.sltUrl:v.bannerUrl);
            bn += '<div class="item"  style="background: url(\''+url+'\') no-repeat; background-size: 100%;" onclick="showImg(\''+v.id+'\','+k+')">'+
                '<div class="footer">'+v.name+'</div>'+lpoint+
                '</div>';

        });
        $("#tab1")[C](bn);
        //drawImg(k,list);
        if(list.length==S){
            //滚动加载更多
            P++;
        }else{
            $(document.body).destroyInfinite();
            $(".weui-loadmore").html('<div class="weui-loadmore weui-loadmore_line"> <span class="weui-loadmore__tips">暂无更多海报</span> </div>')
        }
    }else{
        //没有数据时
        $(document.body).destroyInfinite();
        $(".weui-loadmore").html('<div class="weui-loadmore weui-loadmore_line"> <span class="weui-loadmore__tips">暂无海报</span> </div>');
    }
    loading = false;
}


function  setDsCount(){
    let data = bannerCount;
    let list = data.list;
    if(list && list.length>0){
        let total = 0;
        $.each(list,function(k,v){
            console.log('k==',k)
            console.log('v==',v)
            $(".handleTab"+v.contentType).find("span").text(""+v.bannerCount);
            total+= parseInt(v.bannerCount);
        });
        $(".handleTab0").find("span").text(" "+total);
    }
}

function showImg(id,idx,fx){
    let bs64 = new Base64();
    let lt = getLocalStorage("bannerMap",true);
    if(lt){
        localStorage.removeItem("bannerMap");
    }
    bannerMap[id].codeImg = codeImg;
    setLocalStorage("thisPageType",thisPageType,true);
    setLocalStorage("bannerMap",bs64.encode(JSON.stringify(bannerMap[id])),true);
    location.href="bannerShow.html";

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
