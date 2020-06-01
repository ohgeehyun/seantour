/**
 * @version 3.2.0.1
 */
package jnit.qr.mini;

import java.awt.Color;
import java.awt.Graphics2D;
import java.awt.Image;
import java.awt.RenderingHints;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.util.Hashtable;
import java.util.Map;

import javax.imageio.ImageIO;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.google.zxing.BarcodeFormat;
import com.google.zxing.EncodeHintType;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.qrcode.QRCodeWriter;
import com.google.zxing.qrcode.decoder.ErrorCorrectionLevel;

import egovframework.com.cmm.service.EgovProperties;
import egovframework.com.utl.fcc.service.EgovStringUtil;

public class QRGenerator{
	
	private Log log = LogFactory.getLog(getClass());
	
	public final static int ENCODE_STRING = 10;
	public final static int ENCODE_COLOR = 20;
	public final static int ENCODE_BGCOLOR = 19;
	public final static int ENCODE_DOTS = 21;
	public final static int ENCODE_DOTS_SIZE = 22;
	public final static int ENCODE_BG_IMG = 23;
	public final static int ENCODE_BG_SIZE = 24;
	public final static int ENCODE_DPP = 25;
	public final static int ENCODE_CIRCLE = 26;
	
	private int dpp=10;
	private int qr_size = 50; // pixels in QR code (http://m.kwater.or.kr/123456789 or length 42)
	//public static final int dpp = 12;	//actual pixels in image : pixels in QR code
	private int img_dimension = qr_size * dpp; //final qr code image size
	private int empty = 0;
	
	private static String pathToBgImg;
	private String savePath = "";
	private String saveFileName = "";
	private String saveFileType = "png";
	private final static String deDug = EgovProperties.getProperty("Globals.Debug");

	public QRGenerator(String savePath){
		this.savePath = savePath;
	}
	public QRGenerator(String savePath,String saveFileName){
		this.savePath = savePath;
		this.saveFileName = saveFileName;
	}
	public QRGenerator(String savePath,String saveFileName,String saveFileType){
		this.savePath = savePath;
		this.saveFileName = saveFileName;
		this.saveFileType = saveFileType;
	}
	public QRGenerator(String savePath,String saveFileName,String saveFileType,int qr_size, int dpp){
		this.savePath = savePath;
		this.saveFileName = saveFileName;
		this.saveFileType = saveFileType;
		this.qr_size = qr_size;
		this.dpp = dpp;
	}
	
	public BufferedImage make(Map param) {
		
		//retrieve parameters
		String s = (String)param.get(ENCODE_STRING);
		int color = (Integer)param.get(ENCODE_COLOR);
		int bgcolor = (Integer)param.get(ENCODE_BGCOLOR);
		boolean bg_img = param.get(ENCODE_BG_IMG)!=null;
		double border_ratio = 0 + 0.1*(Integer)param.get(ENCODE_BG_SIZE);
		dpp = (Integer)param.get(ENCODE_DPP);
		img_dimension = qr_size * dpp;
		boolean usecircle = (Boolean)param.get(ENCODE_CIRCLE);
		//set up colors
		Color bgColor;
		Color qrColor;
		if(bgcolor < 0)
			bgColor = new Color(0, 0, 0, 0);
		else
			bgColor = new Color(bgcolor);
		qrColor = new Color(color);
		
		//set up ZXing
		Hashtable hints = new Hashtable();
		hints.put(EncodeHintType.ERROR_CORRECTION, ErrorCorrectionLevel.L);

		BufferedImage bi;
		try{
			BitMatrix bitMatrix = new QRCodeWriter().encode(s,
				BarcodeFormat.QR_CODE, 1, 1, hints);
			
			qr_size = bitMatrix.getHeight();
			img_dimension = qr_size * dpp;
			int final_img_dim = (int)(border_ratio * img_dimension);
		if("true".equals(deDug)) log.debug("final_img_dim:" + final_img_dim);
		
		
			if(bg_img){
				File bg_img_file = new File(pathToBgImg+(String)param.get(ENCODE_BG_IMG));
				bi = ImageIO.read(bg_img_file);
				Image im = bi.getScaledInstance(final_img_dim, -1, Image.SCALE_SMOOTH);
				bi = new BufferedImage(final_img_dim,final_img_dim, BufferedImage.TYPE_INT_ARGB);
				bi.getGraphics().drawImage(im, 0 , 0, null);
			}
			else 
				bi= new BufferedImage(img_dimension, img_dimension, BufferedImage.TYPE_INT_ARGB);
			
			int bg_img_size = bi.getWidth();
			int correction = (bg_img_size - img_dimension)/2;
			
			Graphics2D ig2 = bi.createGraphics();
			ig2.setRenderingHint(RenderingHints.KEY_ANTIALIASING,
                    RenderingHints.VALUE_ANTIALIAS_ON);
			
			//fill in qr code background
			if(bgcolor>=0){
			Object o = param.get(ENCODE_BG_IMG);
			ig2.setPaint(bgColor);
				ig2.fillRect(correction, correction, img_dimension, img_dimension);
			}
				
			//fill in QR code
			ig2.setPaint(qrColor);
			for(int i=0;i<bitMatrix.getWidth();i++){
				for(int j=0;j<bitMatrix.getHeight();j++){
					if(bitMatrix.get(i, j)){
						if(usecircle){
							ig2.fillOval(correction+i*dpp, correction+j*dpp, dpp, dpp);
						}else{
							ig2.fillRect(correction+i*dpp, correction+j*dpp, dpp, dpp);
						}
					}
				}
			}
			
			writeAlignBox(ig2, correction+4*dpp, correction+4*dpp, bgColor);
			writeAlignBox(ig2, correction+bitMatrix.getWidth()*dpp-11*dpp, correction+4*dpp, bgColor);
			writeAlignBox(ig2, correction+4*dpp, correction+bitMatrix.getHeight()*dpp-11*dpp, bgColor);
			
			//ByteArrayOutputStream baos = new ByteArrayOutputStream();
			//ImageIO.write(bi, "png", baos);
			//return baos.toByteArray();
			//파일명 만들기
			if(saveFileName.equals("")){
				saveFileName = EgovStringUtil.getTimeStamp() + "." + saveFileType;
			}
			//log.debug("QR제너레이터 bi : " + bi.toString());
			//log.debug("QR이미지 저장 : "+savePath + File.separator + saveFileName);
			if(!savePath.equals(""))ImageIO.write(bi, saveFileType, new File(savePath + File.separator + saveFileName));
			//return saveFileName;
			return bi;
		} catch (IOException e){
			log.error(e.getMessage());
		}
		catch(Throwable t){
			log.error(t.getMessage());
		}finally{
		}
		
		return null;
	}
	
	public void writeAlignBox(Graphics2D ig2, int xOffset, int yOffset, Color bgcolor) throws Throwable{
		/*
		ig2.fillRect(xOffset, yOffset, 7*dpp, dpp);
		ig2.fillRect(xOffset, yOffset, dpp, 7*dpp);
		ig2.fillRect(xOffset + 6*dpp, yOffset, dpp, 7*dpp);
		ig2.fillRect(xOffset, yOffset + 6*dpp, 7*dpp, dpp);
		ig2.fillRect(xOffset+2*dpp, yOffset+2*dpp, 3*dpp, 3*dpp);
		*/
		ig2.fillRect(xOffset, yOffset, 7*dpp, dpp);
		ig2.fillRect(xOffset, yOffset, dpp, 7*dpp);
		ig2.fillRect(xOffset + 6*dpp, yOffset, dpp, 7*dpp);
		ig2.fillRect(xOffset, yOffset + 6*dpp, 7*dpp, dpp);
		ig2.fillRect(xOffset+2*dpp, yOffset+2*dpp, 3*dpp, 3*dpp);
	}
	public int getImg_dimension() {
		return img_dimension;
	}
}
