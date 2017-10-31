//当浏览器窗口大小改变时重载网页
/*window.onresize=function(){
    window.location.reload();
}*/

//页面加载时给img和a标签添加draggable属性
(function () {
    $('img').attr('draggable', 'false');
    $('a').attr('draggable', 'false');
})();
 
//设置Cookie
function setCookie(name, value, time) {
    var strsec = getsec(time);
    var exp = new Date();
    exp.setTime(exp.getTime() + strsec * 1);
    document.cookie = name + "=" + escape(value) + ";expires=" + exp.toGMTString();
}
function getsec(str) {
    var str1 = str.substring(1, str.length) * 1;
    var str2 = str.substring(0, 1);
    if (str2 == "s") {
        return str1 * 1000;
    } else if (str2 == "h") {
        return str1 * 60 * 60 * 1000;
    } else if (str2 == "d") {
        return str1 * 24 * 60 * 60 * 1000;
    }
}
 
//获取Cookie
function getCookie(name) {
    var arr, reg = new RegExp("(^| )" + name + "=([^;]*)(;|$)");
    if (arr = document.cookie.match(reg)) {
        return unescape(arr[2]);
    } else {
        return null;
    }
}

var checkall=document.getElementsByName("checkbox[]");  
//全选
function select(){
	for(var $i=0;$i<checkall.length;$i++){  
		checkall[$i].checked=true;  
	}  
};
//反选
function reverse(){
	for(var $i=0;$i<checkall.length;$i++){  
		if(checkall[$i].checked){  
			checkall[$i].checked=false;  
		}else{  
			checkall[$i].checked=true;  
		}  
	}  
}     
//全不选     
function noselect(){ 
	for(var $i=0;$i<checkall.length;$i++){  
		checkall[$i].checked=false;  
	}  
} 

var checkall2=document.getElementsByName("checkbox2[]");  
//全选
function select2(){
	for(var $i=0;$i<checkall2.length;$i++){  
		checkall2[$i].checked=true;  
	}  
};
//反选
function reverse2(){
	for(var $i=0;$i<checkall2.length;$i++){  
		if(checkall2[$i].checked){  
			checkall2[$i].checked=false;  
		}else{  
			checkall2[$i].checked=true;  
		}  
	}  
}     
//全不选     
function noselect2(){ 
	for(var $i=0;$i<checkall2.length;$i++){  
		checkall2[$i].checked=false;  
	}  
}

var checkall3=document.getElementsByName("checkbox3[]");  
//全选
function select3(){
	for(var $i=0;$i<checkall3.length;$i++){  
		checkall3[$i].checked=true;  
	}  
};
//反选
function reverse3(){
	for(var $i=0;$i<checkall3.length;$i++){  
		if(checkall3[$i].checked){  
			checkall3[$i].checked=false;  
		}else{  
			checkall3[$i].checked=true;  
		}  
	}  
}     
//全不选     
function noselect3(){ 
	for(var $i=0;$i<checkall3.length;$i++){  
		checkall3[$i].checked=false;  
	}  
}
//启用工具提示
$('[data-toggle="tooltip"]').tooltip();
 

//禁止右键菜单
/*window.oncontextmenu = function(){
	return false;
};*/

/*自定义右键菜单*/
/*(function () {
    var oMenu = document.getElementById("rightClickMenu");
    var aLi = oMenu.getElementsByTagName("li");
	//加载后隐藏自定义右键菜单
	//oMenu.style.display = "none";
    //菜单鼠标移入/移出样式
    for (i = 0; i < aLi.length; i++) {
        //鼠标移入样式
        aLi[i].onmouseover = function () {
            $(this).addClass('rightClickMenuActive');
			//this.className = "rightClickMenuActive";
        };
        //鼠标移出样式
        aLi[i].onmouseout = function () {
            $(this).removeClass('rightClickMenuActive');
			//this.className = "";
        };
    }
    //自定义菜单
    document.oncontextmenu = function (event) {
		$(oMenu).fadeOut(0);
        var event = event || window.event;
        var style = oMenu.style;
        $(oMenu).fadeIn(300);
		//style.display = "block";
        style.top = event.clientY + "px";
        style.left = event.clientX + "px";
        return false;
    };
    //页面点击后自定义菜单消失
    document.onclick = function () {
        $(oMenu).fadeOut(100);
		//oMenu.style.display = "none"
    }
})();*/
 

