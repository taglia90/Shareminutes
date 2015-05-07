package control;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class GestionePagineServlet extends Servlet {

	private static final long serialVersionUID = 6145985715897698499L;

	@Override
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

	@Override
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		String to = (String) request.getParameter("to");
		if (to.equals("redirectToPaginaCommunity"))
			this.redirectToPaginaCommunity(request, response);
		if (to.equals("redirectToPaginaSell"))
			this.redirectToPaginaSell(request, response);
		if (to.equals("redirectToPaginaBuy"))
			this.redirectToPaginaBuy(request, response);
		if (to.equals("redirectToIndex"))
			this.redirectToIndex(request, response);
		if (to.equals("redirectToGestioneOrdini"))
			this.redirectToGestioneOrdini(request, response);
		if (to.equals("redirectToClientiEFornitori"))
			this.redirectToClientiEFornitori(request, response);
		if (to.equals("redirectToPreferiti"))
			this.redirectToPreferiti(request, response);

	}

	private void redirectToIndex(HttpServletRequest request,
			HttpServletResponse response) {
		redirect("index.jsp", request, response);

	}

	private void redirectToPaginaCommunity(HttpServletRequest request,
			HttpServletResponse response) {
		redirect("pubbliche/community.jsp", request, response);

	}

	private void redirectToPaginaBuy(HttpServletRequest request,
			HttpServletResponse response) {
		redirect("pubbliche/buy.jsp", request, response);

	}

	private void redirectToPaginaSell(HttpServletRequest request,
			HttpServletResponse response) {
		redirect("pubbliche/sell.jsp", request, response);

	}

	private void redirectToGestioneOrdini(HttpServletRequest request,
			HttpServletResponse response) {
		redirect("utente/gestioneOrdini.jsp", request, response);
	}

	private void redirectToClientiEFornitori(HttpServletRequest request,
			HttpServletResponse response) {
		redirect("utente/clientiEFornitori.jsp", request, response);

	}

	private void redirectToPreferiti(HttpServletRequest request,
			HttpServletResponse response) {
		redirect("utente/preferiti.jsp", request, response);

	}

}
