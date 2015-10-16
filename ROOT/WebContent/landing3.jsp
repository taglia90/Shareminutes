<%@ page import="util.LoginToken"%>
<%@ page import="util.LoginToken.TipoAccesso"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
pageEncoding="ISO-8859-1"%>

<head>
<title>Shareminutes</title>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<meta name="description" content="Shareminutes" />
<meta name="keywords" content="" />

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


<link rel="stylesheet" href="css/skel.css" />
<link rel="stylesheet" href="css/style.css" />
<link rel="stylesheet" href="css/styleFont.css" />
<link rel="stylesheet" href="css/style-desktop.css" />
<link rel="stylesheet" href="css/style-noscript.css" />
<link rel="stylesheet" href="font-awesome/css/font-awesome.min.css" />
<!--[if lte IE 8]><link rel="stylesheet" href="css/ie/v8.css" /><![endif]-->
<link rel="stylesheet"
href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css" />
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

<div class="wrapper style1 ">
<div class="divSlider">
<img class="imgLanding" src="../images/landingBackground.jpg"/>
<div class="fraseLanding2">Sta arrivando la community di</div>
<img class="logoLanding" src="../images/logoFullWhite.png"/>
<div class="fraseLanding"> Il marketplace dove vendere e comprare attività con altri utenti in tutto il mondo.
<br>
<br>
Distinguiti e accendi il tuo talento!</div>

</div>
</div>
<div class="landingInput animated bounceInUp">
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
<div class="alert-message info alertLanding">Grazie per esserti
iscritto. Riceverai la nostra newsletter a breve.</div>
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

<button style="" class="btn primary bottone" type="submit">Subscribe</button>


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

<br />


</section>
</div>
