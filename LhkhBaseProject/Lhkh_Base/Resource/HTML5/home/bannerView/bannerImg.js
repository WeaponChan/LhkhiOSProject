var bannerHtml = getLocalStorage("bannerHtml",true);

if(bannerHtml){
    $("#bannerHtml").html(bannerHtml);
}
document.onreadystatechange = function () {
    if(document.readyState=="complete") {
        if (document.querySelector(".bannerImg").complete){
            htmlCanvasHtml();
        }
    }
}

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
var shareContent = $("#bannerHtml"),//需要截图的包裹的（原生的）DOM 对象
    width = shareContent.clientWidth,//shareContent.offsetWidth; //获取dom 宽度
    height = shareContent.clientHeight,//shareContent.offsetHeight; //获取dom 高度
    canvas = document.createElement("canvas"), //创建一个canvas节点
    scale = 2; //定义任意放大倍数 支持小数
canvas.width = width * scale; //定义canvas 宽度 * 缩放
canvas.height = height * scale; //定义canvas高度 *缩放
canvas.style.width = shareContent.clientWidth * scale + "px";
canvas.style.height = shareContent.clientHeight * scale + "px";
canvas.getContext("2d").scale(scale, scale); //获取context,设置scale
var opts = {
    scale: scale, // 添加的scale 参数
    canvas: canvas, //自定义 canvas
    logging: false, //日志开关，便于查看html2canvas的内部执行流程
    width: width, //dom 原始宽度
    height: height,
    useCORS: true // 【重要】开启跨域配置
};
function htmlCanvasHtml(){
    setTimeout(function(){
        html2canvas(document.querySelector("#bannerHtml"), opts).then(function(canvas) {
            var img_data = canvas.toDataURL("image/png");
            $("#showImgDiv").attr("src",img_data);
            $("#bannerHtml").remove();
            loadImg($("#showImgDiv"),"#showImgDiv");
        });
    },500);
}