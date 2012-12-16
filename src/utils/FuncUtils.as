/**
 -- User: jianzi
 -- Date: 2012-12-15
 */
package utils
{
	import data.DatabaseConf;
	
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.utils.ByteArray;

	public class FuncUtils
	{
		/** 从程序当前目录读取配置文件 */
		static public function readConfig( fileName:String ):DatabaseConf
		{ 
			var file:File = File.applicationDirectory.resolvePath( fileName );
			if(!file.exists)
				return null;
			var fs:FileStream = new FileStream();
			fs.open(file, FileMode.READ);
			var str:String = fs.readUTFBytes(fs.bytesAvailable);
			fs.close();
			var xml:XML = new XML(str);
			var conf:DatabaseConf = new DatabaseConf();
			conf.host = xml.host;
			conf.port = xml.port.toString();
			conf.user = xml.user;
			conf.password = xml.password;
			conf.database = xml.database;
			return conf;
		} 
		
		/**
		 * 读取文件 
		 * @param file
		 * @return 
		 * 
		 */
		static public function readFile(file:File):ByteArray
		{
			var fs:FileStream = new FileStream();
			try{
				fs.open(file,FileMode.READ);
			} catch( e:Error ) {
				//trace( "读取文件失败:" + file.,e.message );
			}
			var bytes:ByteArray = new ByteArray();
			fs.readBytes(bytes);
			fs.close();
			return bytes;
		}
		
		/**
		 * 写入文件
		 * @param file
		 * @return 
		 * 
		 */
		static public function writeFile( fileName:String ,content:String ):void
		{
			//var file:File =  File.applicationDirectory.resolvePath( fileName );
			var file:File = new File(File.applicationDirectory.resolvePath(fileName).nativePath);
			var fs:FileStream = new FileStream();
			fs.open(file, FileMode.UPDATE);
			fs.writeUTFBytes(content);
			fs.close();
		}
		
		/**
		 * 生成二进制文件 
		 * @param file
		 * @param bytes
		 */
		static public function writeBinFile( file:File,bytes:ByteArray ):void
		{
			if (!bytes)
				return;
			bytes.position = 0;
			
			var fs:FileStream = new FileStream();
			fs.open(file,FileMode.WRITE);
			fs.writeBytes(bytes);
			fs.close();
		}
	}
}