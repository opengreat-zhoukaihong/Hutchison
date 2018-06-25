/***判断是否大于或等于今天***/
function isLessToday(s)
 {
    var blnRet=true;
    var y = parseInt(s.substring(0,4));
    var m = parseInt(s.substring(5,7)) - 1;
    var d = parseInt(s.substring(8,10)) - 1;
    
    var gdCurDate = new Date();       //取得当前日期
    var now = new Date(gdCurDate.getFullYear(),gdCurDate.getMonth(),gdCurDate.getDate());
    var inputDate = new Date(y,m,d);
    if((Date.UTC(now)-Date.UTC(inputDate))>0)
     {
	blnRet=false;
     }
    return blnRet;
 }


function isFloat(elem)
		{   var blnRet=true;
			var i;
			elem=Trim(elem);
			if (elem.length==0)
				blnRet=false;
			else
				{
				for (i=0;i<elem.length;i++) 
				 {
				
                                      if((elem.charAt(i))!=".")
                                         {
                                            if (elem.charAt(i)< "0" || elem.charAt(i)> "9")
							{
							blnRet=false;
							break;
							}
				         }
                                 } 
				}
			return blnRet;
		}
/*日期验证*/
	function isInt(elem)
		{   var blnRet=true;
			var i;
			elem=Trim(elem);
			if (elem.length==0)
				blnRet=false;
			else
				{
				for (i=0;i<elem.length;i++) 
				{
						if (elem.charAt(i)< "0" || elem.charAt(i)> "9")
							{
							blnRet=false;
							break;
							}
					} 
				}
			return blnRet;
		}
		
	function ValidDay(elem)
		{   var blnRet=false;
			if (isInt(elem.value)) 
				{
					if (parseInt(elem.value)>0 && parseInt(elem.value)<=31)
						blnRet=true;
				}
			return blnRet;	
		}
		
	function ValidMonth(elem)
		{
			var blnRet=false;
			if (isInt(elem.value))
				{
					if (parseInt(elem.value)>0 && parseInt(elem.value)<13)
						blnRet=true;
				}
			return blnRet;
		}
	function ValidYear(elem)
		{   
			var blnRet=false;
			if(isInt(elem.value))
					if (parseInt(elem.value)>1900)
						blnRet=true;
						
			return blnRet;
		}
		
	function Error(elem,ErrStr)
		{
			if(errFound) return;
			window.alert(ErrStr);
			elem.select();
			errFound=true;
		}
