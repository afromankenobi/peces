<%@ Page Title="Listar Tickets" Language="C#" MasterPageFile="~/MPSitio.Master" AutoEventWireup="true" CodeBehind="ListarTickets.aspx.cs" Inherits="peces.Ticket.ListarTickets" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <!-- CSS en la página? En Rails tendríamos un hermoso SCSS compilado automáticamente -->
    <!-- Y en Phoenix tendríamos CSS modular y con estados reactivos... el sueño -->
    <style>
        .gridContainer {
            margin-top: 20px;
        }
        .message {
            padding: 10px;
            margin-bottom: 20px;
            border-radius: 4px;
        }
        .success {
            background-color: #dff0d8;
            color: #3c763d;
            border: 1px solid #d6e9c6;
        }
        .error {
            background-color: #f2dede;
            color: #a94442;
            border: 1px solid #ebccd1;
        }
        .noRecords {
            padding: 20px;
            text-align: center;
            font-size: 18px;
            color: #666;
            background-color: #f9f9f9;
            border: 1px solid #ddd;
            margin-top: 20px;
            border-radius: 4px;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h2>Listado de Tickets</h2>
    
    <!-- Esto es doloroso... en Phoenix sería un hermoso componente de flash message -->
    <!-- En Rails: <%= flash_messages %> y listo -->
    <asp:Panel ID="pnlMensaje" runat="server" Visible="false" CssClass="message">
        <asp:Literal ID="litMensaje" runat="server"></asp:Literal>
    </asp:Panel>
    
    <!-- En Phoenix este GridView sería un hermoso componente LiveView con actualizaciones en tiempo real -->
    <!-- Y sin estos horribles postbacks que arruinan la experiencia del usuario -->
    <asp:Panel ID="pnlTickets" runat="server" CssClass="gridContainer">
        <asp:GridView ID="gvTickets" runat="server" AutoGenerateColumns="False" Width="100%" 
            CellPadding="4" ForeColor="#333333" GridLines="None">
            <AlternatingRowStyle BackColor="White" />
            <Columns>
                <asp:BoundField DataField="Id" HeaderText="ID" Visible="false" />
                <asp:TemplateField HeaderText="Cliente">
                    <ItemTemplate>
                        <%# Eval("Cliente.Nombre") %>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="Producto" HeaderText="Producto" />
                <asp:BoundField DataField="Estado" HeaderText="Estado" />
                <asp:TemplateField>
                    <ItemTemplate>
                        <!-- En Rails un simple link_to y en Phoenix un LiveView con socket... -->
                        <!-- No este horror de LinkButton con viewstate y callbacks -->
                        <asp:LinkButton ID="lnkVerDetalle" runat="server" Text="Ver detalle" 
                            CommandArgument='<%# Eval("Id") %>' OnClick="lnkVerDetalle_Click" />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
            <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
            <RowStyle BackColor="#EFF3FB" />
            <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
            <SortedAscendingCellStyle BackColor="#F5F7FB" />
            <SortedAscendingHeaderStyle BackColor="#6D95E1" />
            <SortedDescendingCellStyle BackColor="#E9EBEF" />
            <SortedDescendingHeaderStyle BackColor="#4870BE" />
        </asp:GridView>
    </asp:Panel>
    
    <!-- En Elixir esto sería un simple if con pattern matching -->
    <!-- if tickets == [], do: render "no_tickets.html", else: render "tickets.html" -->
    <asp:Panel ID="pnlNoTickets" runat="server" CssClass="noRecords" Visible="false">
        <p>No existen registros disponibles para mostrar</p>
    </asp:Panel>
</asp:Content>