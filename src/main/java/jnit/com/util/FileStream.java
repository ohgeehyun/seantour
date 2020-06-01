/**
 * @version 3.2.0.1
 */
package jnit.com.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;

import org.apache.commons.io.IOUtils;

public class FileStream {

	public FileStream(){
	}
	
	public static String readFileToString(File file, String encoding) throws IOException {
        InputStream in = null;
        try {
            in = openInputStream(file);
            String str = IOUtils.toString(in, encoding);
            in.close();
            return str;
        } finally {
            IOUtils.closeQuietly(in);
        }
    }

    public static FileInputStream openInputStream(File file) throws IOException {
        if (file.exists()) {
            if (file.isDirectory()) {
                throw new IOException("File '" + file + "' exists but is a directory");
            }
            if (file.canRead() == false) {
                throw new IOException("File '" + file + "' cannot be read");
            }
        } else {
            throw new FileNotFoundException("File '" + file + "' does not exist");
        }
        return new FileInputStream(file);
    }
	
}
