package mvc.commands 
{
	import mvc.events.QuizEvent;
	import mvc.models.QuizModel;
	import robotlegs.bender.bundles.mvcs.Command;
	import robotlegs.bender.extensions.directCommandMap.api.IDirectCommandMap;
	import services.SettingsService;
	/**
	 * ...
	 * @author liss
	 */
	public class InitThemeCommand extends Command
	{
		[Inject]
		public var directCommandMap:IDirectCommandMap;
		
		[Inject]
		public var quizEvent:QuizEvent
		
		[Inject]
		public var quizModel:QuizModel;
		
		public function InitThemeCommand() 
		{
			
		}
		
		override public function execute():void 
		{
			quizModel.id = quizEvent.quizId;
		
			if (SettingsService.skipIntro)
			{
				directCommandMap.map(LoadQuizCommand).execute();
			}
			else
			{
				directCommandMap.map(PlayIntroCommand).execute()
			}
		}	
	}
}