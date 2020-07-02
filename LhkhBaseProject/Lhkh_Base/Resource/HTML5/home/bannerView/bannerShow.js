let bs64 = new Base64();
let paramMap = getLocalStorage("bannerMap",true);;
paramMap = eval('(' + bs64.decode(paramMap)+')');
function loadImg1(aa,obj){
    //下面是获取当前页面所有的img的src 转成数组 并且 转换成json格式
    let i=0;
    let src=[];
    let json=null;
    for (i=0;i<aa.length;i++){
        src[i]=aa[i].src;//把所有的src存到数组里
    }
    //var srcList=arrayToJson(src); //转换成json并赋值给srcList
    //下面是点击图片的时候获取当前第几个图片并且启用咱们做的调用微信图片浏览器的函数
    $(obj).unbind("click").on("click",function(){
        let index = $(this).attr("idx");
        imagePreview(src[index],src);
    });
};

$(function(){
    showImg();

    $("body").on("touchstart", "#share", function() {
        $.toast("长按图片发送","text");
    });

    $("#saveGg").on("click",function(){
        $("#editDialog").fadeOut(200);
    })

    if(paramMap.summary){
        $("#ggText").text(paramMap.summary);
    }else{
        $("#ggText").text("很抱歉~此海报暂时还没有文案");
    }
    if(paramMap.summary){
        $("#fpyq").after('<span class="red-point"></span>');
        let clipboard = new ClipboardJS('#fzGg');
        clipboard.on('success', function(e) {
            $.toast("复制成功","success");
            e.clearSelection();
        });
        clipboard.on('error', function(e) {
            alert("复制失败!");
        });
    }
});


function toBack(){
    $("#editDialog").fadeIn(200);
}

//定义方法
function canvasToImage(canvas) {
    let image = new Image();
    // 指定格式 PNG 图片后缀可自定义
    image.src = canvas.toDataURL("image/png");
    image.style = "height:100%";
    return image;
}
let  isSix = 0;
function showImg(){
    if(paramMap.contentType==6&&paramMap.qrcodeUrl){
        let qrcode = new QRCode("qrcode");
        if(paramMap.qrcodeUrl.indexOf("?")==-1){
            paramMap.qrcodeUrl = paramMap.qrcodeUrl+"?shop_id="+'222';
        }else{
            paramMap.qrcodeUrl = paramMap.qrcodeUrl.split("?")[0]+"?shop_id="+'222'+"&"+paramMap.qrcodeUrl.split("?")[1];
        }
        qrcode.makeCode(paramMap.qrcodeUrl);
        let mycanvas1=document.getElementsByTagName('canvas')[1];
        let img=canvasToImage(mycanvas1);
        paramMap.codeImg = img.src;
        isSix = 1;
    }
    let type = paramMap.type;
    if(type==2){
        $("#widthImgDiv").find(".header").addClass("margintop");
    }else{
        $("#widthImgDiv").find(".header").removeClass("margintop");
    }
    if($("#widthImgDiv").is(":hidden")){
        $("#widthImgDiv").show();
        $("#bannerDiv").hide();
    }
    $("#showImgDiv").attr("src","");
    // if(paramMap.isAddQrcode==1){
    //     $.showLoading("合成中...");
    //     if(paramMap.contentType==6&&paramMap.qrcodeUrl){
    //         setTimeout(function(){
    //             drawImg();
    //         }, 1000);
    //     }else{
    //         drawImg();
    //     }
    // }else{
    //     showIG();
    // }
    showIG();

}
function showIG(){
    let url = 'https://m.lycf888.com'+paramMap.bannerUrl;
    console.log('url-->',url);
    $("#showImgDiv").attr("src",url);
    $.hideLoading();

    function isAndroid() {
        return false;
    }

    if(isAndroid()){
        loadImg($("#showImgDiv"),"#showImgDiv");
    }
}
//预加载将图片绘制到画布
let bgImg  = new Image();
let codeImg  = new Image();
let drawImg = function(){
    bgImg.src = 'https://m.lycf888.com'+paramMap.bannerUrl;
    bgImg.setAttribute("crossOrigin",'anonymous');
    console.log('bgImg-->',bgImg);
    //获取画布对象
    let ctx = document.getElementById("mainCanvas");

    // polyfill 提供了这个方法用来获取设备的 pixel ratio
    let getPixelRatio = function(context) {
        let backingStore = context.backingStorePixelRatio
            || context.webkitBackingStorePixelRatio
            || context.mozBackingStorePixelRatio
            || context.msBackingStorePixelRatio
            || context.oBackingStorePixelRatio
            || context.backingStorePixelRatio || 1;
        return (window.devicePixelRatio || 1) / backingStore;
    };
    let ratio = getPixelRatio(ctx);
    ratio = 1;
    try{
        bgImg.onload = function(){
            ctx.height = bgImg.height*ratio;
            ctx.width = bgImg.width*ratio;
            let mainCtx = ctx.getContext("2d");
            //设定大矩形的高度
            let maxWidth = mainCtx.width*ratio;
            let maxHeight = mainCtx.height*ratio;

            mainCtx.clearRect(0,0,bgImg.width*ratio,bgImg.height*ratio);
            //先把图片绘制在这里
            mainCtx.drawImage(bgImg,0,0,bgImg.width*ratio,bgImg.height*ratio);
            //绘制二维码
            codeImg.src = paramMap.codeImg;
            if(!isSix){
                codeImg.onload = function(){
                    mainCtx.drawImage(codeImg,paramMap.coordinateX*ratio,paramMap.coordinateY*ratio,paramMap.width*ratio,paramMap.height*ratio);
                    mainCtx.closePath();
                    mainCtx.stroke();

                    let mycanvas = document.getElementById("mainCanvas");
                    let image = mycanvas.toDataURL("image/jpg");
                    paramMap.bannerUrl = image;
                    //$(".img-banner"+k).attr("src",image);
                    showIG();
                }
            }else{
                if(document.readyState=="complete") {
                    if (codeImg.complete){
                        mainCtx.drawImage(codeImg,paramMap.coordinateX*ratio,paramMap.coordinateY*ratio,paramMap.width*ratio,paramMap.height*ratio);
                        mainCtx.closePath();
                        mainCtx.stroke();

                        let mycanvas = document.getElementById("mainCanvas");
                        let image = mycanvas.toDataURL("image/jpg");
                        paramMap.bannerUrl = image;
                        //$(".img-banner"+k).attr("src",image);
                        showIG();
                    }
                }
            }
        }
    }catch(e){
        alert(e)
    }
}