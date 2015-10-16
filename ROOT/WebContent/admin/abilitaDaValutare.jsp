<%@ page import="util.LoginToken"%>
<%@ page import="util.LoginToken.TipoAccesso"%>
<%@ page import="entity.Abilita"%>
<%@ page import="java.util.List"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ include file="../header.jsp"%>

<div class="wrapper style1">
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
		<div style="margin-top:30px !important;"class="modificaProfiloContainer">
		
		<div style="" class="titoloBlu">Lista attività da valutare</div>
		<%
			List<Abilita> listaAbilitaDaValutare = (List<Abilita>) session
					.getAttribute("listaAbilitaDaApprovare");
			if (listaAbilitaDaValutare != null
					&& listaAbilitaDaValutare.size() != 0) {
		%>
		<table class="zebra-striped">
			<thead>
				<tr>
					<th>Nome</th>
					<th>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>
					<th>Descrizione</th>
					<th>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>
					<th>Approva</th>
					<th>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>
					<th>Elimina</th>
				</tr>
			</thead>
			<tbody>
				<%
					for (Abilita abilita : listaAbilitaDaValutare) {
				%>
				<tr>
					<td><%=abilita.getNomeAbilita()%></td>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
					<td><%=abilita.getDescrizioneAbilita()%></td>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
					<td><a
						href="GestioneAbilitaServlet?to=approvaAbilita&idAbilita=<%=abilita.getIdAbilita()%>&isApprovata=true">Approva</a></td>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
					<td><a
						href="GestioneAbilitaServlet?to=approvaAbilita&idAbilita=<%=abilita.getIdAbilita()%>&isApprovata=false">Elimina</a></td>
				</tr>
				<%
					}
				%>
			</tbody>
		</table>
		<%
			} else {
		%>
		<strong>Non ci sono attività da approvare.</strong>
		<%
			}
		%>
		</div>
	</section>
</div>
<%@ include file="../footer.jsp"%>
