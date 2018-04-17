package njxz.wangzw.util;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.AbstractInterceptor;

public class LoginInterceptor extends AbstractInterceptor {
	private static final long serialVersionUID = -5264927090749824334L;
	@Override
	public void init() {
	}

	@Override
	public String intercept(ActionInvocation invocation) throws Exception {
		String result = "";
		String method=invocation.getProxy().getMethod();//访问的方法
		Object seesion =ServletActionContext.getRequest().getSession().getAttribute("sessionUser");
		String username=ServletActionContext.getRequest().getParameter("user.userName");
		if ((seesion == null|| "".equals(seesion))&&!"login".equals(method)&&!"logout".equals(method)){
			return "errorLogin";
		} else if((username==null||"".equals(username))&&"login".equals(method)){
			return "errorLogin";
		}
		result = invocation.invoke();
		return result;
	}
	@Override
	public void destroy() {
	}
}
