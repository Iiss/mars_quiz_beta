package mvc.mediators 
{
	import flash.events.MouseEvent;
	import mvc.events.QuizEvent;
	import mvc.models.QuizModel;
	import mvc.views.IntroView;
	import org.osmf.events.TimeEvent;
	import robotlegs.bender.bundles.mvcs.Mediator;
	/**
	 * ...
	 * @author liss
	 */
	public class IntroViewMediator extends Mediator
	{
		private static const INTRO_BASE_URL:String='data/video/';
		private static const INTRO_EXTENSION:String='.flv';
		
		
		[Inject]
		public var quizModel:QuizModel;
		
		[Inject]
		public var view:IntroView;
		
		public function IntroViewMediator() 
		{
			
		}
		
		override public function initialize():void 
		{
			eventMap.mapListener(view.skipBtn, MouseEvent.MOUSE_DOWN, _onSkip);
			eventMap.mapListener(view.videoIntro, TimeEvent.COMPLETE, _onSkip);
			view.videoIntro.source = INTRO_BASE_URL+quizModel.id+INTRO_EXTENSION;
		}
		
		private function _onSkip(e:*=null):void
		{
			view.videoIntro.stop();
			dispatch(new QuizEvent(QuizEvent.QUIZ_START));
		}
		
	}

}