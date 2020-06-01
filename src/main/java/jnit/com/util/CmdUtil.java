/**
 * @version 3.2.0.1
 */
package jnit.com.util;

import java.io.IOException;
import java.util.Timer;
import java.util.TimerTask;

import egovframework.com.cmm.service.EgovProperties;

public class CmdUtil {
	private final static String deDug = EgovProperties.getProperty("Globals.Debug");
	public static void playTouch(String path) throws IOException, InterruptedException{
		
		String cmds[] = {"find", path, "-exec", "touch", "{}", ";"};
		
		Process proc = Runtime.getRuntime().exec(cmds);
		
		Timer t = new Timer();
		TimerTask killer = new TimeoutProcessKiller(proc);
		t.schedule(killer, 15000);	// 15초가 지나도 변환이 완료되지 않을 경우 강제 종료
		
		int exitValue = proc.waitFor();
		killer.cancel();
		
		if("true".equals(deDug)) System.out.println("runtimeResult : " + (exitValue == 0 ? "success" : "failed"));
	}

}