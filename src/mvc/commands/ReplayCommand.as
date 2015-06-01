package mvc.commands 
{
	import robotlegs.bender.bundles.mvcs.Command;
	import robotlegs.bender.extensions.contextView.ContextView;
	import mvc.models.QuizModel;
	/**
	 * ...
	 * @author liss
	 */
	public class ReplayCommand extends Command
	{
		[Inject]
		public var contextView:ContextView;
		
		[Inject]
		public var quizModel:QuizModel;
		
		public function ReplayCommand() 
		{
			
		}
		
		override public function execute():void 
		{
			quizModel.unlock();
			
			var a:*= contextView.view as App;
			if (a) a.currentState = "default";
			
			super.execute();
		}
		
	}

}