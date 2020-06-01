/**
 * @version 3.2.0.1
 */
package jnit.com.util;

import java.util.TimerTask;


public class TimeoutProcessKiller extends TimerTask  {
	
	private Process p;

	public TimeoutProcessKiller(Process p) {
		this.p = p;
	}

	@Override
	public void run() {
		p.destroy();
	}
}
