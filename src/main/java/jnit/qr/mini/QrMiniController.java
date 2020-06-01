/**
 * @version 3.2.0.1
 */
package jnit.qr.mini;

import java.awt.Image;
import java.awt.image.BufferedImage;
import java.io.BufferedOutputStream;
import java.io.IOException;
import java.util.HashMap;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.com.cmm.service.EgovProperties;
import egovframework.com.utl.fcc.service.NullUtil;

@Controller
public class QrMiniController {
	
	private Log log = LogFactory.getLog(getClass());
	
	//public static final int BUFF_SIZE = 2048;
	private final static String deDug = EgovProperties.getProperty("Globals.Debug");
    @RequestMapping("/qr/mini/make.do")
    public void qr(
    		HttpServletRequest request,
    		HttpServletResponse response,
    		ModelMap model) throws Exception {

    	if("true".equals(deDug)) log.debug( request.getHeader("referer") );
    	String qrContent = NullUtil.nullString(request.getHeader("referer"));
    	if(qrContent.equals("")) {
    		qrContent = "about:blank";
    	}
    	
        QRGenerator qrg = new QRGenerator("");//qr이미지 따로 저장안함
        HashMap param = new HashMap();
		param.put(QRGenerator.ENCODE_DOTS_SIZE, 10);
		param.put(QRGenerator.ENCODE_DOTS, new Boolean(true));
		param.put(QRGenerator.ENCODE_STRING, qrContent );
		param.put(QRGenerator.ENCODE_COLOR, Integer.parseInt("000000", 16));
		param.put(QRGenerator.ENCODE_BGCOLOR, Integer.parseInt("ffffff", 16));
		param.put(QRGenerator.ENCODE_BG_SIZE, 0);
		param.put(QRGenerator.ENCODE_DPP, 10);
		param.put(QRGenerator.ENCODE_CIRCLE, true);

		int width = NullUtil.nullInt(request.getParameter("w"));
		int height = NullUtil.nullInt(request.getParameter("h"));
		if(width == 0) width = 70;
		if(height == 0) height = 70;
		
		int borderThickness = NullUtil.nullInt(request.getParameter("b"));
        BufferedImage bi;
		bi = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
		
		BufferedImage qrBi = qrg.make(param);
		Image qrImage = qrBi.getScaledInstance(width-(borderThickness*2), height-(borderThickness*2), Image.SCALE_SMOOTH);

		bi.createGraphics().drawImage(qrImage, borderThickness, borderThickness, null);
		
		response.setContentType("image/png");
		response.setHeader("Content-Disposition:", "attachment; filename=qr.png;");
		response.setHeader("Content-Transfer-Encoding", "binary");
		response.setHeader("Pragma", "no-cache");
		response.setHeader("Expires", "0");

		BufferedOutputStream outs = null;

		try {
			
		    outs = new BufferedOutputStream(response.getOutputStream());
			ImageIO.write(bi, "png", outs);
		} catch (IOException e){
			log.error(e.getMessage());
		}catch(Exception e){
			log.error(e.getMessage());
		}finally {
			if(bi!=null)bi.flush();
			if(qrImage!=null)qrImage.flush();
			if(qrBi!=null)qrBi.flush();
			if(outs!=null)outs.close();
		}
    }
}