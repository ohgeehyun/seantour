/**
 * @version 3.2.0.1
 */
package jnit.sysinfo;

import java.io.File;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.hyperic.sigar.CpuPerc;
import org.hyperic.sigar.FileSystem;
import org.hyperic.sigar.FileSystemUsage;
import org.hyperic.sigar.Mem;
import org.hyperic.sigar.Sigar;
import org.hyperic.sigar.SigarException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import egovframework.com.cmm.service.EgovProperties;
import jnit.cms.handler.CmsHandler;

@Controller
public class SysinfoController {
	
	private Log log = LogFactory.getLog(getClass());
	
    /**
	 * System Infomation
	 */
    @RequestMapping(value="/cms/sysinfo/main.do")
    public String main(
    		HttpServletRequest request, 
    		ModelMap model)
            throws Exception {
    	
    	
    	
    	return "/jnit/sysinfo/main";
	}
    
    
    /**
     * 시스템 모니터링 정보를 제공한다.
     * @param type - String 모니터링 타입 (cpu, mem, hdd, all)
     * @return data - String 사용량  %
     * @exception Exception
     */
    
    @RequestMapping("/cms/sysinfo/get.do")
    public String getSysinfo(
    	@RequestParam("type") String type,
    	ModelMap model)throws Exception{
    	try{
	    	Sigar sigar = new Sigar ();
	    	int usePer = 0;
	    	
	    	if(type.equals("cpu")) {
		    	CpuPerc cpu; 
		    	cpu = sigar.getCpuPerc ();
		    	usePer = (int)(100 * cpu.getCombined());
	    	}else if(type.equals("mem")) {
	    		Mem mem;
	    		mem = sigar.getMem();
	    		double freeMem = (double)mem.getFree();
	    		double totalMem = (double)mem.getTotal();
	    		
	    		usePer = 100 - (int)(100 * (freeMem / totalMem));
	    		//usePer = (int)mem.getUsedPercent();
	    	}else if(type.equals("hdd")) {
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
	    			usePer = (int)(100 * (total / fscount));
	    		}
	    	}else if(type.equals("all")) {
	    		int useCpuPer = 0;
	    		int useMemPer = 0;
	    		int useHddPer = 0;
	    		
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
	    		
	        	model.addAttribute("msg", "{\"cpu\":"+useCpuPer+",\"mem\":"+useMemPer+",\"hdd\":"+useHddPer+"}");
	        	//log.debug("'cpu':"+useCpuPer+"%,'mem':"+useMemPer+"%,'hdd':"+useHddPer+"%");
	        	
	        	return "jnit/msg";
	    	}
	    	
	    	model.addAttribute("msg", usePer);
	    	//log.debug(type + ": usage " + usePer + "%");
    	}catch(java.lang.UnsatisfiedLinkError e){
    		//log.error(e.getMessage());
    	}
    	return "jnit/msg";
    }
    
    /**
     * 시스템 모니터링 정보를 제공한다.
     * @param type - String 모니터링 타입 (cpu, mem, hdd, all)
     * @return data - String 사용량  %
     * @exception Exception
     */
    
    @RequestMapping("/cms/sysinfo/netlog.do")
    public String getNetlog(
    	ModelMap model)
    	throws Exception {

    	//log.debug(EgovProperties.getProperty("Globals.netlogs"));
    	File f = new File(EgovProperties.getProperty("Globals.netlogs"));
    	if(f.exists()) {
    		String ret = "";
    		String ret1 = "";
    		
    		ret1 = CmsHandler.readFile(EgovProperties.getProperty("Globals.netlogs"));
    		String[] retAr = ret1.split("\n");
    		for(int i=0; i<retAr.length; i++) {
    			ret += "['"+((i%5) == 0 ? 60-i : "")+"', "+retAr[i]+"],";
    		}
    		
    		model.addAttribute("msg", "[['Name', 'Process'],"+ret+"]");	
    	}else {
    		model.addAttribute("msg", "[['Name', 'Process']]");
    	}
    	
    	return "jnit/msg";
	}
}
