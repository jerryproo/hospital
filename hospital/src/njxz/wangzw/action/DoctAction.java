package njxz.wangzw.action;

import java.io.IOException;
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
import njxz.wangzw.model.Dept;
import njxz.wangzw.model.Doct;
import njxz.wangzw.model.Grant;
import njxz.wangzw.model.Page;
import njxz.wangzw.service.DoctService;

@Scope("request")
@Controller("doctAction")
public class DoctAction {
	@Autowired
	private DoctService doctService;
	private Doct doct;
	private Appoint appoint;
	private HttpServletRequest req = ServletActionContext.getRequest();
	private HttpServletResponse resp = ServletActionContext.getResponse();
	private List<Appoint> appointList;
	private String data;
	private Dept dept;
	private String searchInfo;
	private String searchType;
	private Page page;
	@SuppressWarnings("unchecked")
	public String login() throws Exception {
		if (doct != null) {
			Map<String, Object> map = doctService.login(doct);
			Boolean vertify = Boolean.valueOf(map.get("vertify").toString());
			if (vertify) {
				Doct doctInDB = (Doct) map.get("doctInDB");
				req.getSession().setAttribute("doctSessionId", doctInDB.getDoctId());
				req.getSession().setAttribute("doctSessionName", doctInDB.getDoctName());
				req.getSession().setAttribute("doctSessionJob", doctInDB.getDoctJob());
				req.setAttribute("grants",(List<Grant>)map.get("grants"));
				return "loginSuccess";
			} else
				return "loginFail";
		}
		return "loginFail";
	}
	
 	/**
 	 * 退出登陆
 	 * @return
 	 * @throws Exception
 	 */
 	public String logout() throws Exception {
		req.getSession().invalidate();
		return "loginFail";
	}
	
	public String toReadyWatch() throws Exception{
		return "toReadyWatch";
	}
	/**
	 * 微信登陆获取 返回用户挂号的信息
	 * 
	 * @throws Exception
	 */
	public void loginWechat() throws Exception {
		if (doct != null) {
			Map<String, Object> map = doctService.login(doct);
			String useAppointJson = JSON.toJSONString(map); // json :doctInDB vertify
			resp.getWriter().print(useAppointJson);
		}
	}
	
	public String toEditEmp() throws Exception{
		return "toEditEmp";
	}
	
	/**
	 * 显示所有的医生的信息
	 * @throws Exception
	 */
	public void showEmpQuery() throws Exception{
		resp.setCharacterEncoding("UTF-8");
		
		Map<String,Object> map = doctService.showEmpQuery(searchType,searchInfo,page);
		String mapJson = JSON.toJSONString(map);
		resp.getWriter().print(mapJson);
	}
	/**
	 * 护士扫码确认到达
	 * @throws Exception
	 */
	public void confirmReach() throws Exception {
		if (appoint != null) {
			Map<String, Object> map = doctService.nurseConfirm(appoint);
			String useAppointJson = JSON.toJSONString(map); // msg SUCCESS WRONGDEPT NOTCONFIRM TOEARLY NOTFOUND ERROR
			resp.getWriter().print(useAppointJson);
		}
	}

	/**
	 * 将医生的id和 用户挂号生成的唯一 编码传进来 ，匹配 修改数据库
	 * 
	 * @throws Exception
	 */
	public void scanWechat() throws Exception {
		if (appoint != null) {
			Map<String, Object> map = doctService.scanWechat(appoint);
			String msgJson = JSON.toJSONString(map); // msg SUCCESS WRONGDEPT NOTCONFIRM TOEARLY NOTFOUND ERROR
			resp.getWriter().print(msgJson);
		}
	}
	
	@SuppressWarnings("unchecked")
	public String toSingleEmpEdit() throws Exception{
		Map<String,Object> map = doctService.toSingleEmpEdit(doct);
		doct = (Doct) map.get("doct");
		List<Dept> depts = (List<Dept>)map.get("depts");
		req.setAttribute("depts", depts);
		return "toSingleEmpEdit";
	}
	/**
	 * 点击 确认是否已经扫描了用户的二维码 
	 * 传入 医生id  
	 * @throws Exception
	 */
	public void vertifyRecord() throws Exception {
		Appoint appoint=doctService.showUserInfoByDoctId(doct);
		String appointJson = JSON.toJSONString(appoint); // msg SUCCESS WRONGDEPT NOTCONFIRM TOEARLY NOTFOUND ERROR
		resp.getWriter().print(appointJson);
	}

	
	
	/**
	 * 显示单个医生信息
	 * @return
	 * @throws Exception
	 */
	public String showDoctInfo() throws Exception{
			doct =doctService.showDoctInfoById(doct);
		return "toShowDoctInfo";
	}
	
	/**
	 * 跳转到医生查看用户排队进度
	 * @return
	 * @throws Exception
	 */
	public String toShowQuery() throws Exception{
		return "showQuerySuccess";
	}
	/**
	 * 医生操作界面查看当天预约的用户的进度
	 * @throws Exception
	 */
	public void showQuery() throws Exception{
		Map<String,Object>map = new HashMap<String,Object>();
		map.put("code", 0);
		map.put("msg", "");
		map.put("count",1000);
		map.put("data", "");
		if(doct!=null) {
			appointList = doctService.showQuery(doct);
			
			map.put("data", appointList);
		}
		String mapJson = JSON.toJSONString(map);
		resp.getWriter().print(mapJson);
	}
	
	/**
	 * 更新医生的个人信息
	 * @throws Exception
	 */
	public void updateDoct() throws Exception{
		String msg="fail";
		if(data!=null) {
		doct = JSON.parseObject(data,Doct.class);
			doctService.updateDoct(doct);
			  msg="success";
		}
		String msgJson= JSON.toJSONString(msg);
		resp.getWriter().print(msgJson);
	}
	/**
	 * 管理员更新医生的个人信息
	 * @throws Exception
	 */
	public void updateDoctForMgr() throws Exception{
		String msg="fail";
		if(data!=null) {
		doct = JSON.parseObject(data,Doct.class);
			doctService.updateDoctForMgr(doct);
			  msg="success";
		}
		String msgJson= JSON.toJSONString(msg);
		resp.getWriter().print(msgJson);
	}
	/**
	 * 显示单个员工（医生)的信息
	 * @return
	 * @throws Exception
	 */
	public String toSingleEmpShow() throws Exception{
		 doct=doctService.showDoctInfoById(doct);
		return "toSingleEmpShow";
	}
	/**
	 * 依据医生的id将单个医生禁用
	 * @throws Exception
	 */
	public void delEmpById() throws Exception{
		doctService.delEmpById(doct);
		resp.getWriter().print("success");
	}
	
	/**
	 * 批量禁用医生
	 * @throws Exception
	 */
	public void delEmpQuery()throws Exception{
		String msg="fail";
		if(data!=null) {
		List<Doct>	docts = JSON.parseArray(data,Doct.class);
		doctService.delEmpQuery(docts);
		msg="success";
		resp.getWriter().print(msg);
		}
	}
	/**
	 * 跳转到添加员工 的页面
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public String toEmpAdd() throws Exception{
		Map<String,Object> map = doctService.toEmpAdd();
		List<Dept> depts = (List<Dept>)map.get("depts");
		req.setAttribute("depts", depts);
		return "toEmpAdd";
	}
	/**
	 * 管理员 添加医生
	 * @throws Exception
	 */
	public void empAdd() throws Exception{
		doct=JSON.parseObject(data,Doct.class);
		String msg="fail";
		if(doct!=null) {
			doctService.empAdd(doct);
			msg="success";
		}
		String msgJson = JSON.toJSONString(msg);
		resp.getWriter().print(msgJson);
	}
	
	/**
	 * 医生提交诊断结果
	 * @throws Exception
	 */
	public void comitResult() throws Exception{
		appoint= JSON.parseObject(data,Appoint.class);
		String msg ="fail";
		if(appoint!=null) {
			doctService.doctCommitResult(appoint);
			 msg="success";
		}
		String msgJson= JSON.toJSONString(msg);
		resp.getWriter().print(msgJson);
	}
	/**
	 * 显示所有的部门
	 * @return
	 * @throws Exception
	 */
	public String toChooseDept() throws Exception{
		List<Dept> depts = doctService.showDoctDeptAll();
		req.setAttribute("depts", depts);
		return "toChooseDept";
	}
	/**
	 * 医生准备接诊 使得医生的状态变为  0 待接诊
	 * @throws Exception
	 */
	public void readyScan()throws Exception{
		if(doct!=null) {
			Map<String,Object> map = doctService.readyScan(doct);
			String mapJson = JSON.toJSONString(map);
			resp.getWriter().print(mapJson);
		}
	}
	/**
	 * 依据搜索条件检索医生信息 180311
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public void searchEmp() throws Exception{
		resp.setCharacterEncoding("UTF-8");
		Map<String,Object> dataMap = (Map<String, Object>) JSON.parse(data);
		searchType=(String) dataMap.get("searchType");
		searchInfo=(String) dataMap.get("searchInfo");
		Map<String,Object> map = doctService.showEmpQuery(searchType,searchInfo,page);
		String mapJson = JSON.toJSONString(map);
		resp.getWriter().print(mapJson);
	}
	
	
	/**
	 * 医生手动结束当前占用的就诊信息
	 * @throws Exception
	 */
	public void endWatch()throws Exception{
		if(appoint!=null&& doct!= null) {
			doctService.endWatch(appoint,doct);
			resp.getWriter().print("success");
		}
	}
	public void nurseShowQuery() throws Exception{
		String mapJson = JSON.toJSONString(doctService.nurseShowQuery(dept));
		resp.getWriter().print(mapJson);
	}
	public String toNurseShowQuery() throws Exception{
		System.out.println(dept.getDeptNo());
		return "toNurseShowQuery";
	}
	
	public void ShowDeptAll() throws IOException {
		List<Dept> Depts = doctService.showDeptAll();
		resp.getWriter().print(Depts);
	}
	/*-----------------------------------------------------------------------------------*/
	public Doct getDoct() {
		return doct;
	}

	public void setDoct(Doct doct) {
		this.doct = doct;
	}

	public Appoint getAppoint() {
		return appoint;
	}

	public void setAppoint(Appoint appoint) {
		this.appoint = appoint;
	}

	public List<Appoint> getAppointList() {
		return appointList;
	}

	public void setAppointList(List<Appoint> appointList) {
		this.appointList = appointList;
	}
	public String getData() {
		return data;
	}
	public void setData(String data) {
		this.data = data;
	}

	public Dept getDept() {
		return dept;
	}

	public void setDept(Dept dept) {
		this.dept = dept;
	}

	public String getSearchInfo() {
		return searchInfo;
	}

	public void setSearchInfo(String searchInfo) {
		this.searchInfo = searchInfo;
	}

	public String getSearchType() {
		return searchType;
	}

	public void setSearchType(String searchType) {
		this.searchType = searchType;
	}

	public Page getPage() {
		return page;
	}

	public void setPage(Page page) {
		this.page = page;
	}
	
}
