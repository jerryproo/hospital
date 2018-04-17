package njxz.wangzw.action;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.alibaba.fastjson.JSON;

import njxz.wangzw.model.Appoint;
import njxz.wangzw.model.AppointCount;
import njxz.wangzw.model.Dept;
import njxz.wangzw.model.User;
import njxz.wangzw.service.UserService;

@Scope("request")
@Controller("userAction")
public class UserAction {
	private User user;
	@Autowired
	private UserService userService;
	private List<Dept> deptAll;
	private Dept dept;//传递给选择日期页面的deptx信息
	private String date;
	private Map<String,Object> map;
	private HttpServletRequest req = ServletActionContext.getRequest();
	private HttpServletResponse resp = ServletActionContext.getResponse();
	private String doctTitle;//医生职称
	/**
	 * 网页登陆 
	 * @return
	 * @throws Exception
	 */
	public String login() throws Exception {
		if (user != null) {
			Map<String,Object> map= userService.login(user);
			Boolean vertify =Boolean.valueOf(map.get("vertify").toString());
			if (vertify) {
				User userInDB =(User)map.get("userInDB");
				req.getSession().setAttribute("userSessionId", userInDB.getUserId());
				req.getSession().setAttribute("userSessionName", userInDB.getUserName());
				return "loginSuccess";
			} else				
				return "loginFail";
		}
		return "loginFail";
	}
 	/**
 	 * 推出登陆
 	 * @return
 	 * @throws Exception
 	 */
 	public String logout() throws Exception {
		req.getSession().invalidate();
		return "loginFail";
	}
	/**
	 * 微信登陆获取 返回用户挂号的信息
	 * @throws Exception
	 */
	public void loginWechat() throws Exception{
		if(user!=null){
			Map<String,Object> map= userService.login(user);
			User userInDB= (User)map.get("userInDB");
			List<Appoint> appointList= userService.showUserAppointByUserId(userInDB);
			map.put("appointList", appointList);
			String useAppointJson = JSON.toJSONString(map); //  json  :userInDB  vertify  appointList
			resp.getWriter().print(useAppointJson);
		}
	}
	/**
	 * 网页注册
	 * @return
	 * @throws Exception
	 */
	public String regist() throws Exception {
		if (userService.regist(user)) {
			return "registSuccess";
		} else {
			req.setAttribute("regMsg", "regFail");
			return "registFail";
		}
	}

	/**
	 * 用户点击日期，显示可以挂号的数目
	 * 
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public void usertoAppoint() throws Exception {
		Map<String, Object> mapReturn = userService.getAppointByDay(date,String.valueOf(dept.getDeptNo()),doctTitle);
		String jsonCount = JSON.toJSONString(mapReturn);
		resp.getWriter().print(jsonCount);	
	}

	/**
	 * 弹出层显示所有的部门
	 * @return
	 */
	public String showDeptAll() throws Exception{
		 deptAll = userService.showDeptAll();
		return "showDept";
	}

	/**
	 * 点击部门到 选择日期挂号
	 * 
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public String toChooseDate() throws Exception{
		Map<String, Object> mapReturn =userService.toChangeDate(String.valueOf(dept.getDeptNo()),doctTitle);
		List<AppointCount> countList=(List<AppointCount>)mapReturn.get("countList");
		Integer countno = (Integer)mapReturn.get("countno");
		date = (String)mapReturn.get("datein");
		dept.setDeptName((String)mapReturn.get("deptName"));
		doctTitle = (String)mapReturn.get("doctTitle");
		req.setAttribute("countList", countList);
		req.setAttribute("countno", countno);
		return "toChooseDate";
	}
	
	public void userAppoint() throws Exception{
		String rangeNo = req.getParameter("rangeNo");
		map=new HashMap<String,Object> ();
		map.put("rangeNo",rangeNo);//1 2 3 4
		map.put("deptNo", dept.getDeptNo());//1001 1002 
		map.put("userId", user.getUserId());//1 2 3 4
		map.put("date", date);//yyyy-MM-dd
		map.put("doctTitle",doctTitle);
		String msg =(String)userService.userAppoint(map);
		resp.getWriter().print(msg);
	}
	public String toUserHistory() throws Exception{
		
		return "toUserHistory";
	}
	
	public void userHistory() throws Exception{
		
	}
	
	/*----------------------------------------*/

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public List<Dept> getDeptAll() {
		return deptAll;
	}

	public void setDeptAll(List<Dept> deptAll) {
		this.deptAll = deptAll;
	}
	
	public Dept getDept() {
		return dept;
	}

	public void setDept(Dept dept) {
		this.dept = dept;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}
	public String getDoctTitle() {
		return doctTitle;
	}
	public void setDoctTitle(String doctTitle) {
		this.doctTitle = doctTitle;
	}
	

}
