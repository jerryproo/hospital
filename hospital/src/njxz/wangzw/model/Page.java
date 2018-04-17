package njxz.wangzw.model;

public class Page {

	private int curr;//当前页
	private int count;// 检索的所有的数据的总数
	private int limit;//每页存储的数据条数  
	private int stRownum; //在数据库里面查找 开始的序列号
	private int endRownum; // 在数据库里面查找 开始的序列号
	private int totalPage; //所有 的页数



	public int getCurr() {
		return curr;
	}

	public void setCurr(int curr) {
		this.curr = curr;
	}

	public int getLimit() {
		return limit;
	}

	public void setLimit(int limit) {
		this.limit = limit;
	}

	public int getTotalPage() {
		return totalPage;
	}

	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}

	public int getCount() {
		return count;
	}

	public void setCount(int count) {
		this.count = count;
	}

	public int getStRownum() {
		return stRownum;
	}

	public void setStRownum(int stRownum) {
		this.stRownum = stRownum;
	}

	public int getEndRownum() {
		return endRownum;
	}

	public void setEndRownum(int endRownum) {
		this.endRownum = endRownum;
	}


}
