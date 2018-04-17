package njxz.wangzw.util;

import njxz.wangzw.model.Page;

public class PageUtil {

	/**
	 * @param page
	 * @return 判断之后的page属性值 完整的 新增 stRownum endRownum count
	 */
	public static Page pageChange(Page page) {
		int totalPage = 1;
		int count = page.getCount();
		int limit = page.getLimit();
		int curr = page.getCurr();
		if (count % limit == 0) {
			totalPage = count / limit;
		} else {
			totalPage = count / limit + 1;
		}
		if (curr >= totalPage) {
			curr = totalPage;
		}
		if (curr < 1) {
			curr = 1;
		}
		int stRownum = (curr - 1) * limit + 1;
		int endRownum = stRownum + limit - 1;
		page.setStRownum(stRownum);
		page.setEndRownum(endRownum);
		page.setTotalPage(totalPage);
		page.setCurr(curr);
		return page;
	}
}
