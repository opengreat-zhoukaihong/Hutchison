
function isEmpty(str)
{
  if((str==null)||(str.length==0)) return true;
  else return(false);
}


function isBetween(val,lo,hi)
{
   if((val<lo)||(val>hi))
     return false;
   else
       return true;
}

function isDate(theStr)
{
   var the1st = theStr.indexOf('-');
   var the2nd = theStr.lastIndexOf('-');
   if(the1st==the2nd)
      return false;
   else
   {
     // var m = theStr.substring(0,the1st); 
     // var d = theStr.substring(the1st+1,the2nd);
     // var y = theStr.substring(the2nd+1,theStr.length);
      var y = theStr.substring(0,the1st); 
      var m = theStr.substring(the1st+1,the2nd);
      var d = theStr.substring(the2nd+1,theStr.length);
      var maxDays = 31;
      if(isInt(m)==false||isInt(d)==false||isInt(y)==false) 
        {
            return false;
        }
       else
       {
        if(y.length<4) {return(false);}
        else if(!isBetween(m,1,12)) {return (false);}
             else if(m==4||m==6||m==9||m==11) maxDays = 30;
                  else if(m==2)
                       {
                          if(y % 4 > 0) maxDays = 28;
                          else if(y % 100 == 0 && y % 400 > 0) maxDays = 28;
                               else maxDays = 29;
                        }
       }
   if(isBetween(d,1,maxDays) == false) { return(false);}
   if(d.length<2){return(false);}
   if(m.length<2){return(false);}
   else {return(true);}
 }
}


function isTime(theStr)
{
 var colonDex = theStr.indexOf(':');
 if((colonDex<1)||(colonDex>2)) {return(false);}
 else{
      var hh = theStr.substring(0,colonDex);
      var ss = theStr.substring(colonDex+1,theStr.length);
      if((hh.leng<1)||(hh.length>2)||(!isInt(hh))) {return(false);}
      else if((ss.length<1)||(ss.length>2)||(!isInt(ss))) {return(false);}
           else if((!isBetween(hh,0,23)) || (!isBetween(ss,0,59))) {return(false);}
                else {return(true);}
      }
 }


function isInt(theStr)
{
  var flag = true;
  if(isEmpty(theStr)) {flag = false;}
  else
  {
    for(var i=0;i<theStr.length;i++)
    {
      if(isDigit(theStr.substring(i,i+1))==false)
      {
         flag = false;
         break;
      }
    }
  }
  return(flag);
}

function isDigit(theNum)
{
  var theMask ='0123456789';
  if(isEmpty(theNum)) return(false);
  else if(theMask.indexOf(theNum) == -1) return(false);
  return(true);
}


function isEmail(theStr)
{
  var atIndex = theStr.indexOf('@');
  var dotIndex = theStr.indexOf('.',atIndex);
  var flag = true;
  var theSub = theStr.substring(0,dotIndex+1)
  if((atIndex<1)||(atIndex != theStr.lastIndexOf('@'))||(dotIndex<atIndex+2)||(theStr.length<=theSub.length))
  {
    flag = false;}
  else flag = true;
  return(flag);
}

function isReal(theStr,decLen)
{
 var dot1st = theStr.indexOf('.');
 var dot2nd = theStr.lastIndexOf('.');
 var ok = true;
 if(isEmpty(theStr)) return false;
 if(dot1st == -1)
 {
   if(!isInt(theStr)) return false;
   else return true;
 }
 else if(dot1st != dot2nd) return(false);
      else if(dot1st == 0) return(false);
           else
               {
                 var intPart = theStr.substring(0,dot1st);
                 var decPart = theStr.substring(dot2nd+1);
                 if(decPart.length > decLen) return(false);
                 else if(!isInt(intPart)||!isInt(decPart)) return false;
                      else if(isEmpty(decPart)) return(false);
                           else return true;
                }
}
//Remover the space
function RemoveSpace(inputstr){
   var Str;
   Str = "";
   for (i = 0;i < inputstr.length;i++){
       var onechar = inputstr.charAt(i);
           if ((onechar != " ") || (onechar = "-")){
              if(onechar = "/")
                 Str = Str  + inputstr.charAt(i);
        }
   }
   return  Str;
}
//verify the string is digit
function ispositiveinteger(inputval,obj,instr){
   var inputstr = inputval.toString();
   var str = RemoveSpace(inputstr);
//  window.alert (str)
   for (var i = 0;i < str.length;i++){
       var onechar = str.charAt(i);
              if ((onechar < "0") || (onechar > "9" )) {
                 window.alert (instr);
                 str = str.substr(0,i);
                 obj.value = str;
                 obj.focus();
                 return false;
              }
   }
   obj.value = str
   return true;
 }
 
//verify the date 
function validDate(strDate,obj){
   var now = new Date();
   var inputDate = strDate.substring(0,10);
   var deliveryYear = strDate.substring(0,4);
   var deliveryMonth = strDate.substring(5,7);
   var deliveryDate =  strDate.substring(8,10);
   if(deliveryYear < now.getYear()){
      alert("��؛�r�g�����Ҫ��� " + now.getYear() + " ��!");
      obj.focus();
      return false;
   }
   else{ //es4
        if((deliveryYear > now.getYear())){
           if((deliveryYear > now.getYear()+1) && (now.getMonth()+1 == 12)){
               alert("��؛�r�g����� '" + deliveryYear + "' ҪС춻��� " + (now.getYear()+1) + " ��!");
               obj.focus();
               return false;
           }
           else{
                if(deliveryYear > now.getYear()+1){
                   alert("��؛�r�g����� '" + deliveryYear + "' Ҫ��� " + now.getYear() + " ��!");
                   obj.focus();
                   return false;
                }
           }       
           if((deliveryYear = now.getYear()+1) && (now.getMonth()+1 == 12)){
              if(deliveryMonth > 1){
                alert("��؛�r�g '" + inputDate  + "' ҪС� '" + deliveryYear + "-01-" + now.getDate() + "' !");
                obj.focus();
                return false;
              }
              else{ 
                   if(deliveryDate > now.getDate()){
                      alert("��؛�r�g '" + inputDate  + "' ���ܴ��  '" + deliveryYear + "-01-" + now.getDate() + "' !");
                      obj.focus();
                      return false;
                   }
             }
                       
          }
     }
     else{ //es3
          if(deliveryMonth > now.getMonth()+2){
             alert("��؛�r�g���·�ҪС춻��� " + (now.getMonth()+2) + " �·�!");
             obj.focus();
             return false;
          }
          else{ //es2
               if(deliveryMonth < now.getMonth()+1){
                  alert("��؛�r�g���·ݲ���С� "+ now.getYear() + " �� " + (now.getMonth()+1) + " �·�!");
                  obj.focus();
                  return false;
               } 
               else{   //es1
                    if((deliveryMonth == now.getMonth()+1) && (deliveryDate  < now.getDate())){
                       alert("��؛�r�g '" + inputDate  + "' ����С춽���  '" + now.getYear()+ "-" + (now.getMonth()+1) + "-" + (now.getDate()) + "' !");
                       obj.focus();
                       return false;
                    }
               } //es1
          } //es2
       } //es3
    }  //es4  
    return true;
 } //end function