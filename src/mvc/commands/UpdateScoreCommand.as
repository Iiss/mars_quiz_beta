package mvc.commands 
{
	import eu.alebianco.robotlegs.utils.impl.AsyncCommand;
	import mvc.models.QuizModel;
	import robotlegs.bender.bundles.mvcs.Command;
	import mvc.events.QuizEvent;
	/**
	 * ...
	 * @author liss
	 */
	public class UpdateScoreCommand extends AsyncCommand
	{
		[Inject]
		public var quizEvent:QuizEvent;
		
		[Inject]
		public var quizModel:QuizModel;
		
		override public function execute():void 
		{
			if (quizModel.currentTask.key == quizEvent.key)
			{
				quizModel.score++;
			}
		}
		
	}

}