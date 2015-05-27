package mvc.views 
{
	import spark.components.Label;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	/**
	 * ...
	 * @author liss
	 */
	public class ConsoleLabel extends Label 
	{
		private static const DELAY:int=25
		private var _output:Array;
		private var _msg:String;
		private var t:Timer;

		public function ConsoleLabel() 
		{
			super();
			t = new Timer(DELAY);
		}
		
		public function print(msg:String):void
		{
			if(t.running) _stopTimer();
			
			_startTimer();
			
			_msg = msg;
			this.text="";
			_output=msg.split('');
		}
		
		private function _startTimer():void
		{
			t.addEventListener(TimerEvent.TIMER, update);
			t.start();
		}
		
		private function _stopTimer():void
		{
			t.stop();
			t.removeEventListener(TimerEvent.TIMER, update);
		}
		
	}

}