package manager
{
	import com.maclema.mysql.Connection;
	import com.maclema.mysql.events.MySqlErrorEvent;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;

	public class DBManager
	{
		static private var _instance:DBManager;
		
		private var _conn:Connection;
		
		public function DBManager()
		{
			if( _instance )
				throw Error("");
			_instance = this;
			
		}
		
		static public function get instance():DBManager
		{
			if( !_instance )
				_instance = new DBManager();
			return _instance;
		}
		
		/**
		 * 连接服务器 
		 * @param host
		 * @param port
		 * @param user
		 * @param password
		 * @param database
		 * @return 
		 * 
		 */
		public function connect( host:String,port:int,user:String,password:String,database:String,completeCallBack:Function = null,sqlErrCallBack:Function = null,ioErrCallBack:Function = null ,closeCallBack:Function = null ):void
		{
			if( this._conn && this._conn.connected )
				this.disconnect();
			this._conn = new Connection( host,port,user,password,database );
			this._conn.addEventListener(Event.CONNECT,completeCallBack );
			if( sqlErrCallBack != null )
				this._conn.addEventListener(MySqlErrorEvent.SQL_ERROR, sqlErrCallBack );
			if( ioErrCallBack != null )
				this._conn.addEventListener(IOErrorEvent.IO_ERROR,ioErrCallBack );
			if( closeCallBack != null )
				this._conn.addEventListener(Event.CLOSE,closeCallBack);
			this._conn.connect();
		}
		
		/**
		 * 断开连接 
		 * 
		 */
		public function disconnect( ):void
		{
			if( this._conn.connected )
				this._conn.disconnect();
		}
		
		/**
		 * 判断连接状态 
		 * @return 
		 * 
		 */
		public function isConnected():Boolean
		{
			var connected:Boolean = false;
			if( this._conn != null )
				connected = this._conn.connected;
			return connected;
			
		}
	}
}