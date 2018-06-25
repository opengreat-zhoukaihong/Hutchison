//the object's value must be "YYYY-MM-DD" if not't this funcation can't work
//before than start return -1   start is eg:"-1","-5";
//later  than end   return -2
//else return 1
function between(object,start,end,s_serverDate)
{
	var startDate = new Date()
	var endDate = new Date()
	var inputDate = new Date()
	var serverDate = new Date()
	
	inputDate = stringToDate(object.value)
	serverDate = stringToDate(s_serverDate)

	msPerDay = 24*60*60*1000;		//a day's second
	startDate.setTime(serverDate.getTime() + msPerDay*start)
	endDate.setTime(serverDate.getTime() + msPerDay*end)

	if(inputDate.getTime() >= startDate.getTime())
	{
		if(inputDate.getTime() > endDate.getTime())
		{
			return -2		//later than end
		}
		else				//include inputDate = startDate and inputDate = endDate
		{
			return 0
		}
	}
	else
	{
		return -1			//before than start
	}
}
function stringToDate(s)
{
	var year = s.substring(0,4)
	var Hmonth = s.substring(5,6)
	var Lmonth = s.substring(6,7)
	var Hdate = s.substring(8,9)
	var Ldate = s.substring(9,10)
	var y = parseInt(year)
	var m = (parseInt(Hmonth)*10 + parseInt(Lmonth))-1
	var d = parseInt(Hdate)*10 + parseInt(Ldate)
	theDate = new Date(y,m,d)
	return theDate
}