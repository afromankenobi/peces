<%@ Page Title="Detalle Ticket" Language="C#" MasterPageFile="~/MPSitio.Master" AutoEventWireup="true" CodeBehind="DetalleTicket.aspx.cs" Inherits="peces.Ticket.DetalleTicket" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .detailTable {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        .detailTable th {
            background-color: #507CD1;
            color: white;
            font-weight: bold;
            padding: 8px;
            text-align: right;
            width: 30%;
        }
        .detailTable td {
            padding: 8px;
            background-color: #EFF3FB;
        }
        .sectionHeader {
            background-color: #2461BF;
            color: white;
            padding: 8px;
            font-weight: bold;
        }
        .btnContainer {
            margin-top: 20px;
            text-align: center;
        }
        .btn {
            padding: 8px 20px;
            margin: 0 10px;
            cursor: pointer;
            border: none;
            border-radius: 4px;
        }
        .btnPrimary {
            background-color: #0066cc;
            color: white;
        }
        .btnDefault {
            background-color: #f2f2f2;
            color: #333;
        }
        .message {
            padding: 10px;
            margin-bottom: 20px;
            border-radius: 4px;
            background-color: #f2dede;
            color: #a94442;
            border: 1px solid #ebccd1;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h2>Detalle del Ticket</h2>
    
    <asp:Panel ID="pnlMensaje" runat="server" Visible="false" CssClass="message">
        <asp:Literal ID="litMensaje" runat="server"></asp:Literal>
    </asp:Panel>
    
    <asp:Panel ID="pnlDetalle" runat="server">
        <table class="detailTable">
            <tr>
                <td colspan="2" class="sectionHeader">Información del Ticket</td>
            </tr>
            <tr>
                <th>ID:</th>
                <td><asp:Label ID="lblId" runat="server"></asp:Label></td>
            </tr>
            <tr>
                <th>Producto:</th>
                <td><asp:Label ID="lblProducto" runat="server"></asp:Label></td>
            </tr>
            <tr>
                <th>Descripción:</th>
                <td><asp:Label ID="lblDescripcion" runat="server"></asp:Label></td>
            </tr>
            <tr>
                <th>Estado:</th>
                <td><asp:Label ID="lblEstado" runat="server"></asp:Label></td>
            </tr>
            <tr>
                <th>Fecha de Creación:</th>
                <td><asp:Label ID="lblFechaCreacion" runat="server"></asp:Label></td>
            </tr>
            
            <tr>
                <td colspan="2" class="sectionHeader">Información del Cliente</td>
            </tr>
            <tr>
                <th>Tipo de Cliente:</th>
                <td><asp:Label ID="lblTipoCliente" runat="server"></asp:Label></td>
            </tr>
            <tr>
                <th>Nombre:</th>
                <td><asp:Label ID="lblNombre" runat="server"></asp:Label></td>
            </tr>
            <tr>
                <th>RUT:</th>
                <td><asp:Label ID="lblRut" runat="server"></asp:Label></td>
            </tr>
            <tr>
                <th>Teléfono:</th>
                <td><asp:Label ID="lblTelefono" runat="server"></asp:Label></td>
            </tr>
            <tr>
                <th>Email:</th>
                <td><asp:Label ID="lblEmail" runat="server"></asp:Label></td>
            </tr>
            <tr id="trRazonSocial" runat="server" visible="false">
                <th>Razón Social:</th>
                <td><asp:Label ID="lblRazonSocial" runat="server"></asp:Label></td>
            </tr>
        </table>
        
        <div class="btnContainer">
            <asp:Button ID="btnVolver" runat="server" Text="Volver" CssClass="btn btnDefault" OnClick="btnVolver_Click" />
            <asp:Button ID="btnActualizar" runat="server" Text="Actualizar" CssClass="btn btnPrimary" OnClick="btnActualizar_Click" />
        </div>
    </asp:Panel>
</asp:Content>