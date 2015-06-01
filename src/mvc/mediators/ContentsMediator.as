package mvc.mediators 
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.getTimer;
	import mvc.events.QuizEvent;
	import mvc.models.ChapterModel;
	import mvc.models.ContentsModel;
	import mvc.views.Contents;
	import mx.collections.ArrayList;
	import mx.core.UIComponent;
	import robotlegs.bender.bundles.mvcs.Mediator;
	import flash.events.FocusEvent;
	import spark.components.Scroller;
	import spark.layouts.VerticalLayout;
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
		private static const INFO_DELAY:int = 10000;
		private static const PAGE_SIZE:int = 5;
		private static var _currentPage:int = 0;
		private static var _totalPages:int = 0;
		private var _pagingUI:Array;
		
		private var time:int;
		private var infoTime:int;
		
		public function ContentsMediator() 
		{
			super();
		}
		
		override public function initialize():void 
		{
			super.initialize();
			
			time = getTimer();
			infoTime = getTimer();
			
			_pagingUI =[view.nexPageBtn,view.prevPageBtn,view.pagesBar]
			
			//MODEL
			eventMap.mapListener(contentsModel, Event.CHANGE, _onContentsChanged);
			eventMap.mapListener(view, Event.ENTER_FRAME, _onEnterFrame);
		//	eventMap.mapListener(view.stage, MouseEvent.CLICK, _onStageClick);
			
			//VIEW
			eventMap.mapListener(view.contentsList, MouseEvent.CLICK, _onChapterClick);
			eventMap.mapListener(view.prevPageBtn, MouseEvent.CLICK, _showPrevPage);
			eventMap.mapListener(view.nexPageBtn, MouseEvent.CLICK, _showNextPage);
			
			view.planet.showNext();
		}
		
		private function _onChapterClick(e:MouseEvent):void
		{
			if (view.contentsList.selectedItem)
			{
				var quizEvent:QuizEvent = new QuizEvent(QuizEvent.THEME_SELECTED);
				quizEvent.quizId = (view.contentsList.selectedItem as ChapterModel).id;
				
				view.contentsList.selectedItem = null;
				view.contentsList.scroller.focusManager.deactivate();
				dispatch(quizEvent);
			}
		}
		
		private function _onContentsChanged(e:*):void
		{
			_totalPages = Math.ceil(contentsModel.chapters.length / PAGE_SIZE);
			
			var markers:ArrayList = new ArrayList();
			for (var i:int = 0; i < _totalPages; i++)
			{
				markers.addItem(i);
			}
			
			validatePagingUI();
			
			view.pagesBar.totalPages = _totalPages;
			gotoPage(0);
		}
		
		private function validatePagingUI():void
		{
			var bigContent:Boolean = contentsModel.chapters.length > PAGE_SIZE;
			
			VerticalLayout(view.contentsList.layout).requestedMinRowCount = bigContent ? 5 : 1;
			
			for (var i:int = 0; i < _pagingUI.length; i++)
			{
				var comp:UIComponent = _pagingUI[i] as UIComponent;
				if (comp)
				{
					comp.visible = comp.includeInLayout = bigContent;
				}		
			}
		}
		
		public function gotoPage(pageNum:int):void
		{
			if (pageNum >= _totalPages)
			{
				pageNum = _totalPages - 1;
			}
			
			if (pageNum < 0)
			{
				pageNum = 0;
			}
			
			_currentPage = pageNum;
			view.pagesBar.selectedIndex = _currentPage;
			
			view.contentsList.dataProvider = new ArrayList(contentsModel.chapters.source.slice(pageNum*PAGE_SIZE, (pageNum+1)*PAGE_SIZE));
		}
		
		private function _showNextPage(e:*=null):void
		{
			_currentPage == _totalPages-1 ? gotoPage(0) : gotoPage(_currentPage + 1);
		}
		
		private function _showPrevPage(e:*=null):void
		{
			_currentPage == 0 ? gotoPage(_totalPages-1) : gotoPage(_currentPage - 1);
		}
		
		private function _showPage(e:MouseEvent):void
		{
			gotoPage(view.pagesBar.selectedIndex);
		}
		
		private function _onStageClick(e:MouseEvent):void
		{
			time = getTimer();
			
		}
		
		private function _onEnterFrame(e:Event):void
		{
			var now:int = getTimer();
			/*if ((getTimer() - time) > SCREENSAVER_DELAY)
			{
				//call screensaver
				dispatch(new QuizEvent(QuizEvent.SHOW_SCREENSAVER));
			}*/
			
			if ((now - infoTime) > INFO_DELAY)
			{
				view.planet.showNext();
				infoTime = now;
			}
		}
		
	}

}