package mvc.commands 
{
	import robotlegs.bender.bundles.mvcs.Command;
	import robotlegs.bender.extensions.contextView.ContextView;
	/**
	 * ...
	 * @author liss
	 */
	public class PlayIntroCommand extends Command
	{
		[Inject]
		public var contextView:ContextView;
		
		public function PlayIntroCommand() 
		{
			
		}
		
		override public function execute():void 
		{
			var a:*= contextView.view as Main;
			if (a) a.currentState = "intro_state";	
		}
		
	}

}