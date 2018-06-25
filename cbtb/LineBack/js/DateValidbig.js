/*������֤*/
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
		
	

//��������Ƿ�Ϊ�Ϸ�ֵ
//�������:������ݵ�Ԫ�أ��Լ��·ݣ��յ�Ԫ��
function checkDate(elemYear,elemMonth,elemDay)
{
   if(!ValidYear(elemYear)) 
   {
	error(elemYear,"Incorrect Year");
	return false;
   }//end if

   if(!ValidMonth(elemMonth) )
   {
	error(elemMonth,"�·ݲ����_");
	return false;
   }//end if

   if(!ValidDay(elemDay)) 
   {
	error(elemDay,"�Ք������_")
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
      error(elemDay,"�Ք������1-30" )
      return false;
    }//end if
  }
  else if (month==2)
  { 
    if ( year%4==0 && year%100 !=0 || year%400==0)  //����
    { 
      if (day<1||day>29)
      {
        error(elemDay," ԓ���ǝ��꣬2�·��Ք������1-29" )
        return false;
      }//end if
    } 
    else						//ƽ��
    { 
      if (day>28) 
      {
        error(elemDay," ԓ����ƽ�꣬2�·��Ք������1-28" )
        return false;
      }//end if
    }
}
 return true;
}

//���һ��Ԫ���е�����ֵ�Ƿ�Ϸ�
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
    error(elem,"�����_������!");
    return false;
  }
   if(!isInt(nn[0]) || !isInt(nn[1]) || !isInt(nn[2]))
   {
     error(elem,"�����_������!");
     return false;
    }
  year=parseInt(nn[0],10);
  month=parseInt(nn[1],10);
  day=parseInt(nn[2],10);
  if (year>2100||year<1900)
  {
    error(elem,"�����_����ݣ�");
    return false;
  }
  if (month<1||month>12)
  {
    error(elem,"�����_���·ݣ�");
    return false;
  }
  if (month==1||month==3||month==5||month==7||month==8||month==10||month==12)
  {
    if (day<1||day>31)
    {
      error(elem,"�·ݑ����1-31 ��");
      return false;
    }
  }
  else if (month==2)
  { 
    if ((((year%4)==0)&&((year%100)!=0))||((year%400)==0))
    { 
      if (day<1||day>29)
      {
        error(elem,"ԓ���ǝ��꣬2�·��Ք������1-29");
        return false;
      }
    } 
    else
    { 
      if (day<1||day>28) 
      {
        error(elem,"ԓ����ƽ�꣬2�·��Ք������1-28");
        return false;
      }
    }
  }
  else
  {
    if (day<1||day>30)
    {
      error(elem,"ԓ�·��Ք������1-30");
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