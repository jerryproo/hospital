package njxz.wangzw.mapper;

import java.util.List;
import java.util.Map;

import njxz.wangzw.model.Appoint;
import njxz.wangzw.model.Dept;
import njxz.wangzw.model.User;

public interface UserMapper {
	public User login(User user);

	public void regist(User user);
	
	public List<Appoint> getAppointByDay(Map<String, Object> map);
	
	public List<Dept> showDeptAll();
	
	public String userAppoint(Map<String,Object> map);
	
	public List<Appoint> showUserAppointByUserId(User user);
}
