package mvc.commands 
{
	import eu.alebianco.robotlegs.utils.impl.SequenceMacro;
	/**
	 * ...
	 * @author liss
	 */
	public class StartupCommand extends SequenceMacro 
	{
		public function StartupCommand() 
		{
			
		}
		
		override public function prepare():void 
		{
			add(ShowNextTaskCommand);
			add(StartTimerCommand);
		}
		
	}

}