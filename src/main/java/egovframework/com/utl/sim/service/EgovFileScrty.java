/**
 * @version 3.2.0.1
 */
/**
 *  Class Name : EgovFileScrty.java
 *  Description : Base64인코딩/디코딩 방식을 이용한 데이터를 암호화/복호화하는 Business Interface class
 *  Modification Information
 *
 *     수정일         수정자                   수정내용
 *   -------    --------    ---------------------------
 *   2009.02.04    박지욱          최초 생성
 *
 *  @author 공통 서비스 개발팀 박지욱
 *  @since 2009. 02. 04
 *  @version 1.0
 *  @see
 *
 *  Copyright (C) 2009 by MOPAS  All right reserved.
 */
package egovframework.com.utl.sim.service;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStreamReader;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

import org.apache.commons.codec.binary.Base64;

public class EgovFileScrty {

	// 파일구분자
	static final char FILE_SEPARATOR = File.separatorChar;

	static final int BUFFER_SIZE = 1024;

	/**
	 * 파일을 암호화하는 기능
	 *
	 * @param String
	 *            source 암호화할 파일
	 * @param String
	 *            target 암호화된 파일
	 * @return boolean result 암호화여부 True/False
	 * @exception Exception
	 */
	public static boolean encryptFile(String source, String target) throws Exception {

		// 암호화 여부
		boolean result = false;

		String sourceFile = source.replace('\\', FILE_SEPARATOR).replace('/', FILE_SEPARATOR);
		String targetFile = target.replace('\\', FILE_SEPARATOR).replace('/', FILE_SEPARATOR);
		File srcFile = new File(sourceFile);

		BufferedInputStream input = null;
		BufferedOutputStream output = null;

		byte[] buffer = new byte[BUFFER_SIZE];

		try {
			if (srcFile.exists() && srcFile.isFile()) {

				input = new BufferedInputStream(new FileInputStream(srcFile));
				output = new BufferedOutputStream(new FileOutputStream(targetFile));

				int length = 0;
				while ((length = input.read(buffer)) >= 0) {
					byte[] data = new byte[length];
					System.arraycopy(buffer, 0, data, 0, length);
					output.write(encodeBinary(data).getBytes());
					output.write(System.getProperty("line.separator").getBytes());
				}
				result = true;
			}
		} catch (Exception ex) {
			// ex.printStackTrace();
			throw new RuntimeException(ex); // 2011.10.10 보안점검 후속조치
		} finally {
			if (input != null) {
				try {
					input.close();
				} catch (Exception ignore) {
					// no-op
					// ignore.printStackTrace();
					System.out.println("IGNORE: " + ignore); // 보안점검 후속조치
				}
			}
			if (output != null) {
				try {
					output.close();
				} catch (Exception ignore) {
					// no-op
					// ignore.printStackTrace();
					System.out.println("IGNORE: " + ignore); // 보안점검 후속조치
				}
			}
		}
		return result;
	}

	/**
	 * 파일을 복호화하는 기능
	 *
	 * @param String
	 *            source 복호화할 파일
	 * @param String
	 *            target 복호화된 파일
	 * @return boolean result 복호화여부 True/False
	 * @exception Exception
	 */
	public static boolean decryptFile(String source, String target) throws Exception {

		// 복호화 여부
		boolean result = false;

		String sourceFile = source.replace('\\', FILE_SEPARATOR).replace('/', FILE_SEPARATOR);
		String targetFile = target.replace('\\', FILE_SEPARATOR).replace('/', FILE_SEPARATOR);
		File srcFile = new File(sourceFile);

		BufferedReader input = null;
		BufferedOutputStream output = null;

		// byte[] buffer = new byte[BUFFER_SIZE];
		String line = null;

		try {
			if (srcFile.exists() && srcFile.isFile()) {

				input = new BufferedReader(new InputStreamReader(new FileInputStream(srcFile)));
				output = new BufferedOutputStream(new FileOutputStream(targetFile));

				while ((line = input.readLine()) != null) {
					byte[] data = line.getBytes();
					output.write(decodeBinary(new String(data)));
				}

				result = true;
			}
		} catch (Exception ex) {
			// ex.printStackTrace();
			throw new RuntimeException(ex); // 보안점검 후속조치
		} finally {
			if (input != null) {
				try {
					input.close();
				} catch (Exception ignore) {
					// no-op
					// ignore.printStackTrace();
					System.out.println("IGNORE: " + ignore); // 보안점검 후속조치
				}
			}
			if (output != null) {
				try {
					output.close();
				} catch (Exception ignore) {
					// no-op
					// ignore.printStackTrace();
					System.out.println("IGNORE: " + ignore); // 보안점검 후속조치
				}
			}
		}
		return result;
	}

	/**
	 * 데이터를 암호화하는 기능
	 *
	 * @param byte[]
	 *            data 암호화할 데이터
	 * @return String result 암호화된 데이터
	 * @exception Exception
	 */
	public static String encodeBinary(byte[] data) throws Exception {
		if (data == null) {
			return "";
		}

		return new String(Base64.encodeBase64(data));
	}

	/**
	 * 데이터를 암호화하는 기능
	 *
	 * @param String
	 *            data 암호화할 데이터
	 * @return String result 암호화된 데이터
	 * @exception Exception
	 */
	public static String encode(String data) throws Exception {
		return encodeBinary(data.getBytes());
	}

	/**
	 * 데이터를 복호화하는 기능
	 *
	 * @param String
	 *            data 복호화할 데이터
	 * @return String result 복호화된 데이터
	 * @exception Exception
	 */
	public static byte[] decodeBinary(String data) throws Exception {
		return Base64.decodeBase64(data.getBytes());
	}

	/**
	 * 데이터를 복호화하는 기능
	 *
	 * @param String
	 *            data 복호화할 데이터
	 * @return String result 복호화된 데이터
	 * @exception Exception
	 */
	public static String decode(String data) throws Exception {
		return new String(decodeBinary(data));
	}

	/**
	 * 비밀번호를 암호화하는 기능(복호화가 되면 안되므로 SHA-256 인코딩 방식 적용)
	 *
	 * @param String
	 *            data 암호화할 비밀번호
	 * @return String result 암호화된 비밀번호
	 * @exception Exception
	 */
	public static String encryptPassword(String data) throws Exception {

		if (data == null) {
			return "";
		}

		return EgovFileScrty.encryptSHA256(data);
		/*
		 * byte[] plainText = null; // 평문 byte[] hashValue = null; // 해쉬값 plainText =
		 * data.getBytes();
		 * 
		 * MessageDigest md = MessageDigest.getInstance("SHA-256"); hashValue =
		 * md.digest(plainText);
		 * 
		 * 
		 * BASE64Encoder encoder = new BASE64Encoder(); return
		 * encoder.encode(hashValue);
		 * 
		 * return new String(Base64.encodeBase64(hashValue));
		 */
	}

	public static String encryptSHA256(String passwd) throws NoSuchAlgorithmException {

		String encryptData = "";

		MessageDigest sha256 = MessageDigest.getInstance("SHA-256");
		sha256.update(passwd.getBytes());

		byte[] digest = sha256.digest();
		for (int i = 0; i < digest.length; i++) {
			encryptData += Integer.toHexString(digest[i] & 0xFF).toUpperCase();
		}

		return encryptData;

	}
}