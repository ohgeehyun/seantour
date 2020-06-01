/**
 * @version 3.2.0.1
 */
package egovframework.com.utl.fcc.service;

import java.awt.Container;
import java.awt.Graphics;
import java.awt.Insets;
import java.awt.image.BufferedImage;
import java.io.File;

import javax.imageio.ImageIO;
import javax.swing.JEditorPane;
import javax.swing.SwingUtilities;
import javax.swing.text.Document;
import javax.swing.text.html.HTMLDocument;
import javax.swing.text.html.HTMLEditorKit;



public class HtmlToImage extends HTMLEditorKit{
	public Document createDefaultDocument(){
		HTMLDocument doc = (HTMLDocument)super.createDefaultDocument();
		doc.setTokenThreshold(Integer.MAX_VALUE);
		doc.setAsynchronousLoadPriority(-1);
		return doc;
	}
	
	public BufferedImage create(String src, int width, int height, String filepath){
		BufferedImage image = null;
		JEditorPane pane = new JEditorPane();
		pane.setEditorKit(this);
		pane.setEditable(false);
		pane.setMargin(new Insets(0,0,0,0));
		try{
			pane.setPage(src);
			image = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
			Graphics g = image.createGraphics();
			Container c = new Container();
			SwingUtilities.paintComponent(g, pane, c, 0, 0,width,height);
			g.dispose();
	   		ImageIO.write(image,"png",new File(filepath));
		}catch (Exception e) {
			e.printStackTrace();
		}finally{
		}
		return image;
	}
}
