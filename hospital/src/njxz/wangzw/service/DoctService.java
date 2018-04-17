package njxz.wangzw.service;

import java.util.List;
import java.util.Map;

import njxz.wangzw.model.Appoint;
import njxz.wangzw.model.Dept;
import njxz.wangzw.model.Doct;
import njxz.wangzw.model.Page;

public interface DoctService {
	public Map<String, Object> login(Doct doct);

	public Map<String, Object> vertifyRecord(String udCode);

	public Map<String, Object> scanWechat(Appoint appoint);

	public Map<String, Object> nurseConfirm(Appoint appoint);

	public Doct showDoctInfoById(Doct doct);// 检索单个医生信息

	public List<Appoint> showQuery(Doct doct);// 检索当天排班的用户信息

	public Appoint showUserInfoByDoctId(Doct doct);// 页面上点击扫码完成获取的当前的医生的信息

	public void doctCommitResult(Appoint appoint);// 医生医生提交诊断信息

	public Map<String, Object> readyScan(Doct doct);// 医生点击准备接诊

	public void endWatch(Appoint appoint, Doct doct);// 将传进来的udCode 对应的行的status改为 3

	public void updateDoct(Doct doct); // 页面右上角 医生自己更新信息
	
	public void updateDoctForMgr(Doct doct);//管理员修改医生信息 

	public Map<String, Object> toSingleEmpEdit(Doct doct);//显示用户的个人信息及部门信息供修改
	
	public void delEmpById(Doct doct);//将医生的状态修改为0 （离职）
	
	//public Map<String,Object> showEmpQueryBySearchInfo(String searchInfo);//按搜索框检索员工信息
	
	public void delEmpQuery(List<Doct>doct);
	
	public Map<String,Object> toEmpAdd();//到添加用的页面 返回部门职位信息
	
	public void empAdd(Doct doct);

	public List<Dept> showDoctDeptAll();
	
	public Map<String,Object> nurseShowQuery(Dept dept);

	public Map<String, Object> showEmpQuery(String searchType, String searchInfo,Page page);
	
	public List<Dept> showDeptAll();

}
