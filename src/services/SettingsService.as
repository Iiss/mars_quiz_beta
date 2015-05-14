package services 
{
	import utils.Data;
	/**
	 * ...
	 * @author liss
	 */
	public class SettingsService
	{
		private static const FILE:String = "ru_marstefo_quiz";
		private static const SKIP_INTRO:String = "skip_intro";
		
		public static function get skipIntro():Boolean
		{
			Data.load(FILE);
			return Data.readBool(SKIP_INTRO, false);
		}
		
		public static function set skipIntro(value:Boolean):void
		{
			setValue(SKIP_INTRO, value);
		}
		
		private static function setValue(name:String,value:*):void
		{
			Data.load(FILE);
			
			switch(true)
			{
				case value is int:
					Data.writeInt(name, value);
					break;
					
				case value is uint:
					Data.writeUint(name, value);
					break;
					
				case value is Boolean:
					Data.writeBool(name, value);
					break;
					
				case value is String:
					Data.writeString(name, value);
					break;
			}
			
			Data.save(FILE);
		}
	}

}