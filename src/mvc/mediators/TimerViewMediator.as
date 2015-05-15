package mvc.mediators 
{
	import mvc.events.QuizEvent;
	import mvc.models.QuizModel;
	import mvc.views.TimerView;
	import robotlegs.bender.bundles.mvcs.Mediator;
	/**
	 * ...
	 * @author liss
	 */
	public class TimerViewMediator extends Mediator
	{
		[Inject]
		public var view:TimerView;
		
		[Inject]
		public var quizModel:QuizModel;
		
		public function TimerViewMediator() 
		{
			
		}
		
		override public function initialize():void 
		{
			super.initialize();
			eventMap.mapListener(quizModel, QuizEvent.QUIZ_TIMER, _update);
			_update();
		}
		
		private function _update(e:*=null):void
		{
			var min:int = 0;
			var sec:int = 0;
			
			if (quizModel)
			{
				min = Math.abs(quizModel.time / 60000);
				sec = Math.abs(quizModel.time % 60000) / 1000;
			}
			
			var minStr:String = min > 9 ? min.toString(): '0' + min.toString();
			var secStr:String = sec > 9 ? sec.toString(): '0' + sec.toString();
			
			view.min_label.text = minStr;
			view.sec_label.text = secStr;
		}
	}
}