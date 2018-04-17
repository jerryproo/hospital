package njxz.wangzw.service.impl;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import njxz.wangzw.mapper.UserMapper;
import njxz.wangzw.model.Appoint;
import njxz.wangzw.model.AppointCount;
import njxz.wangzw.model.Dept;
import njxz.wangzw.model.User;
import njxz.wangzw.service.UserService;
import njxz.wangzw.util.PasswordUtil;

@Service("userService")
public class UserServiceImpl implements UserService {
	@Autowired
	private UserMapper userMapper;

	@Override
	public Map<String,Object> login(User user) {
		Map<String,Object> map = new HashMap<>();
		if(userMapper.login(user)!=null){
		User userInDB =userMapper.login(user);
		PasswordUtil pwdUtil = new PasswordUtil();
		Boolean vertify = pwdUtil.verify(user.getUserPassword(), userInDB.getUserPassword(), userInDB.getUserSalt());
		map.put("userInDB", userInDB);
		map.put("vertify", vertify);
		}else {
			map.put("vertify", false);
		}
		return map;
	}

	@Override
	@Transactional
	public boolean regist(User user) {
		PasswordUtil pwdUtil = new PasswordUtil();
		String password = user.getUserPassword();
		Map<String,Object> map = pwdUtil.generate(password);
		//对密码加密
		user.setUserPassword((String)map.get("password"));
		user.setUserSalt((String)map.get("salt"));
		userMapper.regist(user);
		return true;
	}

	// 获取指定日期挂号数目
	@Override
	public Map getAppointByDay(String date, String deptNo,String doctTitle) throws Exception {
		if("".equals(doctTitle) || doctTitle == null) {
			doctTitle = "COMMON";//医生职称  未输入值的时候默认返回普通号
		}
		Map<String, Object> map = new HashMap<String, Object>();
		Map<String, Object> mapReturn = new HashMap<String, Object>();// 用于返回的map
		Date dateNow = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date datei = sdf.parse(date);//将传进来的转化为日期格式  供比较大小
		//当前日期再选择日期之前不可预约
		if (dateNow.after(datei)) {
			mapReturn.put("status", "dateIllegal");
			mapReturn.put("datein", date);//返沪给页面的还是yyyy-MM-dd
		} else {
			SimpleDateFormat sdf2 = new SimpleDateFormat("yyyyMMdd");
			String datein =sdf2.format(datei);//在将传进来的日期 格式转化为和数据库对应的格式
			map.put("datein", datein);
			map.put("deptnoin", deptNo);
			map.put("doctTitle", doctTitle);
			userMapper.getAppointByDay(map);
			if ("Y".equals(map.get("flag"))) {
				List<AppointCount> countList = new ArrayList<AppointCount>();
				AppointCount count1 = new AppointCount();
				AppointCount count2 = new AppointCount();
				AppointCount count3 = new AppointCount();
				AppointCount count4 = new AppointCount();
				count1.setCount((Integer) map.get("count1"));
				count1.setId(1);
				count1.setTimestamp("08:00~10:00");
				countList.add(count1);
				count2.setCount((Integer) map.get("count2"));
				count2.setId(2);
				count2.setTimestamp("10:00~12:00");
				countList.add(count2);
				count3.setCount((Integer) map.get("count3"));
				count3.setId(3);
				count3.setTimestamp("13:00~15:00");
				countList.add(count3);
				count4.setCount((Integer) map.get("count4"));
				count4.setId(4);
				count4.setTimestamp("15:00~17:00");
				countList.add(count4);
				mapReturn.put("countList", countList);
				mapReturn.put("countno", map.get("countno"));
				mapReturn.put("datein", date);//返沪给页面的还是yyyy-MM-dd
				mapReturn.put("deptName", map.get("deptName"));
				mapReturn.put("flag",map.get("flag"));
				mapReturn.put("doctTitle", map.get("doctTitle"));
			} else {
				mapReturn.put("status", "noInfo");
				mapReturn.put("doctTitle", doctTitle);
				mapReturn.put("datein", date);//返沪给页面的还是yyyy-MM-dd
			}
			
		}

		// ------------------------
		return mapReturn;
	}

	@Override
	public List<Dept> showDeptAll() {
		return userMapper.showDeptAll();
	}

	@Override
	public Map<String, Object> toChangeDate(String deptNo,String doctTitle) throws Exception {
		 Calendar cal = Calendar.getInstance();//使用默认时区和语言环境获得一个日历。    
		 cal.add(Calendar.DAY_OF_MONTH, +1);//取得该日历后一天
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String date = sdf.format(cal.getTime());
		return getAppointByDay(date, deptNo,doctTitle);
	}

	@Override
	public String userAppoint(Map<String, Object> map) {
		String date = (String) map.get("date");
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		SimpleDateFormat sdf2 = new SimpleDateFormat("yyyyMMdd");
		try {
			Date dd=sdf.parse(date);
			date = sdf2.format(dd);//再转化为String类型 yyyyMMdd
		} catch (ParseException e) {
			e.printStackTrace();
		}
		map.put("date", date);
		userMapper.userAppoint(map);
		String msg = (String) map.get("msg");

		return msg;
	}

	@Override
	public List<Appoint> showUserAppointByUserId(User user) {
		return userMapper.showUserAppointByUserId(user);
	}

}
