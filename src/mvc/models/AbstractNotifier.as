package mvc.models 
{
	import flash.events.EventDispatcher;
	import mvc.events.ModelEvent;
	/**
	 * ...
	 * @author liss
	 */
	public class AbstractNotifier extends EventDispatcher 
	{
		protected function notifyPropertyChanged(propertyName:String):void
		{
			var e:ModelEvent = new ModelEvent(ModelEvent.PROPERTY_CHANGED);
			e.propertyName = propertyName;
				
			dispatchEvent(e);
		}
	}

}