package mvc.commands 
{
	import mvc.models.ContentsModel;
	/**
	 * ...
	 * @author liss
	 */
	public class LoadConfigCommand extends LoadCommandBase 
	{
		private static const PACK_MAP_PATH:String = "data/packages.xml";
		
		[Inject]
		public var contentsModel:ContentsModel;
		
		public function LoadConfigCommand() 
		{
			super();
		}
		
		override public function execute():void 
		{
			load(PACK_MAP_PATH);
		}
		
		override protected function onComplete(result:*):void 
		{
			var data:XML = new XML(result);
			contentsModel.parse(data);
		}	
	}
}