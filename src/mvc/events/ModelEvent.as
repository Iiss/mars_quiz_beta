package mvc.events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author liss
	 */
	public class ModelEvent extends Event 
	{
		public static const PROPERTY_CHANGED:String = "mvc.events.ModelEvent.PROPERTY_CHANGED";
		public var propertyName:String;
		
		public function ModelEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
		} 
		
		public override function clone():Event 
		{ 
			return new ModelEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("ModelEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}