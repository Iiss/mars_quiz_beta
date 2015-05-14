package mvc.commands 
{
	import robotlegs.bender.bundles.mvcs.Command;
	import robotlegs.bender.extensions.contextView.ContextView;
	/**
	 * ...
	 * @author liss
	 */
	public class ReplayCommand extends Command
	{
		[Inject]
		public var contextView:ContextView;
		
		public function ReplayCommand() 
		{
			
		}
		
		override public function execute():void 
		{
			var a:*= contextView.view as Main;
			if (a) a.currentState = "default";
			
			super.execute();
		}
		
	}

}