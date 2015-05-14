package mvc.models 
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import mx.collections.ArrayList;
	/**
	 * ...
	 * @author liss
	 */
	public class ContentsModel extends EventDispatcher 
	{
		private var _chapters:ArrayList;
		
		public function ContentsModel() 
		{
			
		}
		
		public function parse(data:XML):void
		{
			_chapters = new ArrayList();
			
			for each (var node:XML in data.children())
			{
				trace(node.toXMLString());
				
				var chapter:ChapterModel = new ChapterModel();
				chapter.id = node.@id;
				chapter.name = node.@name;
				
				_chapters.addItem(chapter);
			}
			
			dispatchEvent(new Event(Event.CHANGE));
		}
		
		public function get chapters():ArrayList
		{
			return _chapters;
		}
		
	}

}