package modules.scenemap
{

	/**
	 *
	 * @author 风之守望者 2012-7-2
	 */
	public class Scenemap
	{
		public static var isInit:Boolean = false;

		public static var isShow:Boolean = false;

		private static var scenemapUIManager:ScenemapUIManager;

		public static function init():void
		{
			scenemapUIManager || (scenemapUIManager = new ScenemapUIManager());
		}
	}
}