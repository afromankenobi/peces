<%@ Page Title="Home" Language="C#" MasterPageFile="~/MPSitio.Master" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="peces.Home" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div style="text-align: center; margin-top: 50px;">
        <h1>Bienvenido!</h1>
        <p style="font-size: 20px;">Ingresa un ticket de soporte para empezar!</p>
        <p style="margin-top: 30px;">
            <asp:Button ID="btnIrAgregarTicket" runat="server" Text="Agregar Ticket" OnClick="btnIrAgregarTicket_Click" CssClass="btn btn-primary" />
        </p>
    </div>
</asp:Content>