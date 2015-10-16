<%@ page import="util.LoginToken"%>
<%@ page import="util.LoginToken.TipoAccesso"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ include file="../header.jsp"%>

<div class="wrapper style1 sfondo">
	<section id="features" class="container special">
		<%
			String errore = (String) session.getAttribute("Errore");
			if (errore != null) {
		%>
		<div class="alert-message error">
			Errore:
			<%=errore.toString()%>
		</div>
		<%
			session.removeAttribute("Errore");
			}
		%>
		<br />
		<div class="loginContainer">
			<div class="logoLogin"></div>
			<div class="titoloBlu">Sign up</div>
			<br />
			<form enctype="multipart/form-data"
				action="RegistrazioneServlet?to=salvaDatiUtente" method="post">


				<div class="clearfix">

					<div class="input ">
						<input class="input-medium inputLogin" type="text" name="nome"
							placeholder="Nome" />
					</div>
				</div>


				<div class="clearfix">

					<div class="input ">
						<input class="input-medium inputLogin" type="text" name="cognome"
							placeholder="cognome" />
					</div>
				</div>


				<div class="clearfix">

					<div class="input ">
						<input class="input-medium inputLogin" type="text" name="email"
							placeholder="Email" />
					</div>
				</div>



				<div class="clearfix">

					<div class="input-medium ">
						<input class="input-medium inputLogin" type="password"
							name="password" placeholder="Password" />
					</div>
				</div>

				<div class="clearfix">

					<div class="input ">
						<input class="input-medium inputLogin" type="password"
							name="confermaPassword" placeholder="Conferma password" />
					</div>
				</div>


				<!-- <div class="clearfix">
							<label for="fileInput">Foto</label>
							<div class="input">
								<input id="fileInput" class="input-file" type="file" name="foto">
									<span class="help-block"> Deve avere estensione jpg, png
										o gif e dimensione inferiore a 1Mb </span>
							</div>
						</div>
						<br /> <br /> -->
						<div class="responsiveContainerButton">
				
					<button style=""
						class="btn primary bottone" type="submit">Registra</button>
					
			
				</div>
				<br />
			</form>
		</div>
	</section>
</div>
<%@ include file="../footer.jsp"%>