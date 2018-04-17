package njxz.wangzw.util;

import java.security.MessageDigest;
import java.security.SecureRandom;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.codec.binary.Hex;//org-apache-comons-code.jar

public class PasswordUtil {
	
	/**
	 * 生成含有随机盐的密码 
	 * @param password
	 * @return 密码和随机盐
	 */
	public  Map<String,Object> generate(String password) {
		SecureRandom r = new SecureRandom();
		StringBuilder sb = new StringBuilder(16);
		sb.append(r.nextInt(99999999)).append(r.nextInt(99999999));
		int len = sb.length();
		//补足16位
		if (len < 16) {
			for (int i = 0; i < 16 - len; i++) {
				sb.append("0");
			}
		}
		String salt = sb.toString();
		password = md5Hex(password + salt); // md5加密之后的密码
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("password", password);
		map.put("salt", salt);
		return map;
	}


	/**
	 * @param pwdIn 页面输入的密码
 	 * @param pwdInDB 数据库中存储的盐加密过的密码
	 * @param salt 加密盐
	 * @return 本次输入的密码和盐组合加密之后是否 为正确的密码
	 */
	public  boolean verify(String pwdIn, String pwdInDB,String salt) {
		return md5Hex(pwdIn + salt).equals(pwdInDB);
	}

	/**
	 * 获取十六进制字符串形式的MD5摘要
	 */
	public  String md5Hex(String src) {
		try {
			MessageDigest md5 = MessageDigest.getInstance("MD5");
			byte[] bs = md5.digest(src.getBytes());
			return new String(new Hex().encode(bs));
		} catch (Exception e) {
			return null;
		}
	}


}