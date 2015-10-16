<%@ page import="util.LoginToken"%>
<%@ page import="util.LoginToken.TipoAccesso"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<head>
<title>Shareminutes</title>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<meta name="description" content="Shareminutes" />
<meta name="keywords" content="" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">


<!--[if lte IE 8]><script src="css/ie/html5shiv.js"></script><![endif]-->
<script src="js/jquery.min.js"></script>
<script src="js/jquery.dropotron.min.js"></script>
<script src="js/jquery.scrolly.min.js"></script>
<script src="js/jquery.onvisible.min.js"></script>
<script src="js/skel.min.js"></script>

<script src="js/init.js"></script>
<script src="https://www.paypalobjects.com/js/external/dg.js"></script>
<script>
	var dgFlow = new PAYPAL.apps.DGFlow({
		trigger : 'submitBtn'
	});
</script>


<link rel="stylesheet" href="css/skel.css" type='text/css' />
<link rel="stylesheet" href="css/style.css" type='text/css' />
<link rel="stylesheet" href="css/styleFont.css" type='text/css' />
<link rel="stylesheet" href="css/style-desktop.css" type='text/css' />
<link rel="stylesheet" href="css/style-noscript.css" type='text/css' />
<link rel="stylesheet" href="font-awesome/css/font-awesome.min.css"
	type='text/css' />
<!--[if lte IE 8]><link rel="stylesheet" href="css/ie/v8.css" /><![endif]-->
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css"
	type='text/css' />
<script src="//code.jquery.com/jquery-1.10.2.js"></script>
<script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
<script type="text/javascript">
	$(function() {
		$("#datepicker").datepicker();
		//window.location.reload();
		//document.getElementById("orario").style.display = "none";
	});
</script>
<link href='http://fonts.googleapis.com/css?family=Montserrat'
	rel='stylesheet' type='text/css'>
</head>

<div class="wrapper style1 fixedImg">
	<div class="divSlider">
		<img class="imgLanding" src="../images/landingBackground.jpg" />
		<div class="fraseLanding2">Sta arrivando la community di</div>
		<img class="logoLanding" src="../images/logoFullWhite.png" />
		<div class="fraseLanding">Il marketplace dove vendere e comprare
			attività con altri utenti in tutto il mondo.</div>
		<div class="fraseMobile">Distinguiti e accendi il tuo talento!</div>
	</div>
</div>
<div class="landingInput animated bounceInUp">
	<div class="fraseLanding3">Il marketplace dove vendere e comprare
		attività con altri utenti in tutto il mondo.</div>
	<div class="lasciaNome">Registrati per ricevere l'invito ed
		essere sempre informato sulle novità della community di Shareminutes</div>
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
	<div class="alert-message success">Grazie per esserti iscritto.
		Riceverai la nostra newsletter a breve.</div>
	<%
		session.removeAttribute("Successo");
		}
	%>


	<form action="RegistrazioneServlet?to=salvaDatiLanding" method="post">

		<div class="landingNome">
			<div class="input ">
				<input class="input-medium inputLanding" type="text" name="nome"
					placeholder="Nome" />
			</div>
		</div>

		<!-- <div class="landingCognome">
<div class="input ">
<input class="input-medium inputLanding" type="text" name="cognome"
placeholder="Cognome" />
</div>
</div> -->
		<div class="landingMail">
			<div class="input ">
				<input class="input-medium inputLanding" type="text" name="email"
					placeholder="Email" />
			</div>
		</div>
		<div class="landingAbilita">
			<div class="input ">
				<input class="input-medium inputLanding" type="text" name="abilita"
					placeholder="Che attivita' faresti?" />
			</div>
		</div>

		<div class="responsiveContainerButton">

			<button style="margin-bottom: 10px;" class="btn primary bottone"
				type="submit">Subscribe</button>


		</div>
		<br />
	</form>
</div>

<div class="horizontalScroll" style="">
	<img class="landingVendi" src="images/vendi.jpg" />
</div>
<div class="horizontalScroll" style="">
	<img class="landingCompra" src="images/compra.jpg" />

	<section id="features" class="container special">

		<div class="copyright">Shareminutes S.r.l. Partita IVA:
			09109200965</div>


	</section>
</div>
