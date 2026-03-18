<%@ Page Title="Theater Management" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="TheaterForm.aspx.cs" Inherits="Forms_Basic_TheaterForm" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<div class="page-header"><h3><i class="bi bi-building"></i> Theater (TheaterCityHall) Management</h3></div>
<asp:Label ID="lblMsg" runat="server" CssClass="alert alert-info d-block mb-3" Visible="false" />

<div class="card mb-4">
  <div class="card-header"><asp:Label ID="lblFormTitle" runat="server" Text="Add New Theater" /></div>
  <div class="card-body">
    <asp:HiddenField ID="hfTheaterId" runat="server" />
    <div class="row g-3">
      <div class="col-md-4">
        <label class="form-label">Theater Name *</label>
        <asp:TextBox ID="txtName" runat="server" CssClass="form-control" />
        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtName" ErrorMessage="Required" CssClass="text-danger small" Display="Dynamic" />
      </div>
      <div class="col-md-4">
        <label class="form-label">City *</label>
        <asp:TextBox ID="txtCity" runat="server" CssClass="form-control" />
        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtCity" ErrorMessage="Required" CssClass="text-danger small" Display="Dynamic" />
      </div>
      <div class="col-md-4">
        <label class="form-label">Type</label>
        <asp:DropDownList ID="ddlType" runat="server" CssClass="form-select">
          <asp:ListItem>Multiplex</asp:ListItem>
          <asp:ListItem>Single Screen</asp:ListItem>
          <asp:ListItem>Drive-In</asp:ListItem>
          <asp:ListItem>IMAX</asp:ListItem>
        </asp:DropDownList>
      </div>
    </div>
    <div class="mt-3">
      <asp:Button ID="btnSave" runat="server" Text="Save" CssClass="btn btn-danger me-2" OnClick="btnSave_Click" />
      <asp:Button ID="btnClear" runat="server" Text="Clear" CssClass="btn btn-secondary" OnClick="btnClear_Click" CausesValidation="false" />
    </div>
  </div>
</div>

<div class="card">
  <div class="card-header">Theater List</div>
  <div class="card-body p-0">
    <asp:GridView ID="gvList" runat="server" CssClass="table table-hover table-sm mb-0"
        AutoGenerateColumns="false" DataKeyNames="TheaterId" OnRowCommand="gvList_RowCommand">
      <Columns>
        <asp:BoundField DataField="TheaterId" HeaderText="ID" />
        <asp:BoundField DataField="TheaterName" HeaderText="Name" />
        <asp:BoundField DataField="TheaterCity" HeaderText="City" />
        <asp:BoundField DataField="TheatreType" HeaderText="Type" />
        <asp:TemplateField HeaderText="Actions">
          <ItemTemplate>
            <asp:LinkButton runat="server" CommandName="EditRow" CommandArgument='<%# Eval("TheaterId") %>' CssClass="btn btn-sm btn-warning btn-action"><i class="bi bi-pencil"></i> Edit</asp:LinkButton>
            <asp:LinkButton runat="server" CommandName="DeleteRow" CommandArgument='<%# Eval("TheaterId") %>' CssClass="btn btn-sm btn-danger btn-action" OnClientClick="return confirm('Delete?')"><i class="bi bi-trash"></i> Delete</asp:LinkButton>
          </ItemTemplate>
        </asp:TemplateField>
      </Columns>
    </asp:GridView>
  </div>
</div>
</asp:Content>
