package services 
{
	import mx.controls.Alert;
	/**
	 * ...
	 * @author liss
	 */
	public class ErrorReportService 
	{
		public static function reportError(e:*):void
		{
			Alert.show(e.toString());
		}
	}
}