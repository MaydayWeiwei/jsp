package utile;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class FiltreEntree implements Filter {

	private FilterConfig filterConfig = null;

	public void init(FilterConfig filterConfig) throws ServletException {
		this.filterConfig = filterConfig;

	}

	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain chain) throws IOException, ServletException {
		HttpServletRequest hrequest = (HttpServletRequest) request;
		HttpServletResponse hresponse = (HttpServletResponse) response;
		HttpSession session = hrequest.getSession(true);
		if ((session.getAttribute("nom") == null) || (session.getAttribute("prenom") == null)) {
			hresponse.sendRedirect("../index.jsp");
		} else {
			chain.doFilter(request, response);
		}

	}

	public void destroy() {
		this.filterConfig = null;

	}

}
