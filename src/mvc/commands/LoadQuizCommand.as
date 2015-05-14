package mvc.commands 
{
	import mvc.models.QuizModel;
	import robotlegs.bender.extensions.contextView.ContextView;
	/**
	 * ...
	 * @author liss
	 */
	public class LoadQuizCommand extends LoadCommandBase 
	{
		public static const QUIZ_URL_BASE:String = "data/quiz/";
		public static const QUIZ_EXTENSION:String = ".xml";
		
		[Inject]
		public var contextView:ContextView;
		
		[Inject]
		public var quizModel:QuizModel;
		
		public function LoadQuizCommand() 
		{
			super();
		}
		
		override public function execute():void 
		{
			var a:*= contextView.view as Main;
			if (a) a.currentState = "loading_state";
			
			var url:String = QUIZ_URL_BASE + quizModel.id + QUIZ_EXTENSION;
			load(url);
		}
		
		override protected function onComplete(result:*):void 
		{
			var data:XML = new XML(result);
			quizModel.parse(data);
			
			var a:*= contextView.view as Main;
			if (a) a.currentState = "quiz_ready_state";
		}
		
	}

}