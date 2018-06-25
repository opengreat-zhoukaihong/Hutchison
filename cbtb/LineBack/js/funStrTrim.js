function RTrim(Str)
		{
			var retStr;
			var pos=Str.length;
			if (pos>0)
				{
					while (Str.charAt(--pos) ==" ")
						;
					if (pos==-1)
						retStr="";
					else
						retStr=Str.substring(0,pos+1);	
				}
			else
				{
					retStr=Str;
				}
			return retStr;
		}
		
	function LTrim(Str)
		{
			var retStr;
			var intLen=Str.length;
			var pos=0;
			if (intLen>0)
				{
					while (Str.charAt(pos++) ==" ")
						;
					if (pos==intLen+1)
						retStr="";
					else
						retStr=Str.substring(pos-1,intLen);	
				}
			else
				{
					retStr=Str;
				}
			return retStr;
		}
	function Trim(Str)
		{
			return LTrim(RTrim(Str));
			
		}
