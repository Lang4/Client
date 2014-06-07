package communication.arpg
{
	import com.netease.protobuf.Message;
	
	import modules.GameDispatcher;
	import modules.moveaction.MoveActionEvent;
	
	import protobuf.ASPKG_CAST_SKILL_REQ;
	import protobuf.ASPKG_CHAT_REQ;
	import protobuf.ASPKG_MOVE_REQ;
	import protobuf.E_ATTACK_TYPE;

	/**
	 * 发送对麻将服务器的请求
	 * @author xumin.xu
	 */
	public class ArpgMsgSender
	{
		private static var _instance:ArpgMsgSender;

		private var slotSocket:ArpgSocket;

		public static function get instance():ArpgMsgSender
		{
			return _instance;
		}

		public static function init(slotSocket:ArpgSocket):void
		{
			if (_instance == null)
			{
				logger("初始化麻将消息发送者");
				_instance = new ArpgMsgSender(slotSocket);
			}
		}

		public function ArpgMsgSender(slotSocket:ArpgSocket)
		{
			addListeners();
			this.slotSocket = slotSocket;
		}

		private function get dispatcher():GameDispatcher
		{
			return GameDispatcher.instance;
		}

		private function send(msgId:String, message:Message):void
		{
			slotSocket.send(msgId, message);
		}

		private function addListeners():void
		{
			dispatcher.addEventListener(MoveActionEvent.HERO_START_MOVE, OnHeroMoveReq);
			dispatcher.addEventListener(ARPGProto.ASID_CAST_SKILL_REQ, OnRecvCastSkillReq);
			dispatcher.addEventListener(ARPGProto.ASID_CHAT_REQ, OnRecvChatReq);

		}

		private function OnHeroMoveReq(event:MoveActionEvent):void
		{
			var moveReq:ASPKG_MOVE_REQ = new ASPKG_MOVE_REQ();
			moveReq.mapX = event.data.mapX;
			moveReq.mapY = event.data.mapY;

			send(ARPGProto.ASID_MOVE_REQ, moveReq);
		}

		private function OnRecvCastSkillReq(event:ArpgMsgEvent):void
		{
			var castSkillReq:ASPKG_CAST_SKILL_REQ = new ASPKG_CAST_SKILL_REQ();
			castSkillReq.skillId = event.data.skillId;

			if (event.data.targetAnimals && event.data.targetAnimals.length > 0)
			{
				castSkillReq.type = E_ATTACK_TYPE.PLALER;
				castSkillReq.targetId = event.data.targetAnimals[0];
				castSkillReq.mapX = 0;
				castSkillReq.mapY = 0;
			}
			else
			{
				castSkillReq.type = E_ATTACK_TYPE.POINT;
				castSkillReq.targetId = 0;
				castSkillReq.mapX = event.data.mapX;
				castSkillReq.mapY = event.data.mapY;
			}
			send(ARPGProto.ASID_CAST_SKILL_REQ, castSkillReq);
		}

		private function OnRecvChatReq(event:ArpgMsgEvent):void
		{
			var chatReq:ASPKG_CHAT_REQ = new ASPKG_CHAT_REQ();
			chatReq.msg = event.data.msg;
			send(ARPGProto.ASID_CHAT_REQ,chatReq);
		}
		
	}
}
