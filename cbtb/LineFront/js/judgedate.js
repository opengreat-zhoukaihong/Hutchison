function isLeapYear(year)
{
  if (((year%4)==0) && ((year%100)!=0) || ((year%400)==0))
     {return (true);}
  else {return (false);}
}


function getDaysInMonth (month,year)
{
var days;
if ((month==1) || (month==3) || (month==5) || (month==7) || (month==8) || (month==10) || (month==12))
   days=31;
else if ((month==4) || (month==6) || (month==9) || (month==11))
         days=30;
else if (month==2)
   {
          if (isLeapYear(year))
              days=29;
          else
              days=28;
             }
return (days);
}

function theYear(str)
{
  var year=str.indexOf('-');
  var first=str.substring(0,year);
  var year=parseInt(first,10);
  return (year);
}
function theMonth(str)
{
  var first=str.indexOf("-");
  var last=str.lastIndexOf("-");
  var month=parseInt(str.substring(first+1,last),10);
  return (month);
}
function theDay(str)
{
  var day=str.lastIndexOf("-");
  day=parseInt(str.substring(day+1,str.length),10);
  return (day);
}
function isJudgeDate(str)/*根据输入的字符串判断日期是否合法，返回值为boolean*/
{
if (((str.charAt(4)!="-" || str.charAt(7)!="-"))&&(str.length<10))
{   
     return (false) ;
}
var year=theYear(str);
var month=theMonth(str);
var day=theDay(str);
if (year<1950 || year>2010)
{   
   if (year!=1900)
      return (false) ;
}
if (month<1 || month>12)
{ 
   return (false) ;
}
var maxDay=getDaysInMonth(month,year);
if (day>maxDay)
{ 
return (false) ;
}
return (true);
}
