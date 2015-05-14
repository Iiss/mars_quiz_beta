package mvc.events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author liss
	 */
	public class QuizEvent extends Event 
	{
		public static const THEME_SELECTED:String = "QuizEvent.THEME_SELECTED";
		public static const QUIZ_START:String = "QuizEvent.QUIZ_START";
		public static const QUIZ_READY:String = "QuizEvent.QUIZ_READY";
		public static const ANSWER_SELECTED:String = "QuizEvent.ANSWER_SELECTED";
		public static const SHOW_NEXT_TASK:String = "QuizEvent.SHOW_NEXT_TASK";
		public static const QUIZ_FINISHED:String = "QuizEvent.QUIZ_FINISHED";
		public static const QUIZ_TIMER:String = "QuizEvent.QUIZ_TIMER";
		public static const QUIZ_REPLAY:String = "QuizEvent.QUIZ_REPLAY";
		public static const SHOW_SCREENSAVER:String = "QuizEvent.SHOW_SCREENSAVER";
		
		public var quizId:String;
		public var key:int=-1;

		public function QuizEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);		
		} 
		
		public override function clone():Event 
		{ 
			return new QuizEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("QuizEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}