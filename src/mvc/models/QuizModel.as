package mvc.models 
{
	import flash.utils.Timer;
	import mvc.events.QuizEvent;
	import mx.collections.ArrayList;
	import utils.XMLUtils;
	import flash.events.TimerEvent;
	/**
	 * ...
	 * @author liss
	 */
	public class QuizModel extends AbstractNotifier
	{
		public static const MAX_TASK_COUNT:int = 12;
		private static const UPDATE_INTERVAL:int = 250;
		
		public var id:String;
		
		private var _quizList:ArrayList;
		private var _currentIndex:int;
		private var _score:int;
		private var _timer:Timer;
		private var _totalTime:int;
		private var _time:int;
		private var _startTime:int;
		
		public function QuizModel() 
		{
			
		}
		
		public function parse(data:XML):void
		{
			score = 0;
			currentIndex = -1;
			_quizList = new ArrayList;
			
			data.task = XMLUtils.shuffle(data.task,MAX_TASK_COUNT);
			
			for each (var node:XML in data.task)
			{
				var task:TaskModel = new TaskModel();
				task.question = node.question[0].text();
				task.answers = new ArrayList();
				task.key = parseInt(node.@key.toString());
				
				if (node.img.length() > 0)
				{
					task.img = node.img[0].text();
				}
				
				for each(var answer:XML in node.answers.children())
				{
					task.answers.addItem(answer.toString());
				}
				
				_quizList.addItem(task)
			}
			
			dispatchEvent(new QuizEvent(QuizEvent.QUIZ_READY));
		}
		
		public function get currentIndex():int
		{
			return _currentIndex;
		}
		
		public function set currentIndex(value:int):void
		{
			if (_currentIndex != value)
			{
				_currentIndex = value;
				notifyPropertyChanged("currentIndex");
			}
		}
		
		public function get currentTask():TaskModel
		{
			if (quizList && currentIndex != -1 && currentIndex < quizList.length)
			{
				return quizList.getItemAt(currentIndex) as TaskModel;
			}
			
			return null;
		}
		
		public function get quizList():ArrayList 
		{ 
			return _quizList;
		}
		
		public function get score():int
		{
			return _score;
		}
		
		public function set score(value:int):void
		{
			if (_score != value)
			{
				_score = value;
				notifyPropertyChanged("score");
			}
		}
		
		public function get time():int
		{
			return _time;
		}
		
		public function get totalTime():int
		{
			return _totalTime;
		}
		
		public function stop():void
		{
			_stopTimer();
			dispatchEvent(new QuizEvent(QuizEvent.QUIZ_FINISHED));
		}
		
		public function start(totalSeconds:int=300):void 
		{
			_stopTimer();
			_totalTime = totalSeconds*1000;
			_time = _totalTime;
			_startTime = new Date().getTime();
			
			_timer = new Timer(UPDATE_INTERVAL);
			_timer.addEventListener(TimerEvent.TIMER, _onTimer);
			_timer.start();
			
			dispatchEvent(new QuizEvent(QuizEvent.QUIZ_TIMER));
		}
		
		private function _stopTimer():void 
		{
			if (_timer)
			{
				_timer.removeEventListener(TimerEvent.TIMER, _onTimer);
				_timer.stop();
			}
		}
		
		private function _onTimer(e:TimerEvent):void
		{
			var elapsed:int = (new Date().getTime()) - _startTime;
			_time = _totalTime - elapsed;
			
			if (_time <= 0)
			{
				_time = 0;
				stop();
			}
			
			dispatchEvent(new QuizEvent(QuizEvent.QUIZ_TIMER));
		}
	}
}