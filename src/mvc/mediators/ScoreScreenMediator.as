package mvc.mediators 
{
	import mvc.events.QuizEvent;
	import mvc.models.QuizModel;
	import robotlegs.bender.bundles.mvcs.Mediator;
	import mvc.views.ScoreScreen;
	import mvc.events.ModelEvent;
	import flash.events.Event;
	import flash.utils.getTimer;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author liss
	 */
	public class ScoreScreenMediator extends Mediator
	{
		private const RESTART_DELAY:int=10000;
		
		[Inject]
		public var quizModel:QuizModel;
		
		[Inject]
		public var view:ScoreScreen;
		
		private var time:Number;
		
		public function ScoreScreenMediator() 
		{
			
		}
		
		override public function initialize():void 
		{
			super.initialize();
			
			eventMap.mapListener(quizModel, ModelEvent.PROPERTY_CHANGED, _onModelChanged);
			eventMap.mapListener(view, Event.ENTER_FRAME, _onEnterFrame);
			eventMap.mapListener(view.replay_btn, MouseEvent.CLICK, _replay);
			
			time = getTimer();
			
			if (quizModel)
			{
				view.updateScore(quizModel);
			}
		}
		
		private function _onModelChanged(e:ModelEvent):void
		{
			switch(e.propertyName)
			{
				case "score":
					view.updateScore(quizModel);
					break;
					
				case "quizList":
					view.updateScore(quizModel);
					break;
			}
		}
		
		private function _onEnterFrame(e:Event):void
		{
			if (getTimer() - time >= RESTART_DELAY)
			{
				_replay()
			};
		}
		
		private function _replay(e:*= null):void
		{
			dispatch(new QuizEvent(QuizEvent.QUIZ_REPLAY));
		}
	}
}