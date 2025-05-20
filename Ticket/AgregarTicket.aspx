<%@ Page Title="Agregar Ticket" Language="C#" MasterPageFile="~/MPSitio.Master" AutoEventWireup="true" CodeBehind="AgregarTicket.aspx.cs" Inherits="peces.Ticket.AgregarTicket" %>

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
        .btnSubmit {
            padding: 8px 20px;
            margin-top: 20px;
            background-color: #0066cc;
            color: white;
            border: none;
            cursor: pointer;
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
    <h2>Agregar Nuevo Ticket</h2>

    <!-- Resumen de validaciones -->
    <asp:ValidationSummary ID="vsCrearTicket" runat="server" DisplayMode="BulletList" CssClass="validationSummary" 
        HeaderText="Por favor, corrija los siguientes errores:" ValidationGroup="vgCrearTicket" />

    <table class="formTable">
        <!-- Datos del Cliente -->
        <tr>
            <td colspan="2"><h3>Datos del Cliente</h3></td>
        </tr>
        <tr>
            <td class="formLabel">Tipo de Cliente:</td>
            <td class="formInput">
                <asp:DropDownList ID="ddlTipoCliente" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlTipoCliente_SelectedIndexChanged">
                    <asp:ListItem Text="Seleccionar" Value="" Enabled="false" Selected="True"></asp:ListItem>
                    <asp:ListItem Text="Persona Natural" Value="PersonaNatural"></asp:ListItem>
                    <asp:ListItem Text="Empresa" Value="Empresa"></asp:ListItem>
                </asp:DropDownList>
                <asp:RequiredFieldValidator ID="rfvTipoCliente" runat="server" ControlToValidate="ddlTipoCliente" 
                    ErrorMessage="Seleccione un tipo de cliente" ForeColor="Red" Display="None" ValidationGroup="vgCrearTicket"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td class="formLabel">Nombre:</td>
            <td class="formInput">
                <asp:TextBox ID="txtNombre" runat="server" Width="60%"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvNombre" runat="server" ControlToValidate="txtNombre" 
                    ErrorMessage="El nombre es requerido" ForeColor="Red" Display="None" ValidationGroup="vgCrearTicket"></asp:RequiredFieldValidator>
                <asp:CustomValidator ID="cvNombreLength" runat="server" ControlToValidate="txtNombre"
                    ErrorMessage="El nombre debe tener al menos 5 caracteres" ForeColor="Red" Display="None"
                    OnServerValidate="cvNombreLength_ServerValidate" ValidationGroup="vgCrearTicket"></asp:CustomValidator>
            </td>
        </tr>
        <tr>
            <td class="formLabel">RUT:</td>
            <td class="formInput">
                <asp:TextBox ID="txtRut" runat="server" Width="60%"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvRut" runat="server" ControlToValidate="txtRut" 
                    ErrorMessage="El RUT es requerido" ForeColor="Red" Display="None" ValidationGroup="vgCrearTicket"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="revRut" runat="server" ControlToValidate="txtRut"
                    ErrorMessage="Formato de RUT inválido. Debe ser: 12345678-9" ForeColor="Red" Display="None"
                    ValidationExpression="^(\d{8,9}-[\dkK])$" ValidationGroup="vgCrearTicket"></asp:RegularExpressionValidator>
            </td>
        </tr>
        <tr>
            <td class="formLabel">Teléfono:</td>
            <td class="formInput">
                <asp:TextBox ID="txtTelefono" runat="server" Width="60%"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvTelefono" runat="server" ControlToValidate="txtTelefono" 
                    ErrorMessage="El teléfono es requerido" ForeColor="Red" Display="None" ValidationGroup="vgCrearTicket"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td class="formLabel">Email:</td>
            <td class="formInput">
                <asp:TextBox ID="txtEmail" runat="server" Width="60%"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="txtEmail" 
                    ErrorMessage="El email es requerido" ForeColor="Red" Display="None" ValidationGroup="vgCrearTicket"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="revEmail" runat="server" ControlToValidate="txtEmail"
                    ErrorMessage="Ingrese un email válido" ForeColor="Red" Display="None"
                    ValidationExpression="^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$" ValidationGroup="vgCrearTicket"></asp:RegularExpressionValidator>
            </td>
        </tr>
        <tr id="trRazonSocial" runat="server" visible="false">
            <td class="formLabel">Razón Social:</td>
            <td class="formInput">
                <asp:TextBox ID="txtRazonSocial" runat="server" Width="60%"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvRazonSocial" runat="server" ControlToValidate="txtRazonSocial" 
                    ErrorMessage="La razón social es requerida" ForeColor="Red" Display="None" ValidationGroup="vgCrearTicket" Enabled="false"></asp:RequiredFieldValidator>
            </td>
        </tr>

        <!-- Datos del Ticket -->
        <tr>
            <td colspan="2"><h3>Datos del Ticket</h3></td>
        </tr>
        <tr>
            <td class="formLabel">Producto:</td>
            <td class="formInput">
                <asp:TextBox ID="txtProducto" runat="server" Width="60%"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvProducto" runat="server" ControlToValidate="txtProducto" 
                    ErrorMessage="El producto es requerido" ForeColor="Red" Display="None" ValidationGroup="vgCrearTicket"></asp:RequiredFieldValidator>
                <asp:CustomValidator ID="cvProductoLength" runat="server" ControlToValidate="txtProducto"
                    ErrorMessage="El nombre del producto debe tener al menos 10 caracteres" ForeColor="Red" Display="None"
                    OnServerValidate="cvProductoLength_ServerValidate" ValidationGroup="vgCrearTicket"></asp:CustomValidator>
            </td>
        </tr>
        <tr>
            <td class="formLabel">Descripción:</td>
            <td class="formInput">
                <asp:TextBox ID="txtDescripcion" runat="server" TextMode="MultiLine" Rows="4" Width="60%"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvDescripcion" runat="server" ControlToValidate="txtDescripcion" 
                    ErrorMessage="La descripción es requerida" ForeColor="Red" Display="None" ValidationGroup="vgCrearTicket"></asp:RequiredFieldValidator>
                <asp:CustomValidator ID="cvDescripcionLength" runat="server" ControlToValidate="txtDescripcion"
                    ErrorMessage="La descripción debe tener al menos 10 caracteres" ForeColor="Red" Display="None"
                    OnServerValidate="cvDescripcionLength_ServerValidate" ValidationGroup="vgCrearTicket"></asp:CustomValidator>
            </td>
        </tr>
        <tr>
            <td class="formLabel">Estado:</td>
            <td class="formInput">
                <asp:DropDownList ID="ddlEstado" runat="server">
                    <asp:ListItem Text="Seleccionar" Value="" Enabled="false" Selected="True"></asp:ListItem>
                    <asp:ListItem Text="Pendiente" Value="Pendiente"></asp:ListItem>
                    <asp:ListItem Text="En Proceso" Value="En Proceso"></asp:ListItem>
                    <asp:ListItem Text="Completado" Value="Completado"></asp:ListItem>
                </asp:DropDownList>
                <asp:RequiredFieldValidator ID="rfvEstado" runat="server" ControlToValidate="ddlEstado" 
                    ErrorMessage="Seleccione un estado" ForeColor="Red" Display="None" ValidationGroup="vgCrearTicket"></asp:RequiredFieldValidator>
            </td>
        </tr>
        
        <!-- Botón para enviar -->
        <tr>
            <td colspan="2" style="text-align: center;">
                <asp:Button ID="btnGuardar" runat="server" Text="Guardar Ticket" CssClass="btnSubmit" OnClick="btnGuardar_Click" ValidationGroup="vgCrearTicket" />
            </td>
        </tr>
    </table>
</asp:Content>