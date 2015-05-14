package mvc.mediators 
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.getTimer;
	import mvc.events.QuizEvent;
	import mvc.models.ChapterModel;
	import mvc.models.ContentsModel;
	import mvc.views.Contents;
	import robotlegs.bender.bundles.mvcs.Mediator;
	/**
	 * ...
	 * @author liss
	 */
	public class ContentsMediator extends Mediator 
	{
		[Inject]
		public var view:Contents;
		
		[Inject]
		public var contentsModel:ContentsModel
		
		private static const SCREENSAVER_DELAY:int = 300000;
		private var time:int;
		
		public function ContentsMediator() 
		{
			super();
		}
		
		override public function initialize():void 
		{
			super.initialize();
			
			time = getTimer();
			
			//MODEL
			eventMap.mapListener(contentsModel, Event.CHANGE, _onContentsChanged);
			eventMap.mapListener(view, Event.ENTER_FRAME, _onEnterFrame);
			eventMap.mapListener(view.stage, MouseEvent.CLICK, _onStageClick);
			
			//VIEW
			eventMap.mapListener(view.contentsList, MouseEvent.MOUSE_DOWN, _onChapterClick);
		}
		
		private function _onChapterClick(e:MouseEvent):void
		{
			if (view.contentsList.selectedItem)
			{
				var quizEvent:QuizEvent = new QuizEvent(QuizEvent.THEME_SELECTED);
				quizEvent.quizId = (view.contentsList.selectedItem as ChapterModel).id;
				
				view.contentsList.selectedItem = null;
				
				dispatch(quizEvent);
			}
		}
		
		private function _onContentsChanged(e:*):void
		{
			view.contentsList.dataProvider = contentsModel.chapters;
		}
		
		private function _onStageClick(e:MouseEvent):void
		{
			time = getTimer();
		}
		
		private function _onEnterFrame(e:Event):void
		{
			if ((getTimer() - time) > SCREENSAVER_DELAY)
			{
				//call screensaver
				dispatch(new QuizEvent(QuizEvent.SHOW_SCREENSAVER));
			}
		}
	}

}