<%@ page import="util.LoginToken"%>
<%@ page import="util.LoginToken.TipoAccesso"%>
<%@ page import="entity.Abilita"%>
<%@ page import="java.util.List"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="en">
<head>
<title>SWIMv2 - Admin - Lista Abilità</title>
<meta name="description" content="Admin - Lista Abilità" />
<meta charset="utf-8" />
<link rel="stylesheet" href="css/reset.css" type="text/css" media="all" />
<link rel="stylesheet" href="css/layout.css" type="text/css" media="all" />
<link rel="stylesheet" href="css/style.css" type="text/css" media="all" />
<script type="text/javascript" src="js/jquery-1.4.2.min.js"></script>
<script type="text/javascript" src="js/script.js"></script>
<!--[if lt IE 7]>
	<link rel="stylesheet" href="css/ie6.css" type="text/css" media="screen">
	<script type="text/javascript" src="js/ie_png.js"></script>
	<script type="text/javascript">
		ie_png.fix('.png');
	</script>
<![endif]-->
<!--[if lt IE 9]>
	<script type="text/javascript" src="js/html5.js"></script>
<![endif]-->
</head>
<body id="page3">
	<div class="tail-bottom">
		<div id="main">
			<!-- header -->
			<header>
			<div class="nav-box">
				<nav>
				<ul>
					<li class="current"><a
						href="GestioneAbilitaServlet?to=redirectToPaginaListaAbilitaAdmin">Lista
							Abilità</a></li>
					<li><a
						href="GestioneAbilitaServlet?to=redirectToPaginaAbilitaDaValutare">Abilità
							da valutare</a></li>
				</ul>
				</nav>
			</div>
			<h1>
				<a href="index.jsp">SWIMv2</a>
			</h1>
			</header>
			<div class="wrapper indent">
				<!-- content -->
				<section id="content">
				<div>
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
					<%
						String successo = (String) session.getAttribute("Successo");
						if (successo != null) {
					%>
					<div class="alert-message info">
						<%=successo.toString()%>
					</div>
					<%
						session.removeAttribute("Successo");
						}
					%>
					<br />
					<h2>Lista Abilità</h2>
					<%
						List<Abilita> listaAbilita = (List<Abilita>) session
								.getAttribute("listaAbilita");
						if (listaAbilita != null && listaAbilita.size() != 0) {
					%>
					<table class="zebra-striped">
						<thead>
							<tr>
								<th>Nome</th>
								<th>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>
								<th>Descrizione</th>
								<th>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>
								<th>Modifica</th>
								<th>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>
								<th>Elimina</th>
							</tr>
						</thead>
						<tbody>
							<%
								for (Abilita abilita : listaAbilita) {
							%>
							<tr>
								<td><%=abilita.getNomeAbilita()%></td>
								<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
								<td><%=abilita.getDescrizioneAbilita()%></td>
								<td>&nbsp;&nbsp;&nbsp;</td>
								<td><a
									href="GestioneAbilitaServlet?to=redirectToPaginaModificaAbilita&idAbilita=<%=abilita.getIdAbilita()%>">Modifica</a></td>
								<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
								<td><a
									href="GestioneAbilitaServlet?to=eliminaAbilita&idAbilita=<%=abilita.getIdAbilita()%>">Elimina</a></td>
							</tr>
							<%
								}
							%>
						</tbody>
					</table>
					<%
						} else {
					%>
					<strong>Non ci sono abilità.</strong>
					<%
						}
					%>

					<div class="well">
						<br /> <a
							href="GestioneAbilitaServlet?to=redirectToPaginaCreazioneAbilita">Crea
							una nuova abilità</a>
					</div>
				</div>
				</section>
				<!-- aside -->
				<aside>
				<div class="inside">
					<div class="well">
						<%
							LoginToken tok = (LoginToken) session.getAttribute("LoginToken");
							if (tok != null
									&& tok.getRequiredAccess() == TipoAccesso.Amministratore) { //già loggato.
						%>
						Benvenuto/a, <br />
						<%=tok.getEmail() + "!"%>
						<%
							} else {
								response.sendRedirect("../index.jsp");
							}
						%>
					</div>
					<br /> <br />
					<div class="well">
						<table class="zebra-striped">
							<tbody>
								<tr>
									<td><%=tok.getNome()%><br /><%=tok.getCognome()%></td>
								</tr>
							</tbody>
						</table>
					</div>
					<br /> <br />
					<div>
						<a href="./AutenticazioneServlet?to=logout">Logout</a>
					</div>
				</div>
				</aside>
			</div>
			<!-- footer -->
			<footer>
			<div class="inside">Sviluppato da Marco Tagliabue
			</div>
			</footer>
		</div>
	</div>
</body>
</html>