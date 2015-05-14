package mvc.mediators 
{
	import mvc.events.QuizEvent;
	import robotlegs.bender.bundles.mvcs.Mediator;
	import mvc.views.ScreenSaverView;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author liss
	 */
	public class ScreenSaverMediator extends Mediator
	{
		[Inject]
		public var view:ScreenSaverView;
		
		public function ScreenSaverMediator() 
		{
			
		}
		
		override public function initialize():void 
		{
			super.initialize();
			eventMap.mapListener(view.stage, MouseEvent.CLICK, _removeScreenSaver);
		}
		
		private function _removeScreenSaver(e:*=null):void
		{
			dispatch(new QuizEvent(QuizEvent.QUIZ_REPLAY));
		}
		
	}

}