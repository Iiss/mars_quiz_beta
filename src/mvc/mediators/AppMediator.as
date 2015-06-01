package mvc.mediators 
{
	import mvc.events.QuizEvent;
	import mvc.models.QuizModel;
	import robotlegs.bender.bundles.mvcs.Mediator;
	/**
	 * ...
	 * @author liss
	 */
	public class AppMediator extends Mediator 
	{
		[Inject]
		public var view:App;
		
		[Inject]
		public var quizModel:QuizModel;
		
		public function AppMediator() 
		{
			
		}
		
		override public function initialize():void 
		{
			eventMap.mapListener(quizModel, QuizEvent.QUIZ_FINISHED, _onQuizFinish);
			super.initialize();
		}
		
		private function _onQuizFinish(e:QuizEvent):void
		{
			view.currentState = "quiz_finish_state";
		}
	}
}