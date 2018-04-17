package njxz.wangzw.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import njxz.wangzw.mapper.DoctMapper;
import njxz.wangzw.model.Appoint;
import njxz.wangzw.model.Dept;
import njxz.wangzw.model.Doct;
import njxz.wangzw.model.Grant;
import njxz.wangzw.model.Page;
import njxz.wangzw.service.DoctService;
import njxz.wangzw.util.PageUtil;
import njxz.wangzw.util.PasswordUtil;

@Service("doctService")
public class DoctServiceImpl implements DoctService{
	@Autowired
	private DoctMapper doctMapper;
	public Map<String, Object> login(Doct doct)  {
		Map<String, Object> map = new HashMap<String, Object>();
		if(doctMapper.login(doct)!=null){
			Doct doctInDB =doctMapper.login(doct);
			PasswordUtil pwdUtil = new PasswordUtil();
			Boolean vertify = pwdUtil.verify(doct.getDoctPassword(), doctInDB.getDoctPassword(), doctInDB.getDoctSalt());
			if(vertify) {
				//身份校验成功再检索菜单栏信息
				List<Grant> grants = doctMapper.showGrant(doctInDB);
				map.put("grants", grants);
				map.put("doctInDB", doctInDB);
			}
			
			map.put("vertify", vertify);
			}else {
				map.put("vertify", false);
			}
		return map;
	}

	@Override
	public Map<String, Object> vertifyRecord(String udCode) {
		
		return null;
	}

	@Override
	public Map<String,Object> scanWechat(Appoint appoint) {
		Map <String,Object> map= new HashMap<String,Object> ();
		map.put("doctIdIn", appoint.getUdDoctId());
		map.put("udCodeIn", appoint.getUdCode());
		doctMapper.scanWechat(map);		
		return map;
	}

	@Override
	public Map<String, Object> nurseConfirm(Appoint appoint) {
		Map<String,Object>map = new HashMap<String,Object> ();
		map.put("udCodeIn", appoint.getUdCode());
		doctMapper.nurseConfirm(map);
		return map;
	}

	@Override
	public Doct showDoctInfoById(Doct doct) {
		return doctMapper.showDoctInfoById(doct);
	}

	@Override
	public List<Appoint> showQuery(Doct doct) {
		return doctMapper.showQuery(doct);
	}

	@Override
	public Appoint showUserInfoByDoctId(Doct doct) {
		return doctMapper.showUserInfoByDoctId(doct);
	}
	@Override
	public void doctCommitResult(Appoint appoint) {
		doctMapper.doctCommitResult(appoint);
//		doctMapper.inWatch(doct);//将医生的状态修改为0 可以继续被自动扫描检索到  并安排值班  现在将功能移到页面点击准备减震下了
	}

	@Override
	public Map<String, Object> readyScan(Doct doct) {
		String msg="";
		Map<String,Object> map = new HashMap<String,Object> ();
		//先检测是否有用户当前再本医生接诊状态下的
		List<Appoint> appoints =doctMapper.searchAppointByDoctId(doct);
		if (!appoints.isEmpty()) {
			msg="fail";
			map.put("appoints", appoints);
		}else {
			msg="success";
			doctMapper.readyScan(doct);
		}
		map.put("msg", msg);
		return map;
	}

	@Override
	@Transactional
	public void endWatch(Appoint appoint,Doct doct) {
			doctMapper.endWatch(appoint);
			doctMapper.readyScan(doct);
	}

	@Override
	public void updateDoct(Doct doct) {
		doctMapper.updateDoct(doct);
	}

	@Override
	public Map<String, Object> showEmpQuery(String searchType, String searchInfo,Page page) {
		Map <String,Object> map = new HashMap<String,Object>();
		List<Doct> docts = null;
		int count =0 ;
		if(page==null) {
			page= new Page();
		}
		if(searchInfo==null||searchInfo.trim().equals("")) {//直接显示和分页
			count = doctMapper.countShowEmpQuery();
			page.setCount(count);
			page=PageUtil.pageChange(page);
			docts= doctMapper.showEmpQuery(page);
		}else {//带参搜索
			searchInfo = searchInfo.replaceAll("\"","");
			searchType = searchType.replaceAll("\"","");
			Map<String,Object> map2 = new HashMap<String,Object>();
			map2.put("searchInfo", searchInfo);
			map2.put("searchType", searchType);
			count=doctMapper.countShowEmpQueryBySearchInfo(map2);//先依据参数检索出总数目 再 进行页面控制 
			page.setCount(count);
			page=PageUtil.pageChange(page);
			map2.put("stRownum", page.getStRownum());
			map2.put("endRownum", page.getEndRownum());
			docts=doctMapper.showEmpQueryBySearchInfo(map2);
		}
		map.put("count", count);
		map.put("msg", "success");
		map.put("code", 0);
		map.put("data", docts);
		return map;
	}

	@Override
	public Map<String, Object> toSingleEmpEdit(Doct doct) {
		Doct doctBack = doctMapper.showDoctInfoById(doct);
		List<Dept> depts = doctMapper.getDeptAll();
		Map<String,Object> map= new HashMap<String,Object>();
		map.put("doct",doctBack);
		map.put("depts", depts);
		return map;
	}

	@Override
	public void updateDoctForMgr(Doct doct) {
/*		if(doct.getDoctStatus()==0) {
			
		}*/
		doctMapper.updateDoctForMgr(doct);
	}

	@Override
	public void delEmpById(Doct doct) {
		doctMapper.delEmpById(doct);
	}

/*	@Override
	public Map<String, Object> showEmpQueryBySearchInfo(String searchInfo) {
		List<Doct> docts =doctMapper.showEmpQueryBySearchInfo(searchInfo);
		int count = doctMapper.countShowEmpQueryBySearchInfo(searchInfo);
		Map <String,Object> map = new HashMap<String,Object>();
		map.put("count", count);
		map.put("data", docts);
		map.put("msg", "");
		map.put("code", 0);
		return map;
	}*/
	@Transactional
	@Override
	public void delEmpQuery(List<Doct> docts) {
		for (Doct doct : docts) {
			doctMapper.delEmpById(doct);
		}
	}

	@Override
	public Map<String, Object> toEmpAdd() {
		List<Dept> depts = doctMapper.getDeptAll();
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("depts", depts);
		return map;
	}

	@Override
	public void empAdd(Doct doct) {
		//设置初始密码为123456 并随机加上数字  依据MD5加密
		PasswordUtil pwdUtil = new PasswordUtil();
		String password = "123456";
		Map<String,Object> map = pwdUtil.generate(password);
		doct.setDoctPassword((String)map.get("password"));
		doct.setDoctSalt((String)map.get("salt"));
		doctMapper.empAdd(doct);
	}

	@Override
	public List<Dept> showDoctDeptAll() {
		return doctMapper.showDoctDeptAll();
	}

	@Override
	public Map<String, Object> nurseShowQuery(Dept dept) {
		Map<String,Object>map = new HashMap<String,Object>();
		map.put("code", 0);
		map.put("msg", "success");
		map.put("count",10);
		map.put("data", "");
		if(dept!=null) {
			List<Appoint> appoints = doctMapper.nurseShowQuery(dept);
			map.put("data", appoints);
		}
		return map;
	}

	@Override
	public List<Dept> showDeptAll() {
		return doctMapper.showDeptAll();
	}


}
