package mvc.mediators 
{
	import mvc.events.QuizEvent;
	import mvc.models.QuizModel;
	import robotlegs.bender.bundles.mvcs.Mediator;
	/**
	 * ...
	 * @author liss
	 */
	public class MainMediator extends Mediator 
	{
		[Inject]
		public var view:Main;
		
		[Inject]
		public var quizModel:QuizModel;
		
		public function MainMediator() 
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