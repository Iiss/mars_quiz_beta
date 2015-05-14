package mvc.commands 
{
	import mvc.models.QuizModel;
	import robotlegs.bender.bundles.mvcs.Command;
	import robotlegs.bender.extensions.contextView.ContextView;
	/**
	 * ...
	 * @author liss
	 */
	public class ShowNextTaskCommand extends Command 
	{
		[Inject]
		public var quizModel:QuizModel;
		
		[Inject]
		public var contextView:ContextView;
		
		public function ShowNextTaskCommand() 
		{
			
		}
		
		override public function execute():void 
		{
			if (quizModel.quizList && quizModel.quizList.length > 0)
			{
				if (quizModel.currentIndex < quizModel.quizList.length - 1)
				{
					quizModel.currentIndex++;
				}
				else
				{
					quizModel.stop();
				}
			}
		}
		
	}

}