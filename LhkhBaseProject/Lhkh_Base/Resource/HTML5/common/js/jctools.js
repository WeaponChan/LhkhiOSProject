

var paramsMap = {
    'lotteryEnMap':{'51':'竞足胜平负','52':'竞足比分','53':'竞足总进球','54':'竞足半全场','56':'竞足让球胜平负','59':'竞足混合投注','61':'竞篮让分胜负','62':'竞篮胜负','64':'竞篮大小分','63':'竞篮胜分差','69':'竞篮混合投注',"200":"北单胜平负","210":"北单上下单双","230":"北单总进球数","240":"北单半全场","250":"北单比分","270":"北单胜负过关","389":"大乐透","428":"排列三"},
    'hafu':{'hh':'胜胜','hd':'胜平','ha':'胜负','dh':'平胜','dd':'平平','da':'平负','ah':'负胜','ad':'负平','aa':'负负',"-1:-1":"取消"},
    'had':{'h':'胜','d':'平','a':'负',"-1:-1":"取消"},
    'hhad':{'h':'让胜','d':'让平','a':'让负',"-1:-1":"取消"},
    'ttg':{"s0":'0球',"s1":'1球',"s2":'2球',"s3":'3球',"s4":'4球',"s5":'5球',"s6":'6球',"s7":'7+球',"-1:-1":"取消"},
    'crs':{"0000":"0:0","0001":"0:1","0002":"0:2","0003":"0:3","0004":"0:4","0005":"0:5",
        "0100":"1:0","0101":"1:1","0102":"1:2","0103":"1:3","0104":"1:4","0105":"1:5",
        "0200":"2:0","0201":"2:1","0202":"2:2","0203":"2:3","0204"	:"2:4","0205":"2:5",
        "0300":"3:0","0301":"3:1","0302":"3:2","0303":"3:3",
        "0400":"4:0","0401":"4:1","0402":"4:2","0500":"5:0",
        "0501":"5:1","0502":"5:2","-1-a":"负其它","-1-d":"平其它","-1-h":"胜其它","-1:-1":"取消"},
    'mnl':{'h':"主胜",'a':"主负","-1:-1":"取消"},
    'hdc':{'h':"主让胜",'a':"主让负","-1:-1":"取消"},
    'hilo':{'h':"大分",'l':'小分',"-1:-1":"取消"},
    'wnm':{"w1":"主胜1-5","w2":"主胜6-10","w3":"主胜11-15","w4":"主胜16-20","w5":"主胜21-25"
        ,"w6":"主胜26+","l1":"主负1-5","l2":"主负6-10","l3":"主负11-15","l4":"主负16-20","l5":"主负21-25","l6":"主负26+","-1:-1":"取消"},
    'mnlAttr':{'主胜':'h',"主负":'a'},
    'hdcAttr':{'主让胜':'h',"主让负":'a'},
    'hiloAttr':{'大分':'h',"小分":'l'},
    'wnmAttr':{'主胜1-5':'w1','主胜6-10':'w2','主胜11-15':'w3','主胜16-20':'w4','主胜21-25':'w5','主胜26+':'w6',
        '主负1-5':'l1','主负6-10':'l2','主负11-15':'l3','主负16-20':'l4','主负21-25':'l5','主负26+':'l6'},
    '200':{'3':'胜','1':'平','0':'负'},
    '250':{"0000":"0:0","0001":"0:1","0002":"0:2","0003":"0:3","0004":"0:4",
        "0100":"1:0","0101":"1:1","0102":"1:2","0103":"1:3","0104":"1:4",
        "0200":"2:0","0201":"2:1","0202":"2:2","0203":"2:3","0204"	:"2:4",
        "0300":"3:0","0301":"3:1","0302":"3:2","0303":"3:3",
        "0400":"4:0","0401":"4:1","0402":"4:2","-1-a":"负其它","-1-d":"平其它","-1-h":"胜其它"},
    '240':{'33':'胜胜','31':'胜平','30':'胜负','13':'平胜','11':'平平','10':'平负','03':'负胜','01':'负平','00':'负负'},
    '230':{"s0":'0球',"s1":'1球',"s2":'2球',"s3":'3球',"s4":'4球',"s5":'5球',"s6":'6球',"s7":'7+球'},
    '210':{"1":'上单',"2":'上双',"3":'下单',"4":'下双'},
    "270":{"3":"胜","0":"负"},
    "bdEnMap":{
        "71":"胜平负",
        "72":"单场比分",
        "73":"半全场胜平负",
        "74":"总进球数",
        "75":"上下盘单双数",
        "200":"胜平负",
        "210":"上下盘单双数",
        "230":"总进球数",
        "240":"半全场胜平负",
        "250":"单场比分"
    },
    "bdCnMap":{
        "200":"71",
        "210":"75",
        "230":"74",
        "240":"73",
        "250":"72",
        "270":"76"
    }
}

var betParamMap={
    "lotteryId":{"51":"had","52":"crs","53":"ttg","54":"hafu","56":"hhad","59":"ht","61":"hdc","62":"mnl","63":"wnm","64":"hilo","69":"hhgg"},
    "lotteryType":{"nspf":"had","spf":"hhad","jqs":"ttg","bqc":"hafu","bf":"crs","sf":"mnl","rfsf":"hdc","sfc":"wnm","dxf":"hilo"},
    'hafu':{'hh':'86','hd':'85','ha':'84','dh':'83','dd':'82','da':'81','ah':'80','ad':'79','aa':'78'},
    'had':{'h':'100','d':'99','a':'98'},
    'hhad':{'h':'97','d':'96','a':'95'},
    'ttg':{"s0":'94',"s1":'93',"s2":'92',"s3":'91',"s4":'90',"s5":'89',"s6":'88',"s7":'87'},
    'crs':{"0000":"77","0001":"76","0002":"75","0003":"74","0004":"73","0005":"72",
        "0100":"71","0101":"70","0102":"69","0103":"68","0104":"67","0105":"66",
        "0200":"65","0201":"64","0202":"63","0203":"62","0204"	:"61","0205":"60",
        "0300":"59","0301":"58","0302":"57","0303":"56",
        "0400":"55","0401":"54","0402":"53","0500":"52",
        "0501":"51","0502":"50","-1-a":"47","-1-d":"48","-1-h":"49"},
    'mnl':{
        'h':'50','a':'49'
    },
    'hdc':{
        'h':'48','a':'47'
    },
    'wnm':{
        'w1':'46','w2':'45','w3':'44','w4':'43','w5':'42','w6':'41',
        'l1':'40','l2':'39','l3':'38','l4':'37','l5':'36','l6':'35'
    },
    'hilo':{
        'h':'34','l':'33'
    },
    '250':{"0000":"77","0001":"76","0002":"75","0003":"74","0004":"73",
        "0100":"71","0101":"70","0102":"69","0103":"68","0104":"67",
        "0200":"65","0201":"64","0202":"63","0203":"62","0204":"61",
        "0300":"59","0301":"58","0302":"57","0303":"56",
        "0400":"55","0401":"54","0402":"53","-1-a":"47","-1-d":"48","-1-h":"49"
    },
    '240':{'33':'86','31':'85','30':'84','13':'83','11':'82','10':'81','03':'80','01':'79','00':'78'},
    '200':{'3':'100','1':'99','0':'98'},
    '230':{"s0":'94',"s1":'93',"s2":'92',"s3":'91',"s4":'90',"s5":'89',"s6":'88',"s7":'87'},
    '210':{'1':'100','2':'99','3':'98',"4":"97"},
    "270":{"3":"99","0":"98"}
}

var betEnMap={
    "poolCode":{ "hhad":"rqspf", "had":"spf", "crs":"bf", "ttg":"zjq", "hafu":"bqspf", "mnl":"sf", "hdc":"rfsf", "wnm":"sfc", "hilo":"dxf","ht":"hhgg","hhgg":"hhgg" },
    "lotteryType":{"nspf":"had","spf":"hhad","jqs":"ttg","bqc":"hafu","bf":"crs","sf":"mnl","rfsf":"hdc","sfc":"wnm","dxf":"hilo"},
    'hafu':{'hh':'33','hd':'31','ha':'30','dh':'13','dd':'11','da':'10','ah':'03','ad':'01','aa':'00'},
    'had':{'h':'3','d':'1','a':'0'},
    'hhad':{'h':'3','d':'1','a':'0'},
    'ttg':{"s0":'0',"s1":'1',"s2":'2',"s3":'3',"s4":'4',"s5":'5',"s6":'6',"s7":'7'},
    'crs':{"0000":"00","0001":"01","0002":"02","0003":"03","0004":"04","0005":"05",
        "0100":"10","0101":"11","0102":"12","0103":"13","0104":"14","0105":"15",
        "0200":"20","0201":"21","0202":"22","0203":"23","0204"	:"24","0205":"25",
        "0300":"30","0301":"31","0302":"32","0303":"33",
        "0400":"40","0401":"41","0402":"42","0500":"50",
        "0501":"51","0502":"52","-1-a":"0A","-1-d":"1A","-1-h":"3A"},
    'mnl':{
        'h':'3','a':'0'
    },
    'hdc':{
        'h':'3','a':'0'
    },
    'wnm':{
        'w1':'01','w2':'02','w3':'03','w4':'04','w5':'05','w6':'06',
        'l1':'11','l2':'12','l3':'13','l4':'14','l5':'15','l6':'16'
    },
    'hilo':{
        'h':'3','l':'0'
    },
    "bdPoolCode":{"200":"had","230":"ttg","240":"hafu","250":"crs","210":"wnm","270":"mnl"},
    "bdPoolCodeEn":{"had":"200","ttg":"230","hafu":"240","crs":"250","wnm":"210","mnl":"270"}
}


var g_week = [ "周日", "周一", "周二", "周三", "周四", "周五", "周六", "周日" ];
var g_had_name = {"胜":"3","平":"1","负":"0","让胜":"r3","让平":"r1","让负":"r0","3":"胜","1":"平","0":"负","r3":"让胜","r1":"让平","r0":"让负"};
var g_had_name_cn = {"3":"胜","1":"平","0":"负","h":"胜","d":"平","a":"负","r3":"让胜","r1":"让平","r0":"让负","-1":"取消","-1:-1":"取消"};
var g_had_name_num_en = {"3":"h","1":"d","0":"a","r3":"h","r1":"d","r0":"a"};
var g_had_name_en = {"胜":"3","平":"1","负":"0","让胜":"r3","让平":"r1","让负":"r0"};
var g_companyInfo={"14":"利记","4":"1xbet","88":"沙巴","1":"平博","100":"ISN"};
var g_userconfig={"竞彩":[0.09,0],"ISN":[0,0],"平博":[0,0],"利记":[0,0],"沙巴":[0,0],"1xbet":[0,0]};
var poolCodeBd = {"nspf":"200","jqs":"230","bf":"250","bqc":"240","sfc":"210","sf":"270"};
var g_passway = {"101":"单关","201":"二串一","301":"三串一","401":"四串一","501":"五串一","601":"六串一","701":"七串一","801":"八串一"}
var g_week_obj = {"周日":7, "周一":1, "周二":2, "周三":3, "周四":4, "周五":5, "周六":6};
//止赢止损设置
var g_profit_config = {"min":-2,"max":2,"allow_bet_monitor":0,"default_show":0,"zs_auto":0,"zy_auto":0,"match_start":-1,"profit_change":0};
var g_bet_fandian = 0.09;//佣金
var g_bet_jj = 0;
var g_bet_money = 10000;
var g_bet_bonus = 20000;

function formatNumber(num,digits) {
    if(!digits){
        digits = 0;
    }
    num = getNumLimit(num,digits).toFixed(digits);
    return num.replace(/(\d{1,3})(?=(\d{3})+(?:$|\.))/g, "$1,");
}

/**
 * 计算竞彩返点和加奖后的赔率
 * 原始赔率（1+加奖比例）/（1-返点比例）
 *  * 默认保留3位
 * @param odd
 * @returns
 */
function calcFd(odd,fd,jj,digit){
    if(!digit){
        digit = 3 ;
    }
    if(isNaN(odd)){
        odd=0;
    }
    odd = Number(odd);
    if(isNaN(fd)){
        fd = 0;
    }
    if(isNaN(jj)){
        jj = 0;
    }
    return getNumLimit((odd*(1+jj)/(1-fd)),digit);
}
/**
 * 截取小数位
 * @param num
 * @param digit
 * @returns
 */
function getNumLimit(num,digit){
    num = num+"";
    idx = num.indexOf(".");
    if(!digit){
        digit = 0;
    }
    if(idx==-1){
        for(var i=0;i<digit;i++){
            if(i==0){
                num = num + ".0";
            }else{
                num = num + "0";
            }
        }
    }else {
        idx = idx + digit + 1;
        var flag = '';
        if(num.charAt(0)=='-'){
            num = num.substring(1);
            flag='-';
            idx--;
        }
        if(num.length>idx){
            num = num.substring(0,idx);
        }else if(num.length<idx){
            do{
                num = num + "0";
            }while(num.length<idx);
        }
        num = flag + num;
    }

    return Number(num);
}

/**
 * 计算原始的竞彩赔率，除掉返点和加奖后的
 *  * 默认保留3位
 * @param odd
 * @returns
 */
function calcOddsWithOut(odd,fd,jj,digit){
    if(!digit){
        digit = 4 ;
    }
    if(isNaN(odd)){
        odd=0;
    }
    odd = Number(odd);
    fd = Number(fd);
    jj = Number(jj);
    if(!fd || isNaN(fd)){
        fd = g_bet_fandian;
    }
    if(!jj || isNaN(jj)){
        jj = g_bet_jj;
    }
    return getNumLimit((odd*(1-fd)/(1+jj)),digit);
}
/**
 * 计算返还率，百分比，按参数列表计算
 *  * 默认保留3位
 */
function return_race() {
    var k = 0;
    for (var i = 0; i < arguments.length; i++) {
        k += 1 / Number(arguments[i]);
    }
    return getNumLimit((1 / k) * 100,4);
}
/**
 * 返还率赔率,传数组和保留小数位长度
 * 默认保留3位
 */
function return_race_arr(arr,digit) {
    if(!digit){
        digit = 4 ;
    }
    var k = 0;
    for (var i = 0; i < arr.length; i++) {
        k += 1 / Number(arr[i]);
    }
    return getNumLimit((1 / k) * 100,digit);
}
/**
 * 返还率赔率，按参数列表计算
 * 保留3位小数
 * @returns
 */
function return_race_num() {
    var k = 0;
    for (var i = 0; i < arguments.length; i++) {
        k += 1 / Number(arguments[i]);
    }
    return getNumLimit((1 / k),4);
}
/**
 * 返还率赔率,传数组和保留小数位长度
 * 默认保留3位
 * @returns
 */
function return_race_num_arr(arr,digit) {
    if(!digit){
        digit = 4 ;
    }
    var k = 0;
    for (var i = 0; i < arr.length; i++) {
        k += 1 / Number(arr[i]);
    }
    return getNumLimit((1 / k),digit);
}


/**
 * //Z=1; 最终返还率，可以设定为100%,最低96% 才能有盈利 //Q=1/(1/sp1+1/sp2),赔率 //sp3=Z*Q/(Q-Z),值博赔率
 * q 赔率
 * z 最终返还率
 * 默认保留3位
 */
function getZhiBoOdds(q, z,digit) {
    if(!digit){
        digit =4 ;
    }
    var zhiBoOdds = getNumLimit((q * z / (q - z)),digit);
    return zhiBoOdds;
}

/**
 * 排序，按指定的属性值排序
 * @param name
 * @param minor
 * @returns {Function}
 */
function by_str(name, minor) {
    return function(o, p) {
        var a, b;
        if (typeof o === "object" && typeof p === "object" && o && p) {
            a = o[name];
            b = p[name];
            if (a === b) {
                return typeof minor === 'function' ? minor(o, p) : 0;
            }
            if (typeof a === typeof b) {
                if(isNaN(a) && isNaN(b)){
                    return a < b ? -1 : 1;
                }else{
                    return Number(a) < Number(b) ? -1 : 1;
                }
            }
            return typeof a < typeof b ? -1 : 1;
        }
    }
}


/**
 * 将对像进行排序
 * @param obj 对象
 * @param name 排序属性名
 * @param minor 子排序
 * @param desc 排序方式 desc 降序 asc
 * @returns 返回排序好的对象数组
 */
function obj_sort_by(obj,name,minor){
    var tmp = [];
    for(var k in obj){
        tmp.push(obj[k]);
    }
    tmp.sort(by_str(name,minor));
    return tmp;
}

/**
 * 深度克隆
 */
function deepClone(obj){
    var result={},oClass=isClass(obj);
    for(key in obj){
        var copy=obj[key];
        if(isClass(copy)=="Object"){
            result[key]=arguments.callee(copy);//递归调用
        }else if(isClass(copy)=="Array"){
            result[key]=arguments.callee(copy);
        }else{
            result[key]=obj[key];
        }
    }
    return result;
}
//返回传递给他的任意对象的类
function isClass(o){
    if(o===null) return "Null";
    if(o===undefined) return "Undefined";
    return Object.prototype.toString.call(o).slice(8,-1);
}
/**
 *
 * @param oddsArr 赔率数组,长度为6，对应的是3,1,0,r3,r1,r0 的赔率
 * @param betopt 投注内容，值为 ,3,1,0,r3,r1,r0, 中的一个
 * @returns
 */
function getOddsFromBetOpt(oddsArr,betopt){
    switch(betopt){
        case '3':
        case '胜':
            return oddsArr[0];
        case '1':
        case '平':
            return oddsArr[1];
        case '0':
        case '负':
            return oddsArr[2];
        case 'r3':
        case '让胜':
            return oddsArr[3]?oddsArr[3]:oddsArr[0];
        case 'r1':
        case '让平':
            return oddsArr[4]?oddsArr[4]:oddsArr[1];
        case 'r0':
        case '让负':
            return oddsArr[5]?oddsArr[5]:oddsArr[2];
        default:return 0;
    }
}
/**
 * 得到中文显示
 * @param opt
 * @returns
 */
function getHadNameCn(opt){
    var cn = g_had_name_cn[opt];
    if(!cn){
        cn = opt;
    }
    return cn;
}
/**
 * 得到英文显示，也就是数字表示法
 * @param opt
 * @returns
 */
function getHadNameEn(opt){
    var cn = g_had_name_en[opt];
    if(!cn){
        cn = opt;
    }
    return cn;
}

function getIntVal(val){
    val = val + "";
    return parseInt(val.replace(/,/g,""));
}

function getNumberVal(val){
    val = val + "";
    return Number(val.replace(/,/g,""));
}

function return_odds_arr(odds_arr,rate){
    var rt = return_race_num_arr(odds_arr,4);
    //var rate =0.90-rt;
    if(rt<0.9){
        for(var i=0;i<odds_arr.length;i++){
            var o = odds_arr[i];
            o = o*(1+rate);
            odds_arr[i] =  dealDecimal(o);;
        }
    }
    return odds_arr;
}

function getRandomNum(Min,Max)
{
    var Range = Max - Min;
    var Rand = Math.random();
    var r = Min + Rand * Range;
    return r.toFixed(4);
}

//制保留2位小数，如：2，会在2后面补上00.即2.00
function dealDecimal(x) {
    var f = parseFloat(x);
    if (isNaN(f)) {
        return false;
    }
    var f = Math.round(x*100)/100;
    var s = f.toString();
    var rs = s.indexOf('.');
    if (rs < 0) {
        rs = s.length;
        s += '.';
    }
    while (s.length <= rs + 2) {
        s += '0';
    }
    return s;
}


var MathUtil = {
    //数字数组的倒序
    sortDesc:function(a,b){
        return b-a;
    },
    //组合取个数 c(4,2)=6
    c: function (len, m) {
        return (function (n1, n2, j, i, n) {
            for (; j <= m;) {
                n2 *= j++;
                n1 *= i--
            }
            return n1 / n2
        })(1, 1, 1, len, len)
    },
    //组合取数组，z 表示取前多少个,为0时全取
    cl: function (arr, n, z) {
        var r = [];

        function fn(t, a, n) {
            if (n === 0 || z && r.length == z) {
                r[r.length] = t;
                return t
            }
            for (var i = 0, l = a.length - n; i <= l; i++) {
                if (!z || r.length < z) {
                    var b = t.slice();
                    b.push(a[i]);
                    fn(b, a.slice(i + 1), n - 1)
                }
            }
        }
        fn([], arr, n);
        return r
    },
    //排列取个数
    p: function (n, m) {
        for (var i = n - m, c = 1; i < n;) {
            c *= ++i
        }
        return c
    },
    //排列取数组
    pl: function (arr, n, z) {
        var r = [];

        function fn(t, a, n) {
            if (n === 0 || z && r.length == z) {
                r[r.length] = t;
                return t
            }
            for (var i = 0, l = a.length; i < l; i++) {
                if (!z || r.length < z) {
                    fn(t.concat(a[i]), a.slice(0, i).concat(a.slice(i + 1)), n - 1)
                }
            }
        }
        fn([], arr, n);
        return r
    },
    //有胆码时组合个数 胆个数，托个数,总个数
    dt: function (d, t, m) {
        return d >= m ? 0 : MathUtil.c(t, m - d)
    },
    //有胆码时组合取数组 d 胆数组，t 托数组,n 总个数，z 取前几个
    dtl: function (d, t, n, z) {
        var r = [];
        if (d.length <= n) {
            r = MathUtil.cl(t, n - d.length, z);
            for (var i = r.length; i--;) {
                r[i] = d.concat(r[i])
            }
        }
        return r;
    },
    //计算返奖率
    b:function(m1,b){
        var B=0;
        if(!b){
            b=1;
        }
        for (var i in m1) {
            B += (1 / ml[i]);
        }
        return b/B;
    },
    //根据赔率和返还率计算打出概率 g 为返还率，通常情况下是1
    bl: function (ml, g) {
        var A, bs, B = 0,
            bl = [];
        B=this.b(m1,g);
        A = g / B;
        for (i = ml.length; i--;) {
            bs = A / ml[i];
            bl[i] = bs;
        }
        return bl;
    },
    //4舍六入五成双，保留2位小数
    round2: function (n) {
        if (/\d+\.\d\d5/.test(n.toString())) {
            var m = n.toString().match(/\d+\.\d(\d)/);
            return (m && m[1] % 2 == 1) ? parseFloat(n).toFixed(2) : parseFloat(m[0]);
        } else {
            return parseFloat(parseFloat(n).toFixed(2));
        }
    },
    //取数组的积,计算奖金时需要
    a: function (A1) {
        var ret = 1;
        for (var i in A1) {
            ret *= A1[i];
        }
        return ret ;
    },
    //数组合并排列，A2 是二维数组，fn 是处理每个元素
    al: function (A2, fn) {
        var n = 0,
            codes = [],
            code = [],
            isTest = typeof fn == "function";

        function each(A2, n) {
            if (n >= A2.length) {
                if (!isTest || false !== fn(code)) {
                    codes.push(code.slice())
                }
                code.length = n - 1;
            } else {
                var cur = A2[n];
                for (var i = 0, j = cur.length; i < j; i++) {
                    code.push(cur[i]);
                    each(A2, n + 1);
                }
                if (n) {
                    code.length = n - 1;
                }
            }
        }
        if (A2.length>0) {
            each(A2, n);
        }
        return codes
    },
    dealDecimal:function(x) {
        var f = parseFloat(x);
        if (isNaN(f)) {
            return false;
        }
        var f = Math.round(x*100)/100;
        var s = f.toString();
        var rs = s.indexOf('.');
        if (rs < 0) {
            rs = s.length;
            s += '.';
        }
        while (s.length <= rs + 2) {
            s += '0';
        }
        return s;
    },getArrJiArr:function(a,b){
        if(a.length<b){
            return;
        }
        var sum = MathUtil.digui(a,b,0);
        return sum;
    },digui:function(a,b,start){
        if(a.length-start<b)
            return 0;
        if(b==0)
            return 1;
        var sum=0;
        for(var i=start;i<a.length;i++){
            sum+=a[i]*MathUtil.digui(a,b-1,i+1);
        }
        return sum;
    },fl:function(arr,len){
        //现将二位数组,合并
        var narr = MathUtil.al(arr,function(f){

        });

        if(len>narr[0].length){
            throw '长度错误';
        }
        var zhu = 0;
        for(var a in narr){
            var barr = narr[a];
            var carr = MathUtil.cl(barr,len);
            for(var b in carr){
                zhu +=new Function("return " +carr[b].join("*"))();
            }
        }
        console.log(zhu);
    },flt:function(arr,len){
        //现将二位数组,合并
        var narr = MathUtil.al(arr,function(f){

        });

        if(len>narr[0].length){
            throw '长度错误';
        }
        var rarr = [];
        for(var a in narr){
            var barr = narr[a];
            var carr = MathUtil.cl(barr,len);
            rarr.push(carr);
        }
        return rarr;
    }
};

function MathFloor(x){
    var f = parseFloat(x);
    if (isNaN(f)) {
        return false;
    }
    return Math.floor(f * 100) / 100;
}
