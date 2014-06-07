package
{
	import flash.display.Sprite;
	import flash.display.Stage;

	/**
	 *
	 * @author warden feng 2013-5-28
	 */
	public class UIAllRefer
	{
		public static var stage:Stage;
		
		/** 游戏实体 */
		public static var game:Game;
		
		/** 游戏宽度 */
		public static var gameWidth:int = 1000;
		
		/** 游戏高度 */
		public static var gameHeight:int = 580;
		
		/** 提示框层 */
		public static const tipLayer:Sprite = new Sprite();

		/** 提示信息层 */
		public static const infoLayer:Sprite = new Sprite();
		
		/** 提示框层 */
		public static const promptBoxLayer:Sprite = new Sprite();
		
		/** 弹窗层 */
		public static const popLayer:Sprite = new Sprite();

		/** 内容层 */
		public static const contentLayer:Sprite = new Sprite();

		/** 场景层 */
		public static const sceneLayer:Sprite = new Sprite();

		/** 背景层  */
		public static const backLayer:Sprite = new Sprite();
	}
}
