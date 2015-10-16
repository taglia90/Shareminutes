<%@ page import="util.LoginToken"%>
<%@ page import="util.LoginToken.TipoAccesso"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%@ include file="headerSfondo.jsp"%>

<div class=" wrapper style1 sliderHome">

	<div class="containerSlider">

		<h1>
			<a href="GestionePagineServlet?to=redirectToIndex"
				class="testoGrandeHome">PIU' VALORE AL TUO TEMPO</a>
		</h1>
	</div>

	<div class="sottotitoloHome">
		<p>SOTTOTITOLO SHAREMINUTES HOME</p>
	</div>
	<section id="features" class="container special">
		<%
			if (tok != null) {
		%>
		<form action="GestioneRicercheServlet?to=ricercaTag" method="post"
			enctype="multipart/form-data">
			<%
				} else {
			%>
			<form action="GestioneRicercheServlet?to=ricercaUtenteNonLoggato"
				method="post" enctype="multipart/form-data">
				<%
					}
				%>
				<div class="responsiveContainerButton">
					<div class="input">
						<input name="stringa" class="inputHome" type="text" />
					</div>
					<div class="actions">
						<button class="bottone" type="submit">SEARCH</button>
						<!-- <a href="#banner" class="bottone">SEARCH</a> -->
					</div>
				</div>
			</form>
	</section>
</div>
<!-- Features -->
<div class="wrapper style1 sfondoBianco contenitore">

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

	</section>

</div>

<!-- Video -->
<div class="wrapper style1 sfondoBianco spazioRowSopraSotto">
	<section id="features" class="container special video">

		<iframe width="100%" height="100%"
			src="https://www.youtube.com/embed/9Nv7B9vAOYQ" frameborder="0"
			allowfullscreen></iframe>
	</section>
</div>
<!-- Press -->

<div class="wrapper style1 sfondoBianco spazioRowSopraSotto">

	<section id="features" class="container special">
		<header>
			<h2>Press</h2>
		</header>
		<div class="row">
			<article class="4u special">

				<header>
					<h3>
						<a href="#">Gravida aliquam penatibus</a>
					</h3>
				</header>
				<p>Amet nullam fringilla nibh nulla convallis tique ante proin
					sociis accumsan lobortis. Auctor etiam porttitor phasellus tempus
					cubilia ultrices tempor sagittis. Nisl fermentum consequat integer
					interdum.</p>
			</article>
			<article class="4u special">

				<header>
					<h3>
						<a href="#">Sed quis rhoncus placerat</a>
					</h3>
				</header>
				<p>Amet nullam fringilla nibh nulla convallis tique ante proin
					sociis accumsan lobortis. Auctor etiam porttitor phasellus tempus
					cubilia ultrices tempor sagittis. Nisl fermentum consequat integer
					interdum.</p>
			</article>
			<article class="4u special">

				<header>
					<h3>
						<a href="#">Magna laoreet et aliquam</a>
					</h3>
				</header>
				<p>Amet nullam fringilla nibh nulla convallis tique ante proin
					sociis accumsan lobortis. Auctor etiam porttitor phasellus tempus
					cubilia ultrices tempor sagittis. Nisl fermentum consequat integer
					interdum.</p>
			</article>
		</div>

	</section>
</div>
<div class="wrapper style1 sfondoGrigio">
	<section id="features" class="container special ">

		<div class="homeWaiting">
			<div class="waiting">What are you waiting?</div>
			<div class="startWaiting">
				<a href="GestionePagineServlet?to=redirectToPaginaBuy"
					class="bottoneHome">SEARCH TO BUY</a>
			</div>
			<div class="searchWaiting">
				<a href="GestionePagineServlet?to=redirectToPaginaSell"
					class="bottoneHome">START SELLING NOW</a>
			</div>
		</div>
	</section>
</div>


<%@ include file="../footer.jsp"%>