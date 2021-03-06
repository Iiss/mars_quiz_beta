package mvc.mediators 
{
	import com.greensock.TweenNano;
	import flash.display.DisplayObjectContainer;
	import flash.events.MouseEvent;
	import mvc.events.ModelEvent;
	import mvc.events.QuizEvent;
	import mvc.models.QuizModel;
	import mvc.models.TaskModel;
	import mvc.views.Quiz;
	import mx.controls.Button;
	import robotlegs.bender.bundles.mvcs.Mediator;
	import spark.components.Button;
	import mvc.renderers.StringAnswerRenderer;
	/**
	 * ...
	 * @author liss
	 */
	public class QuizMediator extends Mediator 
	{
		[Inject]
		public var quizModel:QuizModel;
		
		[Inject]
		public var view:Quiz;
		
		private var _parent:DisplayObjectContainer;
		
		public function QuizMediator() 
		{
			super();
		}
		
		override public function initialize():void 
		{
			super.initialize();
			
			//MODEL
			eventMap.mapListener(quizModel, ModelEvent.PROPERTY_CHANGED, onQuizModelChanged);
			dispatch(new QuizEvent(QuizEvent.QUIZ_READY));
		}
		
		private function onQuizModelChanged(e:ModelEvent):void
		{
			switch(e.propertyName)
			{
				case "currentIndex":
					updateQuizPage();
					break;
			}
		}
		
		private function updateQuizPage():void
		{
			var task:TaskModel = quizModel.currentTask;
			
			if (task)
			{
				eventMap.mapListener(view.answers_list, MouseEvent.CLICK, _onAnswerClick);
				
				view.quiestion_txt.text = task.question;
				view.answers_list.dataProvider = task.answers;
			//	view.task_img.source = task.img; //--temporary disabled
				view.task_group.enabled = true;
			}
		}
		
		private function _onAnswerClick(e:MouseEvent):void
		{
			var btn:spark.components.Button = (e.target as spark.components.Button);
			if (!btn) return;
			
			view.task_group.enabled = false;
			
			eventMap.unmapListener(view.answers_list, MouseEvent.CLICK, _onAnswerClick);
			
			var quizEvent:QuizEvent = new QuizEvent(QuizEvent.ANSWER_SELECTED);
				quizEvent.key = view.answers_list.selectedIndex;
				dispatch(quizEvent);
				
			
			_parent = btn.parent.parent;
			(_parent.getChildAt(quizModel.currentTask.key) as StringAnswerRenderer).currentState='correct';
			
			if (!(quizModel.currentTask && (quizModel.currentTask.key == quizEvent.key)))
			{
				(btn.parent as StringAnswerRenderer).currentState='error';
			}
			
			TweenNano.delayedCall(1, _dispatchNext);
		}
		
		private function _dispatchNext():void
		{
			if (_parent)
			{
				for (var i:int = 0; i < _parent.numChildren; i++)
				{
					(_parent.getChildAt(i) as StringAnswerRenderer).currentState = 'default';
				}
			}
			
			dispatch(new QuizEvent(QuizEvent.SHOW_NEXT_TASK));
		}
	
	}

}