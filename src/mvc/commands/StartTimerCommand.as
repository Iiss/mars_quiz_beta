package mvc.commands 
{
	import eu.alebianco.robotlegs.utils.impl.AsyncCommand;
	import mvc.models.QuizModel;
	/**
	 * ...
	 * @author liss
	 */
	public class StartTimerCommand extends AsyncCommand
	{
		[Inject]
		public var quizModel:QuizModel;
		
		public function StartTimerCommand() 
		{
			
		}
		
		override public function execute():void 
		{
			quizModel.start();
		}
		
	}

}