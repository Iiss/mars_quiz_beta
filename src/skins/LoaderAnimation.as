package skins 
{
	import mx.core.IUIComponent;
	import mx.core.UIComponent;
	
	/**
	 * ...
	 * @author liss
	 */
	public class LoaderAnimation extends UIComponent
	{
		
		public function LoaderAnimation() 
		{
			super ();
			
			var loader:LoadIndicator = new LoadIndicator();
			explicitHeight = loader.height;
			explicitWidth = loader.width;

			addChild (loader);
		}	
	}
}