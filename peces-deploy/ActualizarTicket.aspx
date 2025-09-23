<%@ Page Title="Actualizar Ticket" Language="C#" MasterPageFile="~/MPSitio.Master" AutoEventWireup="true" CodeBehind="ActualizarTicket.aspx.cs" Inherits="peces.Ticket.ActualizarTicket" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .formTable {
            width: 100%;
            border-collapse: collapse;
        }
        .formTable td {
            padding: 8px;
        }
        .formLabel {
            width: 30%;
            text-align: right;
            font-weight: bold;
        }
        .formInput {
            width: 70%;
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
        .validationSummary {
            color: #a94442;
            background-color: #f2dede;
            border: 1px solid #ebccd1;
            padding: 10px;
            margin: 10px 0;
            border-radius: 4px;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h2>Actualizar Ticket</h2>
    
    <asp:Panel ID="pnlMensaje" runat="server" Visible="false" CssClass="message">
        <asp:Literal ID="litMensaje" runat="server"></asp:Literal>
    </asp:Panel>
    
    <!-- Resumen de validaciones -->
    <asp:ValidationSummary ID="vsActualizarTicket" runat="server" DisplayMode="BulletList" CssClass="validationSummary" 
        HeaderText="Por favor, corrija los siguientes errores:" ValidationGroup="vgActualizarTicket" />
    
    <asp:Panel ID="pnlFormulario" runat="server">
        <asp:HiddenField ID="hfTicketId" runat="server" />
        
        <table class="formTable">
            <tr>
                <td colspan="2" class="sectionHeader">Información del Ticket</td>
            </tr>
            <tr>
                <td class="formLabel">ID:</td>
                <td class="formInput">
                    <asp:Label ID="lblId" runat="server"></asp:Label>
                </td>
            </tr>
            <tr>
                <td class="formLabel">Producto:</td>
                <td class="formInput">
                    <asp:TextBox ID="txtProducto" runat="server" Width="60%"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvProducto" runat="server" ControlToValidate="txtProducto" 
                        ErrorMessage="El producto es requerido" ForeColor="Red" Display="None" ValidationGroup="vgActualizarTicket"></asp:RequiredFieldValidator>
                    <asp:CustomValidator ID="cvProductoLength" runat="server" ControlToValidate="txtProducto"
                        ErrorMessage="El nombre del producto debe tener al menos 10 caracteres" ForeColor="Red" Display="None"
                        OnServerValidate="cvProductoLength_ServerValidate" ValidationGroup="vgActualizarTicket"></asp:CustomValidator>
                </td>
            </tr>
            <tr>
                <td class="formLabel">Descripción:</td>
                <td class="formInput">
                    <asp:TextBox ID="txtDescripcion" runat="server" TextMode="MultiLine" Rows="4" Width="60%"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvDescripcion" runat="server" ControlToValidate="txtDescripcion" 
                        ErrorMessage="La descripción es requerida" ForeColor="Red" Display="None" ValidationGroup="vgActualizarTicket"></asp:RequiredFieldValidator>
                    <asp:CustomValidator ID="cvDescripcionLength" runat="server" ControlToValidate="txtDescripcion"
                        ErrorMessage="La descripción debe tener al menos 10 caracteres" ForeColor="Red" Display="None"
                        OnServerValidate="cvDescripcionLength_ServerValidate" ValidationGroup="vgActualizarTicket"></asp:CustomValidator>
                </td>
            </tr>
            <tr>
                <td class="formLabel">Estado:</td>
                <td class="formInput">
                    <asp:DropDownList ID="ddlEstado" runat="server">
                        <asp:ListItem Text="Seleccionar" Value="" Enabled="false"></asp:ListItem>
                        <asp:ListItem Text="Pendiente" Value="Pendiente"></asp:ListItem>
                        <asp:ListItem Text="En Proceso" Value="En Proceso"></asp:ListItem>
                        <asp:ListItem Text="Completado" Value="Completado"></asp:ListItem>
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator ID="rfvEstado" runat="server" ControlToValidate="ddlEstado" 
                        ErrorMessage="Seleccione un estado" ForeColor="Red" Display="None" ValidationGroup="vgActualizarTicket"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td class="formLabel">Fecha de Creación:</td>
                <td class="formInput">
                    <asp:Label ID="lblFechaCreacion" runat="server"></asp:Label>
                </td>
            </tr>
            
            <tr>
                <td colspan="2" class="sectionHeader">Información del Cliente</td>
            </tr>
            <tr>
                <td class="formLabel">Tipo de Cliente:</td>
                <td class="formInput">
                    <asp:Label ID="lblTipoCliente" runat="server"></asp:Label>
                </td>
            </tr>
            <tr>
                <td class="formLabel">Nombre:</td>
                <td class="formInput">
                    <asp:Label ID="lblNombre" runat="server"></asp:Label>
                </td>
            </tr>
            <tr>
                <td class="formLabel">RUT:</td>
                <td class="formInput">
                    <asp:Label ID="lblRut" runat="server"></asp:Label>
                </td>
            </tr>
            <tr>
                <td class="formLabel">Teléfono:</td>
                <td class="formInput">
                    <asp:TextBox ID="txtTelefono" runat="server" Width="60%"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvTelefono" runat="server" ControlToValidate="txtTelefono" 
                        ErrorMessage="El teléfono es requerido" ForeColor="Red" Display="None" ValidationGroup="vgActualizarTicket"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td class="formLabel">Email:</td>
                <td class="formInput">
                    <asp:TextBox ID="txtEmail" runat="server" Width="60%"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="txtEmail" 
                        ErrorMessage="El email es requerido" ForeColor="Red" Display="None" ValidationGroup="vgActualizarTicket"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="revEmail" runat="server" ControlToValidate="txtEmail"
                        ErrorMessage="Ingrese un email válido" ForeColor="Red" Display="None"
                        ValidationExpression="^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$" ValidationGroup="vgActualizarTicket"></asp:RegularExpressionValidator>
                </td>
            </tr>
            <tr id="trRazonSocial" runat="server" visible="false">
                <td class="formLabel">Razón Social:</td>
                <td class="formInput">
                    <asp:Label ID="lblRazonSocial" runat="server"></asp:Label>
                </td>
            </tr>
        </table>
        
        <div class="btnContainer">
            <asp:Button ID="btnVolver" runat="server" Text="Volver" CssClass="btn btnDefault" OnClick="btnVolver_Click" CausesValidation="false" />
            <asp:Button ID="btnGuardar" runat="server" Text="Guardar Cambios" CssClass="btn btnPrimary" OnClick="btnGuardar_Click" ValidationGroup="vgActualizarTicket" />
        </div>
    </asp:Panel>
</asp:Content>