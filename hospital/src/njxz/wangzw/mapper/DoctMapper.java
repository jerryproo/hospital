package njxz.wangzw.mapper;

import java.util.List;
import java.util.Map;

import njxz.wangzw.model.Appoint;
import njxz.wangzw.model.Dept;
import njxz.wangzw.model.Doct;
import njxz.wangzw.model.Grant;
import njxz.wangzw.model.Page;

public interface DoctMapper {
	public Doct login(Doct doct);

	public Map<String, Object> scanWechat(Map<String, Object> map);

	public Map<String, Object> nurseConfirm(Map<String, Object> map);

	public Doct showDoctInfoById(Doct doct);

	public List<Appoint> showQuery(Doct doct);

	public Appoint showUserInfoByDoctId(Doct doct);

	public void doctCommitResult(Appoint appoint);// 医生提交诊断信息

	public void readyScan(Doct doct);// 医生点击准备接诊

	public List<Appoint> searchAppointByDoctId(Doct doct);// 检索医生下状态为2 的就诊记录

	public void endWatch(Appoint appoint);// 将传进来的udCode 对应的行的status改为 3

	public List<Grant> showGrant(Doct doct);

	public void updateDoct(Doct doct);//医生自己修改个人信息
	
	public void updateDoctForMgr(Doct doct);//管理员修改医生信息 
	
	public List<Doct> showEmpQuery(Page page);
	
	public int countShowEmpQuery();
	
	public List<Dept> getDeptAll();
	
	public void delEmpById(Doct doct);//将医生的状态修改为0 （离职）
	
	public List<Doct> showEmpQueryBySearchInfo(Map<String,Object> map);//按搜索框检索员工信息

	public int countShowEmpQueryBySearchInfo(Map<String,Object> map);//按条件搜索员工的信息的个数 
	
	public void empAdd(Doct doct);
	
	public List<Dept> showDoctDeptAll();//不包含护士站和管理员的所有部门信息
	
	public List<Appoint> nurseShowQuery(Dept dept);
	
	public List<Dept> showDeptAll();//包括护士站和管理员再内的所有部门信息
}
