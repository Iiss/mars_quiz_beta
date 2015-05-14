package utils 
{
	public class XMLUtils 
	{
		public static function shuffle(sourceList:XMLList,limit:int=0):XMLList  
		{
			var cnt:int = 0;
			var randomized:XMLList = new XMLList();
			
			while(sourceList.length()) 
			{
				var r:int = Math.floor(Math.random() * sourceList.length());
				randomized += sourceList[r];
				delete sourceList[r];
				
				if (limit > 0)
				{
					cnt++;
					if (cnt == limit) break;
				}
			}
			
			return randomized;
		}
	}
}