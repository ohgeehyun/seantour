/**
 * @version 3.2.0.1
 */
package egovframework.com.utl.fcc.service;

import java.awt.Graphics2D;
import java.awt.Image;
import java.awt.geom.AffineTransform;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;

import javax.imageio.IIOImage;
import javax.imageio.ImageIO;
import javax.imageio.ImageWriteParam;
import javax.imageio.ImageWriter;
import javax.imageio.stream.FileImageOutputStream;
import javax.swing.ImageIcon;

import com.mortennobel.imagescaling.AdvancedResizeOp;
import com.mortennobel.imagescaling.ResampleFilters;
import com.mortennobel.imagescaling.ResampleOp;


public class ThumbnailUtil {
	public static boolean prefix = false;
	/**
	 * 정해진 크기의 섬네일 만들기 
	 * @param file 원 파일
	 * @param 섬네일이 저장될 경로
	 * @param thumbFileName 섬네일 파일명(기본 파일명_thumb.확장자 로 생성)
	 * @param thumbScale 섬네일 크기
	 * @return 저장된 섬네일파일명 또는 ""
	 */
	public static String makeThumbnail(File file, String thumbStorePath, String thumbFileName, int thumbScale) 
			throws Exception{
		String retThumbName = "";
		//if(thumbStorePath.equals(""))thumbStorePath = propertyService.getString("Globals.fileStorePath");
		if(file.exists()) {
			String[] names = FileUtil.getSplitFileName(file.getName());
	
	   		String baseName = "", extName = "";
	   		if(names.length > 0) baseName = names[0];
	   		if(names.length > 1) extName = names[1];
	   		if(extName.toLowerCase().equals("gif") || extName.toLowerCase().equals("jpg") || extName.toLowerCase().equals("jpeg")) {
				if(thumbFileName.equals("")) {
					if(isPrefix() == false) {
						thumbFileName = baseName + "_thumb."+extName;
					}else {
						thumbFileName = "thumb_" + baseName + "." + extName;
					}
				}
				
				File f_thumb = new File(thumbStorePath + "/" + thumbFileName);
				f_thumb = FileUtil.rename(f_thumb);//파일명 중복 체크
				
				FileUtil.makeDir(thumbStorePath);
				createThumbnail(file.getPath(), thumbStorePath + "/" + f_thumb.getName(),thumbScale);
	   			retThumbName = thumbFileName; 
	   		}
	   	}
	   	return retThumbName;
	}

	public static void writeJpeg(BufferedImage image, String destFile, float quality) 
	throws IOException {
	    ImageWriter writer = null;
	    FileImageOutputStream output = null;
	    try {
	        writer = ImageIO.getImageWritersByFormatName("jpeg").next();
	        ImageWriteParam param = writer.getDefaultWriteParam();
	        param.setCompressionMode(ImageWriteParam.MODE_EXPLICIT);
	        param.setCompressionQuality(quality);
	        output = new FileImageOutputStream(new File(destFile));
	        writer.setOutput(output);
	        IIOImage iioImage = new IIOImage(image, null, null);
	        writer.write(null, iioImage, param);
	        
	    } catch (IOException ex) {
	        throw ex;
	    } finally {
	        if (writer != null) writer.dispose();
	        if (output != null) output.close();
	        if (image != null) image.flush();
	    }
	}
	
	/**
	 * 정해진 크기의 섬네일 만들기 
	 * @param file 원 파일
	 * @param 섬네일이 저장될 경로
	 * @param thumbFileName 섬네일 파일명(기본 파일명_thumb.확장자 로 생성)
	 * @param width 섬네일 가로크기
	 * @param height 섬네일 세로크기
	 * @return 저장된 섬네일파일명 또는 ""
	 */
	public static String makeThumbnail(File file, String thumbStorePath, String thumbFileName, int width, int height) 
			throws Exception{
		String retThumbName = "";
		//if(thumbStorePath.equals(""))thumbStorePath = propertyService.getString("Globals.fileStorePath");
		if(file.exists()) {
			String[] names = FileUtil.getSplitFileName(file.getName());
	
	   		String baseName = "", extName = "";
	   		if(names.length > 0) baseName = names[0];
	   		if(names.length > 1) extName = names[1];
	   		if(extName.toLowerCase().equals("gif") || extName.toLowerCase().equals("jpg") || extName.toLowerCase().equals("jpeg")) {
				if(thumbFileName.equals("")) {
					if(isPrefix() == false) {
						thumbFileName = baseName + "_thumb."+extName;
					}else {
						thumbFileName = "thumb_" + baseName + "." + extName;
					}
				}
				
				File f_thumb = new File(thumbStorePath + "/" + thumbFileName);
				f_thumb = FileUtil.rename(f_thumb);//파일명 중복 체크
				
				FileUtil.makeDir(thumbStorePath);
				createThumbnail(file.getPath(), thumbStorePath + "/" + f_thumb.getName(), width, height);

	   			retThumbName = thumbFileName; 
	   		}
	   	}
	   	return retThumbName;
	}
	
	
	/**
	 * 실제 섬네일 작업
	 * @param orig
	 * @param thumb
	 * @param maxDim
	 * @return
	 */
	public static String createThumbnail( String orig, String thumb, int maxDim) {

    	try {
    		Image inImage = new ImageIcon(orig).getImage();

    		if(maxDim  > inImage.getWidth(null)) maxDim = inImage.getWidth(null);
    		
    		double scale = (double)maxDim/(	double)inImage.getHeight(null);

    		if (inImage.getWidth(null) > inImage.getHeight(null)) {
                scale = (double)maxDim/(double)inImage.getWidth(null);
            }

            int scaledW = (int)(scale*inImage.getWidth(null));
            //if(maxDim < scaledW)  maxDim = scaledW;
            int scaledH = (int)(scale*inImage.getHeight(null));
            /*
            if(maxDim  > inImage.getWidth(null)){
    			return createThumbnail(orig, thumb, scaledW, scaledH);    			
    		}
            */
            // Create an image buffer in
            //which to paint on.
            BufferedImage outImage = new BufferedImage(scaledW, scaledH, BufferedImage.TYPE_INT_RGB);

            // Set the scale.
            AffineTransform tx =  new AffineTransform();

            // If the image is smaller than
            //the desired image size,
            // don't bother scaling.
            if (scale < 1.0d)
            {
                tx.scale(scale, scale);
            }

            // Paint image.
            Graphics2D g2d = outImage.createGraphics();
            g2d.drawImage(inImage, tx, null);
            ThumbnailUtil.writeJpeg(outImage, thumb, (float)1.0);
            outImage.flush();
            g2d.dispose();
    	    
        } catch (IOException e) {
        	System.out.println("lib.Thumbnail => " + e);
            //e.printStackTrace();
        }
        
        return thumb;
    }
	
	/**
	 * 실제 섬네일 작업
	 * @param orig
	 * @param thumb
	 * @param width
	 * @param height
	 * @return
	 */
	public static String createThumbnail( String orig, String thumb, int width, int height) {

		BufferedImage sourceImage = null;
		try {
			sourceImage = ImageIO.read(new File(orig));
			
		}catch (Exception e) {
			e.printStackTrace();
			if(sourceImage != null)sourceImage.flush();
			thumb = "imgTypeError";
			return thumb;
		}    	
		Graphics2D g = null;
    	try {	
    		ResampleOp resampleOp = new ResampleOp(width, height);
    	    resampleOp.setFilter(ResampleFilters.getLanczos3Filter());
    	    resampleOp.setUnsharpenMask(AdvancedResizeOp.UnsharpenMask.Normal);
    	    BufferedImage destImage = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB); 	    
    	    //destImage = resampleOp.filter(sourceImage, null);
    	    g = destImage.createGraphics();
    	    g.drawImage(sourceImage, 0, 0, width, height,null);
    	    ThumbnailUtil.writeJpeg(destImage, thumb, (float)1.0);    
    	   
        } catch (IOException e) {
        	System.out.println("lib.Thumbnail => " + e);
            //e.printStackTrace();        	
        }finally{
        	 g.dispose();
     	    sourceImage.flush();
        }
        return thumb;
    }

	public static boolean isPrefix() {
		return prefix;
	}
	
}
