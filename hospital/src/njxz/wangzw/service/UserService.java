package njxz.wangzw.service;

import java.util.List;
import java.util.Map;

import njxz.wangzw.model.Appoint;
import njxz.wangzw.model.Dept;
import njxz.wangzw.model.User;

public interface UserService {
	public Map<String,Object> login(User user);

	public boolean regist(User user);

	public Map getAppointByDay(String date, String deptNo,String doctTitle) throws Exception;

	public Map toChangeDate(String deptNo,String doctTitle) throws Exception;

	public List<Dept> showDeptAll();
	
	public String userAppoint(Map<String,Object> map) ;
	
	public List<Appoint> showUserAppointByUserId(User user);

}
