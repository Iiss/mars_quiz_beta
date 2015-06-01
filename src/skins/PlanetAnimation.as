package skins 
{
	import flash.events.Event;
	import mx.core.UIComponent;
	/**
	 * ...
	 * @author liss
	 */
	public class PlanetAnimation extends UIComponent
	{
		public function PlanetAnimation() 
		{
			super ();
			
			var mc:PlanetMC = new PlanetMC();
			explicitHeight = mc.height;
			explicitWidth = mc.width;

			addChild (mc);	
		}
	}
}