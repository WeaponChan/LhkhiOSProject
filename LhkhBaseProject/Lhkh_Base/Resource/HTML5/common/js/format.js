function getDataCount(json){
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
            /*if(nod!=m.num.substring(0,2)){
                delete data[id];
                continue;
            }
            if(nowDate!=m.b_date){
                delete data[id];
                continue;
            }*/
            var isd = false;
            if(m.had&&m.had.single==1){
                isd = true;
            }

            if(m.hhad&&m.hhad.single==1){
                isd = true;
            }

            if(m.mnl&&m.mnl.single==1){
                isd = true;
            }

            if(m.hdc&&m.hdc.single==1){
                isd = true;
            }

            if(m.hilo&&m.hilo.single==1){
                isd = true;
            }

            if(!isd){
                delete data[id];
                continue;
            }

            if(m.bookEndTimeLong<nowTime){//截止
                delete data[id];
                continue;
            }
        }
    }
    return data;
}

function getJsonData(json,isHot){
    var data = json["data"];
    var nod = getWeekStrByDate2(new Date());
    if(data){
        var nowTime=new Date().getTime();
        for(var id in data){
            var m = data[id];
            m.match_start_time = m.date + ' ' + m.time;
            var date = parseTime(m.match_start_time);
            var hour = date.getHours();
            if(date.getDay()==0 || date.getDay()==1){
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
            /*if(nod!=m.num.substring(0,2)){
                delete data[id];
                continue;
            }*/

            if(m.bookEndTimeLong<nowTime&&isHot){//截止
                delete data[id];
                continue;
            }
        }
    }
    return data;
}

