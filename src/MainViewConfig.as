package  
{
	import mvc.commands.InitThemeCommand;
	import mvc.commands.LoadConfigCommand;
	import mvc.commands.LoadQuizCommand;
	import mvc.commands.ReplayCommand;
	import mvc.commands.ShowNextTaskCommand;
	import mvc.commands.ShowScreenSaverCommand;
	import mvc.commands.StartupCommand;
	import mvc.commands.UpdateScoreCommand;
	import mvc.events.QuizEvent;
	import mvc.mediators.ContentsMediator;
	import mvc.mediators.IntroViewMediator;
	import mvc.mediators.MainMediator;
	import mvc.mediators.QuizMediator;
	import mvc.mediators.ScoreScreenMediator;
	import mvc.mediators.ScreenSaverMediator;
	import mvc.mediators.TimerViewMediator;
	import mvc.models.ContentsModel;
	import mvc.models.QuizModel;
	import mvc.views.Contents;
	import mvc.views.IntroView;
	import mvc.views.Quiz;
	import mvc.views.ScoreScreen;
	import mvc.views.ScreenSaverView;
	import mvc.views.TimerView;
	import robotlegs.bender.extensions.contextView.ContextView;
	import robotlegs.bender.extensions.directCommandMap.api.IDirectCommandMap;
	import robotlegs.bender.extensions.eventCommandMap.api.IEventCommandMap;
	import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;
	import robotlegs.bender.framework.api.IConfig;
	import robotlegs.bender.framework.api.IInjector;
	/**
	 * ...
	 * @author liss
	 */
	public class MainViewConfig implements IConfig
	{
		[Inject]
		public var injector:IInjector;

		[Inject]
		public var mediatorMap:IMediatorMap;

		[Inject]
		public var eventCommandMap:IEventCommandMap;

		[Inject]
		public var directCommandMap:IDirectCommandMap;
		
		[Inject]
		public var contextView:ContextView;
		
		
		public function MainViewConfig() 
		{
			
		}
		
		public function configure():void
		{
			//MODELS
			injector.map(ContentsModel).toValue(new ContentsModel);
			injector.map(QuizModel).toValue(new QuizModel);
			
			//MEDIATORS
			mediatorMap.map(Main).toMediator(MainMediator);
			mediatorMap.map(Contents).toMediator(ContentsMediator);
			mediatorMap.map(Quiz).toMediator(QuizMediator);
			mediatorMap.map(ScoreScreen).toMediator(ScoreScreenMediator);
			mediatorMap.map(TimerView).toMediator(TimerViewMediator);
			mediatorMap.map(IntroView).toMediator(IntroViewMediator);
			mediatorMap.map(ScreenSaverView).toMediator(ScreenSaverMediator);
			
			//Events
			eventCommandMap.map(QuizEvent.THEME_SELECTED, QuizEvent).toCommand(InitThemeCommand);
			eventCommandMap.map(QuizEvent.QUIZ_START, QuizEvent).toCommand(LoadQuizCommand);
			eventCommandMap.map(QuizEvent.ANSWER_SELECTED, QuizEvent).toCommand(UpdateScoreCommand);
			eventCommandMap.map(QuizEvent.SHOW_NEXT_TASK, QuizEvent).toCommand(ShowNextTaskCommand);
			eventCommandMap.map(QuizEvent.QUIZ_READY, QuizEvent).toCommand(StartupCommand);
			eventCommandMap.map(QuizEvent.QUIZ_REPLAY, QuizEvent).toCommand(ReplayCommand);
			eventCommandMap.map(QuizEvent.SHOW_SCREENSAVER, QuizEvent).toCommand(ShowScreenSaverCommand);
			
			//Commands
			directCommandMap.map(LoadConfigCommand).execute();
		}
		
	}

}