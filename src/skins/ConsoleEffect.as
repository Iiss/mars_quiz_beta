package skins 
{
	/**
	 * ...
	 * @author liss
	 */
	public class ConsoleEffect 
	{
		import flash.events.TimerEvent;
		import flash.utils.Timer;
		
		private var _timer:Timer;
		private var _messages:Array;
		private var _targets:Array;
		private var _output:Array;
		
		public function ConsoleEffect() 
		{
			
		}
		
		public function play(charDelay:int,targets:Array,messages:Array):void
		{
			if (_timer != null && _timer.running) _stopTimer();
			
			_targets = targets;
			_messages = messages;
			
			_output = _messages[0].split('');
			
			_timer = new Timer(charDelay);
			_startTimer();
			
		}
		
		public function stop():void
		{
			_stopTimer();
			_targets = null;
			_messages = null;
			_output = null;		
		}
		
		private function _startTimer():void
		{
			_timer.addEventListener(TimerEvent.TIMER, _update);
			_timer.start();
		}
		
		private function _stopTimer():void
		{
			_timer.stop();
			_timer.removeEventListener(TimerEvent.TIMER, _update);
			_timer = null;
		}
		
		private function _update(e:TimerEvent):void
		{
			if(!_output || _output.length==0)
			{	
				_targets.shift();
				_messages.shift();
				
				if (_targets.length == 0)
				{
					stop();
					return;
				}
				
				_output = _messages[0].split('');
			}
			
			_targets[0].text+=_output.shift();
		}
	}
}