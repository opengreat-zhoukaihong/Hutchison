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
					if (parseInt(elem.value,10)>0 && parseInt(elem.value,10)<=31)
						blnRet=true;
				}
			return blnRet;	
		}
		
	function ValidMonth(elem)
		{
			var blnRet=false;
			if (isInt(elem.value))
				{
					if (parseInt(elem.value,10)>0 && parseInt(elem.value,10)<13)
						blnRet=true;
				}
			return blnRet;
		}
	function ValidYear(elem)
		{   
			var blnRet=false;
			if(isInt(elem.value))
					if (parseInt(elem.value,10)>1900)
						blnRet=true;
						
			return blnRet;
		}
		
	

//检查日期是否为合法值
//输入参数:包含年份的元素，以及月份，日的元素
function checkDate(elemYear,elemMonth,elemDay)
{
   if(!ValidYear(elemYear)) 
   {
	error(elemYear,"Incorrect Year");
	return false;
   }//end if

   if(!ValidMonth(elemMonth) )
   {
	error(elemMonth,"月份不正確");
	return false;
   }//end if

   if(!ValidDay(elemDay)) 
   {
	error(elemDay,"日數不正確")
	return false;
   }

   var year,month,day
   year=parseInt(Trim(elemYear.value),10);
   month=parseInt(Trim(elemMonth.value),10);
   day=parseInt(Trim(elemDay.value),10);
  if (month==4||month==6||month==9||month==11)
  {
    if (day>30)
    {
      error(elemDay,"日數應介於1-30" )
      return false;
    }//end if
  }
  else if (month==2)
  { 
    if ( year%4==0 && year%100 !=0 || year%400==0)  //闰年
    { 
      if (day<1||day>29)
      {
        error(elemDay," 該年是潤年，2月份日數應介於1-29" )
        return false;
      }//end if
    } 
    else						//平年
    { 
      if (day>28) 
      {
        error(elemDay," 該年是平年，2月份日數應介於1-28" )
        return false;
      }//end if
    }
}
 return true;
}

//检查一个元素中的日期值是否合法
function checkDateWithOneElem(elem)
{
  var year,month,day;
  var str=elem.value;
  if ((str.indexOf("/",0)>0)&&((str.split("/")).length>2))
    nn=str.split("/");
  else if ((str.indexOf(".",0)>0)&&((str.split(".")).length>2))
    nn=str.split(".");
  else if ((str.indexOf("-",0)>0)&&((str.split("-")).length>2))
    nn=str.split("-");
  else
  {
    error(elem,"不正確的日期!");
    return false;
  }
   if(!isInt(nn[0]) || !isInt(nn[1]) || !isInt(nn[2]))
   {
     error(elem,"不正確的日期!");
     return false;
    }
  year=parseInt(nn[0],10);
  month=parseInt(nn[1],10);
  day=parseInt(nn[2],10);
  if (year>2100||year<1900)
  {
    error(elem,"不正確的年份！");
    return false;
  }
  if (month<1||month>12)
  {
    error(elem,"不正確的月份！");
    return false;
  }
  if (month==1||month==3||month==5||month==7||month==8||month==10||month==12)
  {
    if (day<1||day>31)
    {
      error(elem,"月份應介於1-31 ！");
      return false;
    }
  }
  else if (month==2)
  { 
    if ((((year%4)==0)&&((year%100)!=0))||((year%400)==0))
    { 
      if (day<1||day>29)
      {
        error(elem,"該年是潤年，2月份日數應介於1-29");
        return false;
      }
    } 
    else
    { 
      if (day<1||day>28) 
      {
        error(elem,"該年是平年，2月份日數應介於1-28");
        return false;
      }
    }
  }
  else
  {
    if (day<1||day>30)
    {
      error(elem,"該月份日數應介於1-30");
      return false;
    }
  }
  return true;
}

function compareDate(startDate,endDate)
{
  var startYear,startMonth,startDay
  var endYear,endMonth,endDay
  var startArray,endArray
  var dateStart,dateEnd
  startArray = checkDateFormat(startDate)
  endArray = checkDateFormat(endDate)
   
  if(startArray.length>0 && endArray.length>0)
  {
    startYear  =  startArray[0];  
    startMonth = startArray[1];
    startDay   = startArray[2];
    dateStart  = new Date(startYear,startMonth - 1,startDay);
    endYear    =  endArray[0];  
    endMonth   = endArray[1];
    endDay     = endArray[2];
    dateEnd    = new Date(endYear,endMonth - 1,endDay);
    if(dateStart - dateEnd < 0)
	return 1
    else if(dateStart - dateEnd == 0)
	return 0 
    else if(dateStart -dateEnd >0)
        return -1
	
  }
  else
    return -100
   
  
    
}
function checkDateFormat(date)
{ 
  var nn;
  if ((date.indexOf("/",0)>0)&&((date.split("/")).length>2))
    nn=date.split("/");
  else if ((date.indexOf(".",0)>0)&&((date.split(".")).length>2))
    nn=date.split(".");
  else if ((date.indexOf("-",0)>0)&&((date.split("-")).length>2))
    nn=date.split("-");
  else
     alert("illegal data format");
  return nn;
}

function error(elem,ErrStr)
{       
	window.alert(ErrStr);
	elem.select();

}