

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
