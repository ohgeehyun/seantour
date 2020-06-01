package jnit.cron;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Component;

/**
 * 알리미 실행 크론
 * 
 * @author
 *
 */
@Component
public class JnitCronServerState {
	private Log log = LogFactory.getLog(getClass());
/*
	@Scheduled(cron = "${Globals.CRON.STATE.TIMER}")
	public void excute() {
		log.debug("Server State START.");
		try {
			String currentIp = InetAddress.getLocalHost().getHostAddress();
			// 실행할 서버 IP - 전체 서버가 아닌 한 곳에서만 실행해야 될 때(2중화 등)
			log.debug(currentIp);
			String serverIp = Globals.CRON_EXCUTE_SERVER_IP;
			if (!serverIp.equals(currentIp)) {
				return;
			}
			int useCpuPer = 0;
    		int useMemPer = 0;
    		int useHddPer = 0;
    		
			Sigar sigar = new Sigar ();
			CpuPerc cpu; 
	    	cpu = sigar.getCpuPerc ();
	    	useCpuPer = (int)(100 * cpu.getCombined());
	    	
    		Mem mem;
    		mem = sigar.getMem();
    		double freeMem = (double)mem.getFree();
    		double totalMem = (double)mem.getTotal();
    		
    		useMemPer = 100 - (int)(100 * (freeMem / totalMem));
    		//useMemPer = (int)mem.getUsedPercent();
			
    		FileSystemUsage fsu;
    		FileSystem[] fs;
    		fs = sigar.getFileSystemList();
    		
    		double total = 0;
    		int fscount = 0;
    		try {
	    		for(int i=0; i<fs.length; i++) {
	    			fsu = sigar.getFileSystemUsage(fs[i].getDirName());
	    			//log.debug( fs[i].getDirName() + " : " + fsu.getUsePercent() );
	    			total = total + fsu.getUsePercent();
	    			fscount++;
	    		}
    		}catch(SigarException e) {
    			//log.debug(e.getMessage());
    		}finally {
    			useHddPer = (int)(100 * (total / fscount));
    		}
    		
    		File f = new File(EgovProperties.getProperty("Globals.netlogs"));
        	if(f.exists()) {
        		String ret = "";
        		String ret1 = "";
        		
        		ret1 = CmsHandler.readFile(EgovProperties.getProperty("Globals.netlogs"));
        		String[] retAr = ret1.split("\n");
        		for(int i=0; i<retAr.length; i++) {
        			ret += "['"+((i%5) == 0 ? 60-i : "")+"', "+retAr[i]+"],";
        		}
        		
        		//model.addAttribute("msg", "[['Name', 'Process'],"+ret+"]");	
        	}else {
        		//model.addAttribute("msg", "[['Name', 'Process']]");
        	}
    		
		} catch (Exception e) {
			log.debug("Server State cron error");
			log.error(e.getMessage());
		}
	}
	*/
}
