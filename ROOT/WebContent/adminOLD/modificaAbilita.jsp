<%@ page import="util.LoginToken"%>
<%@ page import="util.LoginToken.TipoAccesso"%>
<%@ page import="entity.Abilita"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="en">
<head>
<title>SWIMv2 - Admin - Modifica Abilità</title>
<meta name="description" content="Admin - Modifica Abilità" />
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
					<li><a
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
						LoginToken tok = (LoginToken) session.getAttribute("LoginToken");
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
						Abilita abilita = (Abilita) session.getAttribute("abilita");
					%>
					<br />
					<h2>
						Modifica abilità "<%=abilita.getNomeAbilita()%>"
					</h2>
					<form
						action="GestioneAbilitaServlet?to=modificaAbilita&idAbilita=<%=abilita.getIdAbilita()%>"
						method="post" name="form">
						<div class="clearfix">
							<label>Nome</label>
							<div class="input">
								<input type="text" name="nome"
									value="<%=abilita.getNomeAbilita()%>" />
							</div>
						</div>
						<br /> <br />
						<div class="clearfix">
							<label for="textarea">Descrizione</label>
							<div class="input">
								<textarea id="textarea2" class="xxlarge" rows="10" cols="120"
									name="descrizione"><%=abilita.getDescrizioneAbilita()%></textarea>
							</div>
						</div>
						<br /> <br />
						<div class="actions">
							<button class="btn primary" type="submit">Conferma</button>
							<a
								href="GestioneAbilitaServlet?to=redirectToPaginaListaAbilitaAdmin"
								class="btn">Annulla</a>
						</div>
					</form>
				</div>
				</section>
				<!-- aside -->
				<aside>
				<div class="inside">
					<div class="well">
						<%
							if (tok != null
									&& tok.getRequiredAccess() == TipoAccesso.Amministratore) { //già loggato.
						%>
						Benvenuto/a, <br />
						<%=tok.getEmail() + "!"%>
						<%
							} else {
								response.sendRedirect("index.jsp");
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
			<div class="inside">Sviluppato da Marco Tagliabue</div>
			</footer>
		</div>
	</div>
</body>
</html>