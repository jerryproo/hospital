package njxz.wangzw.model;

import java.util.Date;

/*create table tb_doct(
doct_id number primary key,
doct_name varchar2(20) not null,
doct_dept_no number ,
doct_pro varchar2(20),
doct_num number,--医生每个时间段可接诊人数
doct_status char(1),
doct_info1 varchar2(100),
doct_info2 varchar2(100),
doct_info3 varchar2(100),
doct_info4 varchar2(100),
doct_info5 varchar2(100),
doct_info6 varchar2(100),
doct_info7 varchar2(100),
doct_info8 varchar2(100),
doct_info9 varchar2(100),
doct_info10 varchar2(100)
);*/
public class Doct {
	private int doctId;
	private String doctName;
	private String doctPassword;
	private String doctSalt;
	private int deptNo;
	private String doctPro;
	private int doctNum;
	private int doctStatus;
	private int doctInposition;
	private Dept dept;
	private String doctJob;
	private Date doctBirthday;
	private String doctSex;
	private int doctTiltleId;
	private Title title ;
	public String getDoctJob() {
		return doctJob;
	}

	public void setDoctJob(String doctJob) {
		this.doctJob = doctJob;
	}

	public String getDoctPassword() {
		return doctPassword;
	}

	public void setDoctPassword(String doctPassword) {
		this.doctPassword = doctPassword;
	}

	public int getDoctId() {
		return doctId;
	}

	public void setDoctId(int doctId) {
		this.doctId = doctId;
	}

	public String getDoctName() {
		return doctName;
	}

	public void setDoctName(String doctName) {
		this.doctName = doctName;
	}

	public int getDeptNo() {
		return deptNo;
	}

	public void setDeptNo(int deptNo) {
		this.deptNo = deptNo;
	}

	public String getDoctPro() {
		return doctPro;
	}

	public void setDoctPro(String doctPro) {
		this.doctPro = doctPro;
	}

	public int getDoctNum() {
		return doctNum;
	}

	public void setDoctNum(int doctNum) {
		this.doctNum = doctNum;
	}

	public int getDoctStatus() {
		return doctStatus;
	}

	public void setDoctStatus(int doctStatus) {
		this.doctStatus = doctStatus;
	}

	public String getDoctSalt() {
		return doctSalt;
	}

	public void setDoctSalt(String doctSalt) {
		this.doctSalt = doctSalt;
	}

	public Dept getDept() {
		return dept;
	}

	public void setDept(Dept dept) {
		this.dept = dept;
	}

	public int getDoctInposition() {
		return doctInposition;
	}

	public void setDoctInposition(int doctInposition) {
		this.doctInposition = doctInposition;
	}

	public Date getDoctBirthday() {
		return doctBirthday;
	}

	public void setDoctBirthday(Date doctBirthday) {
		this.doctBirthday = doctBirthday;
	}

	public String getDoctSex() {
		return doctSex;
	}

	public void setDoctSex(String doctSex) {
		this.doctSex = doctSex;
	}

	public Title getTitle() {
		return title;
	}

	public void setTitle(Title title) {
		this.title = title;
	}

	public int getDoctTiltleId() {
		return doctTiltleId;
	}

	public void setDoctTiltleId(int doctTiltleId) {
		this.doctTiltleId = doctTiltleId;
	}
	
}
