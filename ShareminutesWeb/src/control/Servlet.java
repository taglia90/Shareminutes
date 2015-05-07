package control;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import exception.RegistrazioneException;

public class Servlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public Servlet() {
		super();
	}

	protected static void redirect(String page, HttpServletRequest request,
			HttpServletResponse response) {
		try {
			RequestDispatcher dispatcher = request.getRequestDispatcher(page);
			dispatcher.forward(request, response);
		} catch (IOException ex) {
			System.out.println("IOException in Servlet");
			return;
		} catch (ServletException e) {
			System.out.println("ServletException in Servlet");
			e.printStackTrace();
			return;
		}
	}

	protected void forward(String page, HttpServletRequest request,
			HttpServletResponse response) {
		try {
			response.sendRedirect(page);
		} catch (IOException e) {
			System.out.println("IOException in Servlet");
			return;
		}
	}

	@Override
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
	}

	@Override
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
	}

}
